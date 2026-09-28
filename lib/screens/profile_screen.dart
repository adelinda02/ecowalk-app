import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

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
    if (title == 'Keluar') {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header hijau + avatar + nama + email
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                height: 130,
                width: double.infinity,
                color: AppColors.green,
              ),
              Positioned(
                top: 70,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const CircleAvatar(
                    radius: 42,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 56),
          const Text(
            'KAYI NYAP NYAP',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.green,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'kayimail@gmail.com',
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
          const SizedBox(height: 16),

          // Daftar menu
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _menus.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final item = _menus[i];
                return ListTile(
                  leading: Icon(item.icon, size: 22),
                  title: Text(item.title, style: const TextStyle(fontSize: 13)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _onMenuTap(context, item.title),
                );
              },
            ),
          ),
        ],
      ),

      // Bottom navigation
      bottomNavigationBar: Container(
        height: 60,
        color: AppColors.green,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.home_outlined, color: Colors.white),
            Icon(Icons.shield, color: Colors.white),
            Icon(Icons.chat_bubble, color: Colors.white),
            _ActiveTab(),
          ],
        ),
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  const _MenuItem(this.icon, this.title);
}

class _ActiveTab extends StatelessWidget {
  const _ActiveTab();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: Colors.white,
          child: Icon(Icons.person, color: AppColors.green, size: 20),
        ),
        SizedBox(height: 2),
        Text(
          'AKUN',
          style: TextStyle(
            color: Colors.white,
            fontSize: 8,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
