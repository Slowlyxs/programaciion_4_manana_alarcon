import 'package:flutter/material.dart';

class FormularioAeropuerto extends StatefulWidget {
  final void Function(Map<String, String> datos) onGuardar;

  const FormularioAeropuerto({super.key, required this.onGuardar});

  @override
  State<FormularioAeropuerto> createState() => _FormularioAeropuertoState();
}

class _FormularioAeropuertoState extends State<FormularioAeropuerto> {
  final _formKey = GlobalKey<FormState>();

  final _ctrlNombre = TextEditingController();
  final _ctrlCodigoIata = TextEditingController();
  final _ctrlCiudad = TextEditingController();
  final _ctrlPistas = TextEditingController(text: '2');
  final _ctrlOperador = TextEditingController();

  final _focusCodigo = FocusNode();
  final _focusCiudad = FocusNode();
  final _focusPistas = FocusNode();
  final _focusOperador = FocusNode();

  String _categoria = 'Internacional';
  String _estado = 'Operativo';
  bool _internacional = true;

  static final _regexCiudad = RegExp(r'^[A-Za-zÁÉÍÓÚáéíóúÑñ ]{2,}$');
  static final _regexIata = RegExp(r'^[A-Za-z]{3}$');

  @override
  void dispose() {
    _ctrlNombre.dispose();
    _ctrlCodigoIata.dispose();
    _ctrlCiudad.dispose();
    _ctrlPistas.dispose();
    _ctrlOperador.dispose();
    _focusCodigo.dispose();
    _focusCiudad.dispose();
    _focusPistas.dispose();
    _focusOperador.dispose();
    super.dispose();
  }

  void _guardar() {
    if (!_formKey.currentState!.validate()) return;

    widget.onGuardar({
      'nombre': _ctrlNombre.text.trim(),
      'codigoIata': _ctrlCodigoIata.text.trim().toUpperCase(),
      'ciudad': _ctrlCiudad.text.trim(),
      'pistas': _ctrlPistas.text.trim(),
      'operador': _ctrlOperador.text.trim(),
      'estado': _estado,
      'categoria': _categoria,
      'internacional': _internacional.toString(),
    });
  }

  void _limpiar() {
    _formKey.currentState?.reset();
    _ctrlNombre.clear();
    _ctrlCodigoIata.clear();
    _ctrlCiudad.clear();
    _ctrlPistas.text = '2';
    _ctrlOperador.clear();
    setState(() {
      _categoria = 'Internacional';
      _estado = 'Operativo';
      _internacional = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _ctrlNombre,
            decoration: const InputDecoration(
              labelText: 'Nombre del aeropuerto',
              hintText: 'Mariscal Sucre',
              prefixIcon: Icon(Icons.local_airport),
              border: OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => _focusCodigo.requestFocus(),
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'El nombre es obligatorio';
              if (v.trim().length < 3) return 'Mínimo 3 caracteres';
              return null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _ctrlCodigoIata,
            focusNode: _focusCodigo,
            textCapitalization: TextCapitalization.characters,
            maxLength: 3,
            decoration: const InputDecoration(
              labelText: 'Código IATA',
              hintText: 'UIO',
              prefixIcon: Icon(Icons.badge_outlined),
              border: OutlineInputBorder(),
              counterText: '',
            ),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => _focusCiudad.requestFocus(),
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'El código IATA es obligatorio';
              if (!_regexIata.hasMatch(v.trim())) return 'Debe contener exactamente 3 letras';
              return null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _ctrlCiudad,
            focusNode: _focusCiudad,
            decoration: const InputDecoration(
              labelText: 'Ciudad',
              hintText: 'Quito',
              prefixIcon: Icon(Icons.location_city_outlined),
              border: OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => _focusPistas.requestFocus(),
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'La ciudad es obligatoria';
              if (!_regexCiudad.hasMatch(v.trim())) return 'Ingrese una ciudad válida';
              return null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _ctrlPistas,
            focusNode: _focusPistas,
            decoration: const InputDecoration(
              labelText: 'Número de pistas',
              prefixIcon: Icon(Icons.route_outlined),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => _focusOperador.requestFocus(),
            validator: (v) {
              final pistas = int.tryParse(v ?? '');
              if (pistas == null) return 'Ingrese un número';
              if (pistas < 1 || pistas > 10) return 'Cantidad permitida: 1 a 10';
              return null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _ctrlOperador,
            focusNode: _focusOperador,
            decoration: const InputDecoration(
              labelText: 'Operador aeroportuario',
              hintText: 'Quiport',
              prefixIcon: Icon(Icons.business_outlined),
              border: OutlineInputBorder(),
            ),
            validator: (v) => v == null || v.trim().isEmpty
                ? 'El operador es obligatorio'
                : null,
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _categoria,
            decoration: const InputDecoration(
              labelText: 'Categoría',
              prefixIcon: Icon(Icons.category_outlined),
              border: OutlineInputBorder(),
            ),
            items: const ['Internacional', 'Nacional', 'Regional', 'Militar']
                .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                .toList(),
            onChanged: (v) => setState(() => _categoria = v!),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _estado,
            decoration: const InputDecoration(
              labelText: 'Estado operativo',
              prefixIcon: Icon(Icons.fact_check_outlined),
              border: OutlineInputBorder(),
            ),
            items: const ['Operativo', 'Mantenimiento', 'Restringido']
                .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                .toList(),
            onChanged: (v) => setState(() => _estado = v!),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Opera vuelos internacionales'),
            subtitle: const Text('Habilita migración y aduana'),
            value: _internacional,
            onChanged: (v) => setState(() => _internacional = v),
            secondary: const Icon(Icons.public),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _limpiar,
                  child: const Text('Limpiar'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: FilledButton.icon(
                  onPressed: _guardar,
                  icon: const Icon(Icons.save),
                  label: const Text('Guardar aeropuerto'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
