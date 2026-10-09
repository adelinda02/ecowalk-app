import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Jarak proporsional terhadap tinggi layar (dengan batas min & max)
    final double gapLarge = (size.height * 0.04).clamp(20.0, 40.0);
    final double gapMedium = (size.height * 0.02).clamp(12.0, 20.0);
    final double gapSmall = (size.height * 0.01).clamp(6.0, 12.0);
    final double logoWidth = (size.width * 0.45).clamp(140.0, 200.0);

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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: gapMedium),
                        Center(
                          child: Image.asset(
                            'assets/images/logo_hijau.png',
                            width: logoWidth,
                          ),
                        ),
                        SizedBox(height: gapLarge),

                        const Text(
                          'Nama Pengguna',
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(height: gapSmall),
                        const CustomTextField(hint: '', icon: Icons.person),
                        SizedBox(height: gapMedium),

                        const Text(
                          'Kata Sandi',
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(height: gapSmall),
                        const CustomTextField(
                          hint: '',
                          icon: Icons.lock,
                          isPassword: true,
                        ),
                        SizedBox(height: gapLarge),

                        PrimaryButton(
                          text: 'MASUK',
                          onPressed: () =>
                              Navigator.pushNamed(context, '/profile'),
                        ),
                        SizedBox(height: gapSmall),

                        Center(
                          child: GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, '/forgot'),
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
                        SizedBox(height: gapMedium),

                        const Row(
                          children: [
                            Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                'Atau',
                                style: TextStyle(fontSize: 11),
                              ),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),
                        SizedBox(height: gapMedium),

                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: Image.asset(
                              'assets/images/google.png',
                              width: 18,
                            ),
                            label: const Text(
                              'Lanjutkan dengan Google',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(height: gapLarge),

                        Center(
                          child: GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, '/register'),
                            child: const Text.rich(
                              TextSpan(
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
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
