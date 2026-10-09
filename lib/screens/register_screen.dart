import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../theme/app_colors.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  bool _agree = false;
  bool _loading = false;

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _showSnack(String message, {bool error = false}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: error ? Colors.red : null,
        ),
      );
  }

  Future<void> _onRegister() async {
    if (_loading) return;
    if (!_formKey.currentState!.validate()) return;

    if (!_agree) {
      _showSnack('Centang persetujuan terlebih dahulu', error: true);
      return;
    }

    FocusScope.of(context).unfocus();
    setState(() => _loading = true);

    final error = await AuthService.register(
      username: _usernameCtrl.text,
      email: _emailCtrl.text,
      phone: _phoneCtrl.text,
      password: _passCtrl.text,
    );

    if (!mounted) return;
    setState(() => _loading = false);

    if (error != null) {
      _showSnack(error, error: true);
      return;
    }

    _showSnack('Akun berhasil dibuat. Silakan masuk.');
    Navigator.pushNamed(context, '/verification');
  }

  // ---------- Validator ----------

  String? _validateUsername(String? v) {
    final s = v?.trim() ?? '';
    if (s.isEmpty) return 'Nama pengguna wajib diisi';
    if (s.length < 3) return 'Minimal 3 karakter';
    if (s.contains(' ')) return 'Tidak boleh mengandung spasi';
    return null;
  }

  String? _validateEmail(String? v) {
    final s = v?.trim() ?? '';
    if (s.isEmpty) return 'Email wajib diisi';
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(s);
    return ok ? null : 'Format email tidak valid';
  }

  String? _validatePhone(String? v) {
    final s = v?.trim() ?? '';
    if (s.isEmpty) return 'Nomor Hp wajib diisi';
    final ok = RegExp(r'^\+?[0-9]{9,14}$').hasMatch(s);
    return ok ? null : 'Nomor Hp tidak valid';
  }

  String? _validatePassword(String? v) {
    final s = v ?? '';
    if (s.isEmpty) return 'Kata sandi wajib diisi';
    if (s.length < 6) return 'Minimal 6 karakter';
    return null;
  }

  String? _validateConfirm(String? v) {
    if (v == null || v.isEmpty) return 'Konfirmasi kata sandi wajib diisi';
    if (v != _passCtrl.text) return 'Kata sandi tidak sama';
    return null;
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
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Form(
                      key: _formKey,
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

                          CustomTextField(
                            hint: 'Nama Pengguna',
                            icon: Icons.person,
                            controller: _usernameCtrl,
                            textInputAction: TextInputAction.next,
                            validator: _validateUsername,
                          ),
                          SizedBox(height: gapField),
                          CustomTextField(
                            hint: 'Email',
                            icon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailCtrl,
                            textInputAction: TextInputAction.next,
                            validator: _validateEmail,
                          ),
                          SizedBox(height: gapField),
                          CustomTextField(
                            hint: 'Nomor Hp',
                            icon: Icons.phone,
                            keyboardType: TextInputType.phone,
                            controller: _phoneCtrl,
                            textInputAction: TextInputAction.next,
                            validator: _validatePhone,
                          ),
                          SizedBox(height: gapField),
                          CustomTextField(
                            hint: 'Kata Sandi',
                            icon: Icons.lock,
                            isPassword: true,
                            controller: _passCtrl,
                            textInputAction: TextInputAction.next,
                            validator: _validatePassword,
                          ),
                          SizedBox(height: gapField),
                          CustomTextField(
                            hint: 'Konfirmasi Kata Sandi',
                            icon: Icons.lock,
                            isPassword: true,
                            controller: _confirmCtrl,
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) => _onRegister(),
                            validator: _validateConfirm,
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
                                        text: 'Saya telah membaca dan menyetujui ',
                                      ),
                                      TextSpan(
                                        text:
                                            'persyaratan dan privasi pengguna',
                                        style: TextStyle(color: AppColors.link),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: gapMedium),

                          _loading
                              ? const SizedBox(
                                  height: 48,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.green,
                                    ),
                                  ),
                                )
                              : PrimaryButton(
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
              ),
            );
          },
        ),
      ),
    );
  }
}
