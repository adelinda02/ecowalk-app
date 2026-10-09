import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/primary_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool _useEmail = true;

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
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.notifications_none, size: 20),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    _useEmail
                                        ? 'Periksa dan masukan alamat Email untuk mendapatkan kode verifikasi'
                                        : 'Periksa dan masukan Nomor Hp untuk mendapatkan kode verifikasi',
                                    style: const TextStyle(fontSize: 11),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: gapLarge),
                            Text(
                              _useEmail ? 'Alamat Email' : 'Nomor Hp',
                              style: const TextStyle(fontSize: 11),
                            ),
                            TextField(
                              keyboardType: _useEmail
                                  ? TextInputType.emailAddress
                                  : TextInputType.phone,
                            ),
                            SizedBox(height: gapMedium),
                            GestureDetector(
                              onTap: () =>
                                  setState(() => _useEmail = !_useEmail),
                              child: Text(
                                _useEmail
                                    ? 'Gunakan Nomor Hp'
                                    : 'Gunakan Email',
                                style: const TextStyle(
                                  color: AppColors.link,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                            SizedBox(height: gapLarge),
                            PrimaryButton(
                              text: 'KIRIM',
                              onPressed: () => Navigator.pushNamed(
                                context,
                                '/verification',
                                arguments: !_useEmail,
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
