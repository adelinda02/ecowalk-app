import 'dart:async';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 5), () {
      if (mounted) Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Ukuran proporsional terhadap layar (dengan batas min & max)
    final double logoWidth = (size.width * 0.55).clamp(160.0, 280.0);
    final double taglineSize = (size.width * 0.032).clamp(11.0, 14.0);
    final double gap = (size.height * 0.012).clamp(8.0, 14.0);

    return Scaffold(
      backgroundColor: AppColors.green,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/logo_putih.png', width: logoWidth),
                SizedBox(height: gap),
                Text(
                  '"Bandingkan, pilih, liburan tanpa ragu!"',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: taglineSize),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
