import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final size = mq.size;

    // Jarak proporsional terhadap tinggi layar (dengan batas min & max)
    final double gapLarge = (size.height * 0.03).clamp(16.0, 28.0);
    final double gapMedium = (size.height * 0.02).clamp(12.0, 20.0);
    final double logoWidth = (size.width * 0.45).clamp(140.0, 200.0);
    final double headerTop =
        mq.padding.top + (size.height * 0.04).clamp(16.0, 40.0);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          // Header hijau muda dengan logo
          Container(
            width: double.infinity,
            color: AppColors.greenLight,
            padding: EdgeInsets.only(top: headerTop, bottom: gapLarge),
            child: Column(
              children: [
                Image.asset('assets/images/logo_hijau.png', width: logoWidth),
                const SizedBox(height: 4),
                const Text(
                  'LUPA KATA SANDI',
                  style: TextStyle(
                    color: AppColors.green,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ConstrainedBox(
                    // Minimal setinggi area sisa, supaya konten bisa dipusatkan
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 420),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: gapLarge),
                            const Text(
                              'Masukan Kata Sandi Baru',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: gapMedium),
                            const CustomTextField(
                              hint: 'Kata Sandi Baru',
                              icon: Icons.lock,
                              isPassword: true,
                            ),
                            SizedBox(height: gapMedium),
                            const CustomTextField(
                              hint: 'Konfirmasi Kata Sandi',
                              icon: Icons.lock,
                              isPassword: true,
                            ),
                            SizedBox(height: gapLarge),
                            PrimaryButton(
                              text: 'UBAH KATA SANDI',
                              onPressed: () =>
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/login',
                                    (route) => false,
                                  ),
                            ),
                            SizedBox(height: gapLarge),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
