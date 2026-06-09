import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'business/product_provider.dart';
import 'core/app_theme.dart';
import 'ui/screens/login_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          // Start fetching data when the application starts.
          create: (_) => ProductProvider()..loadProducts(),
        ),
      ],
      child: const VicoMaisonApp(),
    ),
  );
}

class VicoMaisonApp extends StatelessWidget {
  const VicoMaisonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VICO Maison',
      theme: VicoTheme.lightTheme,
      home: const LoginScreen(),
    );
  }
}