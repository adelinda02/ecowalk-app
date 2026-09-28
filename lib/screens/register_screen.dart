import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _agree = false;

  void _onRegister() {
    if (!_agree) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Centang persetujuan terlebih dahulu')),
      );
      return;
    }
    Navigator.pushNamed(context, '/verification');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                'BUAT AKUN',
                style: TextStyle(
                  color: AppColors.green,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
              Image.asset('assets/images/logo_hijau.png', width: 160),
              const SizedBox(height: 32),
              const CustomTextField(hint: 'Nama Pengguna', icon: Icons.person),
              const SizedBox(height: 12),
              const CustomTextField(
                hint: 'Email',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              const CustomTextField(
                hint: 'Nomor Hp',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),
              const CustomTextField(
                hint: 'Kata Sandi',
                icon: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(height: 12),
              const CustomTextField(
                hint: 'Konfirmasi Kata Sandi',
                icon: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Checkbox(
                    value: _agree,
                    activeColor: AppColors.green,
                    onChanged: (v) => setState(() => _agree = v ?? false),
                  ),
                  const Expanded(
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(fontSize: 11, color: Colors.black),
                        children: [
                          TextSpan(text: 'Saya telah membaca dan menyetujui '),
                          TextSpan(
                            text: 'persyaratan dan privasi pengguna',
                            style: TextStyle(color: AppColors.link),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              PrimaryButton(text: 'BUAT AKUN', onPressed: _onRegister),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text.rich(
                  TextSpan(
                    style: TextStyle(fontSize: 12, color: Colors.black),
                    children: [
                      TextSpan(text: 'Sudah punya akun? '),
                      TextSpan(
                        text: 'Masuk',
                        style: TextStyle(color: AppColors.link),
                      ),
                    ],
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
