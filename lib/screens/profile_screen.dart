import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const List<_MenuItem> _menus = [
    _MenuItem(Icons.settings_outlined, 'Pengaturan'),
    _MenuItem(Icons.edit_outlined, 'Edit Profil'),
    _MenuItem(Icons.lock_outline, 'Kebijakan Privasi'),
    _MenuItem(Icons.info_outline, 'Tentang Kami'),
    _MenuItem(Icons.description_outlined, 'Ketentuan Layanan'),
    _MenuItem(Icons.logout, 'Keluar'),
  ];

  void _onMenuTap(BuildContext context, String title) {
    switch (title) {
      case 'Pengaturan':
        _showMessage(context, 'Halaman Pengaturan belum tersedia.');
        break;
      case 'Edit Profil':
        _showMessage(context, 'Halaman Edit Profil belum tersedia.');
        break;
      case 'Kebijakan Privasi':
        _showMessage(context, 'Halaman Kebijakan Privasi belum tersedia.');
        break;
      case 'Tentang Kami':
        _showMessage(
          context,
          'EcoWalk adalah aplikasi untuk membantu pengguna.',
        );
        break;
      case 'Ketentuan Layanan':
        _showMessage(context, 'Halaman Ketentuan Layanan belum tersedia.');
        break;
      case 'Keluar':
        _showLogoutDialog(context);
        break;
    }
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Keluar'),
          content: const Text('Apakah kamu yakin ingin keluar dari akun?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.green,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(dialogContext);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final size = mq.size;

    // Ukuran proporsional terhadap layar (dengan batas min & max)
    final double headerHeight =
        mq.padding.top + (size.height * 0.16).clamp(100.0, 150.0);
    final double avatarRadius = (size.width * 0.11).clamp(36.0, 48.0);
    const double avatarBorder = 3;
    final double avatarOuterRadius = avatarRadius + avatarBorder;
    final double gapMedium = (size.height * 0.02).clamp(12.0, 20.0);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      // Ikon status bar putih karena latar header hijau
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // =========================
            // HEADER (sampai ke bawah status bar)
            // =========================
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  height: headerHeight,
                  width: double.infinity,
                  color: AppColors.green,
                ),

                // Avatar: separuh keluar dari tepi bawah header
                Positioned(
                  bottom: -avatarOuterRadius,
                  child: Container(
                    padding: const EdgeInsets.all(avatarBorder),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: avatarRadius,
                      backgroundColor: Colors.grey,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/pic.jpeg',
                          width: avatarRadius * 2,
                          height: avatarRadius * 2,
                          fit: BoxFit.cover,
                          errorBuilder: _imageErrorBuilder,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Ruang untuk separuh avatar yang menggantung + jarak ke nama
            SizedBox(height: avatarOuterRadius + gapMedium),

            // =========================
            // NAMA
            // =========================
            const Text(
              'Ade Linda Febriana',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 16,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 6),

            // =========================
            // EMAIL
            // =========================
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(
                'adelindafebriana15@gmail.com',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            SizedBox(height: gapMedium),

            // =========================
            // MENU
            // =========================
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _menus.length,
                separatorBuilder: (_, _) =>
                    const Divider(height: 1, thickness: 0.7),
                itemBuilder: (context, index) {
                  final item = _menus[index];
                  final isLogout = item.title == 'Keluar';

                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                    leading: Icon(
                      item.icon,
                      size: 22,
                      color: isLogout ? Colors.red : Colors.black87,
                    ),
                    title: Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isLogout ? Colors.red : Colors.black87,
                      ),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: isLogout ? Colors.red : Colors.grey,
                    ),
                    onTap: () => _onMenuTap(context, item.title),
                  );
                },
              ),
            ),
          ],
        ),

        // =========================
        // BOTTOM NAVIGATION
        // =========================
        bottomNavigationBar: Container(
          color: AppColors.green,
          child: SafeArea(
            top: false,
            child: SizedBox(
              height: 60,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _BottomNavItem(
                    icon: Icons.home_outlined,
                    label: 'HOME',
                    onTap: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      } else {
                        _showMessage(context, 'Sudah berada di halaman utama.');
                      }
                    },
                  ),
                  _BottomNavItem(
                    icon: Icons.shield_outlined,
                    label: 'KEAMANAN',
                    onTap: () => _showMessage(
                      context,
                      'Halaman Keamanan belum tersedia.',
                    ),
                  ),
                  _BottomNavItem(
                    icon: Icons.chat_bubble_outline,
                    label: 'CHAT',
                    onTap: () =>
                        _showMessage(context, 'Halaman Chat belum tersedia.'),
                  ),
                  const _ActiveTab(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget _imageErrorBuilder(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    return const Icon(Icons.person, size: 50, color: Colors.white);
  }
}

// =====================================================
// MODEL MENU
// =====================================================

class _MenuItem {
  final IconData icon;
  final String title;

  const _MenuItem(this.icon, this.title);
}

// =====================================================
// BOTTOM NAV ITEM (dibagi rata dengan Expanded)
// =====================================================

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 22),
            const SizedBox(height: 2),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// ACTIVE ACCOUNT TAB
// =====================================================

class _ActiveTab extends StatelessWidget {
  const _ActiveTab();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: AppColors.green, size: 20),
          ),
          const SizedBox(height: 2),
          const Text(
            'AKUN',
            style: TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
