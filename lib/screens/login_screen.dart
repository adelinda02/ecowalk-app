import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../theme/app_colors.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    if (_loading) return;
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();
    setState(() => _loading = true);

    final user = await AuthService.login(
      _usernameCtrl.text,
      _passwordCtrl.text,
    );

    if (!mounted) return;
    setState(() => _loading = false);

    if (user == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Nama pengguna atau kata sandi salah'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ),
        );
      return;
    }

    Navigator.pushReplacementNamed(context, '/profile', arguments: user);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Form(
                      key: _formKey,
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
                          CustomTextField(
                            hint: '',
                            icon: Icons.person,
                            controller: _usernameCtrl,
                            textInputAction: TextInputAction.next,
                            validator: (v) => (v == null || v.trim().isEmpty)
                                ? 'Nama pengguna wajib diisi'
                                : null,
                          ),
                          SizedBox(height: gapMedium),

                          const Text(
                            'Kata Sandi',
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(height: gapSmall),
                          CustomTextField(
                            hint: '',
                            icon: Icons.lock,
                            isPassword: true,
                            controller: _passwordCtrl,
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) => _onLogin(),
                            validator: (v) => (v == null || v.isEmpty)
                                ? 'Kata sandi wajib diisi'
                                : null,
                          ),
                          SizedBox(height: gapLarge),

                          _loading
                              ? const Center(
                                  child: SizedBox(
                                    height: 48,
                                    child: CircularProgressIndicator(
                                      color: AppColors.green,
                                    ),
                                  ),
                                )
                              : PrimaryButton(
                                  text: 'MASUK',
                                  onPressed: _onLogin,
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
              ),
            );
          },
        ),
      ),
    );
  }
}
