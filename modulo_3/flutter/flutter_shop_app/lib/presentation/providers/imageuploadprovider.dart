// lib/presentation/providers/image_upload_provider.dart
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shop_app/data/remote/api/imageuploadservice.dart';
import 'package:image_picker/image_picker.dart';

// ---------------------------------------------------------------------------
// Estado
// ---------------------------------------------------------------------------

/// Estado del proceso de subida de imágenes.
sealed class ImageUploadState {
  const ImageUploadState();
}

/// Estado inicial o tras resetear.
class ImageUploadIdle extends ImageUploadState {
  const ImageUploadIdle();
}

/// Subida en progreso.
class ImageUploadLoading extends ImageUploadState {
  const ImageUploadLoading();
}

/// Subida completada con éxito.
class ImageUploadSuccess extends ImageUploadState {
  const ImageUploadSuccess({required this.imageUrl});

  /// URL absoluta de la imagen subida (puede ser null si el API no la devuelve).
  final String? imageUrl;
}

/// Error en la subida.
class ImageUploadError extends ImageUploadState {
  const ImageUploadError({required this.message});
  final String message;
}

// ---------------------------------------------------------------------------
// Notifier
// ---------------------------------------------------------------------------

class ImageUploadNotifier extends StateNotifier<ImageUploadState> {
  ImageUploadNotifier({
    ImageUploadService? service,
    ImagePicker? picker,
  })  : _service = service ?? ImageUploadService(),
        _picker = picker ?? ImagePicker(),
        super(const ImageUploadIdle());

  final ImageUploadService _service;
  final ImagePicker _picker;

  // -------------------------------------------------------------------------
  // Privados
  // -------------------------------------------------------------------------

  /// Muestra el bottom sheet de selección de fuente y devuelve el archivo.
  /// Devuelve null si el usuario cancela.
  Future<XFile?> _pickImage() async {
    // Abrir galería por defecto (la fuente puede extenderse a cámara con
    // un dialog previo si se desea).
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 90, // Compresión leve para reducir tamaño
      maxWidth: 1920,
      maxHeight: 1920,
    );

    return picked;
  }

  Future<void> _handleUpload(
      Future<String?> Function(Uint8List bytes, String filename) upload) async {
    try {
      final picked = await _pickImage();
      if (picked == null) {
        // Usuario canceló la selección — no cambiar estado
        return;
      }

      final bytes = await picked.readAsBytes();
      state = const ImageUploadLoading();

      final imageUrl = await upload(bytes, picked.name);
      state = ImageUploadSuccess(imageUrl: imageUrl);
    } on ImageUploadException catch (e) {
      state = ImageUploadError(message: e.message);
    } catch (e) {
      state = ImageUploadError(
        message: 'Error inesperado: ${e.toString()}',
      );
    }
  }

  // -------------------------------------------------------------------------
  // API pública
  // -------------------------------------------------------------------------

  /// Selecciona una imagen de la galería y la sube como imagen del producto.
  Future<void> pickAndUploadProductImage(int productId) async {
    await _handleUpload(
      (bytes, filename) => _service.uploadProductImage(
        productId: productId,
        bytes: bytes,
        filename: filename,
      ),
    );
  }

  /// Selecciona una imagen de la galería y la sube como avatar del usuario.
  Future<void> pickAndUploadAvatar() async {
    await _handleUpload(
      (bytes, filename) => _service.uploadAvatar(
        bytes: bytes,
        filename: filename,
      ),
    );
  }

  /// Vuelve al estado inicial (útil tras mostrar error o éxito).
  void reset() => state = const ImageUploadIdle();
}

// ---------------------------------------------------------------------------
// Provider
// ---------------------------------------------------------------------------

/// Provider global para subida de imágenes.
///
/// Se usa `autoDispose` para limpiar el estado cuando ya no hay listeners
/// (p. ej. al navegar fuera de la pantalla).
final imageUploadProvider =
    StateNotifierProvider.autoDispose<ImageUploadNotifier, ImageUploadState>(
  (ref) => ImageUploadNotifier(),
);
