import 'package:eqms/core/themes/app_theme.dart';
import 'package:eqms/features/user_homepage/presentation/pages/user_homepage_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OilDri EQMS App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Dynamically supports system Light & Dark modes
      debugShowCheckedModeBanner: false,
      home: const UserHomepagePage(),
      routes: {
        '/user_homepage': (context) => const UserHomepagePage(),
      },
    );
  }
}
