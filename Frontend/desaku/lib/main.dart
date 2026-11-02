import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/app_theme.dart';
import 'features/auth/splash_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const DesaKuApp());
}

class DesaKuApp extends StatelessWidget {
  const DesaKuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DesaKu',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      home: const SplashPage(),
    );
  }
}
