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
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Centang persetujuan terlebih dahulu')),
      );
      return;
    }
    Navigator.pushNamed(context, '/verification');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Jarak proporsional terhadap tinggi layar (dengan batas min & max)
    final double gapLarge = (size.height * 0.04).clamp(20.0, 36.0);
    final double gapMedium = (size.height * 0.02).clamp(12.0, 20.0);
    final double gapField = (size.height * 0.015).clamp(10.0, 16.0);
    final double logoWidth = (size.width * 0.40).clamp(120.0, 180.0);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ConstrainedBox(
                // Minimal setinggi layar -> konten bisa dipusatkan
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: ConstrainedBox(
                    // Batasi lebar agar tetap rapi di layar lebar/tablet
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: gapMedium),
                        const Text(
                          'BUAT AKUN',
                          style: TextStyle(
                            color: AppColors.green,
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Image.asset(
                          'assets/images/logo_hijau.png',
                          width: logoWidth,
                        ),
                        SizedBox(height: gapLarge),

                        const CustomTextField(
                          hint: 'Nama Pengguna',
                          icon: Icons.person,
                        ),
                        SizedBox(height: gapField),
                        const CustomTextField(
                          hint: 'Email',
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: gapField),
                        const CustomTextField(
                          hint: 'Nomor Hp',
                          icon: Icons.phone,
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(height: gapField),
                        const CustomTextField(
                          hint: 'Kata Sandi',
                          icon: Icons.lock,
                          isPassword: true,
                        ),
                        SizedBox(height: gapField),
                        const CustomTextField(
                          hint: 'Konfirmasi Kata Sandi',
                          icon: Icons.lock,
                          isPassword: true,
                        ),
                        SizedBox(height: gapField),

                        Row(
                          children: [
                            Checkbox(
                              value: _agree,
                              activeColor: AppColors.green,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              onChanged: (v) =>
                                  setState(() => _agree = v ?? false),
                            ),
                            const SizedBox(width: 4),
                            const Expanded(
                              child: Text.rich(
                                TextSpan(
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          'Saya telah membaca dan menyetujui ',
                                    ),
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
                        SizedBox(height: gapMedium),

                        PrimaryButton(
                          text: 'BUAT AKUN',
                          onPressed: _onRegister,
                        ),
                        SizedBox(height: gapMedium),

                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
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
                        SizedBox(height: gapMedium),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
