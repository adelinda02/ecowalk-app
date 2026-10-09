import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/primary_button.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  Widget _codeBox() {
    return SizedBox(
      width: 56,
      height: 56,
      child: TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: AppColors.fieldBg,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // true = verifikasi lewat HP, false = lewat email
    final bool viaPhone =
        (ModalRoute.of(context)?.settings.arguments as bool?) ?? true;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: AppColors.greenLight,
            padding: const EdgeInsets.only(top: 80, bottom: 24),
            child: Center(
              child: Image.asset('assets/images/logo_hijau.png', width: 180),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  const Row(
                    children: [
                      Icon(Icons.check, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'VERIFIKASI',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.smartphone, size: 22),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          viaPhone
                              ? 'Periksa dan ketik kode verifikasi yang telah dikirimkan ke 085211408867'
                              : 'Periksa dan ketik kode verifikasi yang telah dikirimkan ke adelindafebriana15@gmail.com',
                          style: const TextStyle(fontSize: 11),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [_codeBox(), _codeBox(), _codeBox(), _codeBox()],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    viaPhone
                        ? 'Verifikasi menggunakan Email'
                        : 'Verifikasi menggunakan No. Hp',
                    style: const TextStyle(color: AppColors.link, fontSize: 11),
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    text: 'KIRIM',
                    onPressed: () => Navigator.pushNamed(context, '/reset'),
                  ),
                  const SizedBox(height: 12),
                  const Center(
                    child: Text(
                      'Kirim Ulang Kode',
                      style: TextStyle(color: AppColors.green, fontSize: 11),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
