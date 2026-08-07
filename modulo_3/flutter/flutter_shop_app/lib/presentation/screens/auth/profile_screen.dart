// lib/presentation/screens/auth/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shop_app/presentation/providers/imageuploadprovider.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../providers/profile_provider.dart';
import '../../widgets/user_avatar.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  String? _avatarCacheBuster;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider).user;
    final profileAsync = ref.watch(profileProvider);
    final uploadState = ref.watch(imageUploadProvider);
    final tt = Theme.of(context).textTheme;

    // Escuchar el estado de la subida del avatar
    ref.listen<ImageUploadState>(imageUploadProvider, (_, next) {
      if (next is ImageUploadSuccess) {
        setState(() {
          _avatarCacheBuster = '?t=${DateTime.now().millisecondsSinceEpoch}';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Avatar actualizado correctamente.')),
        );
        ref.invalidate(profileProvider);
        ref.read(imageUploadProvider.notifier).reset();
      } else if (next is ImageUploadError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message),
            backgroundColor: AppColors.error,
          ),
        );
        ref.read(imageUploadProvider.notifier).reset();
      }
    });

    final avatarUrl = profileAsync.valueOrNull?.avatarUrl;
    final avatarUrlWithCacheBust =
        avatarUrl == null ? null : '$avatarUrl${_avatarCacheBuster ?? ''}';

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 24),

              // Avatar con tap para cambiar e indicador de carga
              Stack(
                alignment: Alignment.center,
                children: [
                  UserAvatar(
                    avatarUrl: avatarUrlWithCacheBust,
                    username: user?.username,
                    radius: 40,
                    onTap: uploadState is ImageUploadLoading
                        ? null
                        : () => ref
                            .read(imageUploadProvider.notifier)
                            .pickAndUploadAvatar(),
                  ),
                  if (uploadState is ImageUploadLoading)
                    const CircularProgressIndicator(color: AppColors.accent),
                ],
              ),
              const SizedBox(height: 16),
              Text(user?.username ?? '—', style: tt.headlineMedium),
              Text(user?.email ?? '—', style: tt.bodyMedium),
              const SizedBox(height: 8),
              if (user?.isStaff == true)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Text(
                    'Staff',
                    style: TextStyle(
                      color: AppColors.accent,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              const SizedBox(height: 32),

              // Información de la cuenta
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'INFORMACIÓN DE LA CUENTA',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...[
                      ('ID de usuario', user?.id.toString() ?? '—'),
                      ('Usuario', user?.username ?? '—'),
                      ('Email', user?.email ?? '—'),
                      (
                        'Rol',
                        user?.isStaff == true ? 'Administrador' : 'Cliente'
                      ),
                    ].asMap().entries.map((entry) {
                      final isLast = entry.key == 3;
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(entry.value.$1,
                                    style: const TextStyle(
                                        color: AppColors.textSecondary)),
                                Text(
                                  entry.value.$2,
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (!isLast) const Divider(height: 1),
                        ],
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Botón Admin — solo visible para staff
              if (user?.isStaff == true) ...[
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () => context.go('/admin'),
                    icon: const Icon(Icons.admin_panel_settings_outlined),
                    label: const Text('Panel Admin'),
                  ),
                ),
                const SizedBox(height: 12),
              ],

              // Botón logout
              _LogoutButton(
                onConfirm: () async {
                  await ref.read(authProvider.notifier).logout();
                  if (context.mounted) context.go('/login');
                },
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  final Future<void> Function() onConfirm;
  const _LogoutButton({required this.onConfirm});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        height: 52,
        child: OutlinedButton.icon(
          onPressed: () => showDialog(
            context: context,
            builder: (dialogContext) => AlertDialog(
              backgroundColor: AppColors.surface,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              title: const Text('¿Cerrar sesión?',
                  style: TextStyle(color: AppColors.textPrimary)),
              content: const Text(
                'Tu sesión se cerrará en este dispositivo.',
                style: TextStyle(color: AppColors.textSecondary),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(dialogContext).pop();
                    await Future.delayed(const Duration(milliseconds: 100));
                    await onConfirm();
                  },
                  child: const Text(
                    'Cerrar sesión',
                    style: TextStyle(
                        color: AppColors.error, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          icon: const Icon(Icons.logout, color: AppColors.error),
          label: const Text('Cerrar sesión'),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.error,
            side: BorderSide(color: AppColors.error.withValues(alpha: 0.5)),
          ),
        ),
      );
}
