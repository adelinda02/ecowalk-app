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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header hijau muda dengan logo
          Container(
            width: double.infinity,
            color: AppColors.greenLight,
            padding: const EdgeInsets.only(top: 80, bottom: 24),
            child: Column(
              children: [
                Image.asset('assets/images/logo_hijau.png', width: 180),
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Row(
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
                  const SizedBox(height: 24),
                  Text(
                    _useEmail ? 'Alamat Email' : 'Nomor Hp',
                    style: const TextStyle(fontSize: 11),
                  ),
                  TextField(
                    keyboardType: _useEmail
                        ? TextInputType.emailAddress
                        : TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => setState(() => _useEmail = !_useEmail),
                    child: Text(
                      _useEmail ? 'Gunakan Nomor Hp' : 'Gunakan Email',
                      style: const TextStyle(
                        color: AppColors.link,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    text: 'KIRIM',
                    onPressed: () => Navigator.pushNamed(
                      context,
                      '/verification',
                      arguments: !_useEmail,
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
