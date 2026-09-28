import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Center(
                child: Image.asset('assets/images/logo_hijau.png', width: 180),
              ),
              const SizedBox(height: 40),
              const Text('Nama Pengguna', style: TextStyle(fontSize: 12)),
              const SizedBox(height: 6),
              const CustomTextField(hint: '', icon: Icons.person),
              const SizedBox(height: 16),
              const Text('Kata Sandi', style: TextStyle(fontSize: 12)),
              const SizedBox(height: 6),
              const CustomTextField(
                hint: '',
                icon: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                text: 'MASUK',
                onPressed: () => Navigator.pushNamed(context, '/profile'),
              ),
              const SizedBox(height: 12),
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/forgot'),
                  child: const Text(
                    'Lupa Kata Sandi?',
                    style: TextStyle(
                      color: AppColors.link,
                      fontStyle: FontStyle.italic,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text('Atau', style: TextStyle(fontSize: 11)),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: Image.asset('assets/images/google.png', width: 18),
                  label: const Text(
                    'Lanjutkan dengan Google',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/register'),
                  child: const Text.rich(
                    TextSpan(
                      style: TextStyle(fontSize: 12, color: Colors.black),
                      children: [
                        TextSpan(text: 'Tidak punya akun? '),
                        TextSpan(
                          text: 'Daftar disini',
                          style: TextStyle(color: AppColors.link),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
