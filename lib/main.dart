import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/onboarding.dart';
import 'home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Color palette from user: Indigo #4F46E5, Teal #14B8A6, Gray #64748B
  static const Color indigoPrimary = Color(0xFF4F46E5);
  static const Color tealAccent = Color(0xFF14B8A6);
  static const Color grayNeutral = Color(0xFF64748B);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'microlições',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: indigoPrimary,
          primary: indigoPrimary,
          secondary: tealAccent,
          background: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
        textTheme: Typography.material2021().black,
        appBarTheme: const AppBarTheme(
          backgroundColor: indigoPrimary,
          foregroundColor: Colors.white,
        ),
      ),
      home: const EntryPoint(),
    );
  }
}

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  Future<bool> _fetchOnboarded() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboarded') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _fetchOnboarded(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final onboarded = snapshot.data ?? false;
        if (onboarded) {
          return const HomeScreen();
        }

        return const OnboardingScreen();
      },
    );
  }
}
