import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _language = '';
  int _dailyGoal = 0;

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _language = prefs.getString('language') ?? 'Português';
      _dailyGoal = prefs.getInt('dailyGoal') ?? 5;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('microlições')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Bem-vindo!', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 12),
              Text('Idioma: $_language'),
              const SizedBox(height: 8),
              Text('Meta diária: $_dailyGoal termos'),
              const SizedBox(height: 20),
              const Text('Aqui começaria sua primeira microlição.'),
            ],
          ),
        ),
      ),
    );
  }
}
