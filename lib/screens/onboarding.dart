import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  String _language = 'Português';
  int _dailyGoal = 5;
  bool _notifications = false;

  Widget _buildIcon(BuildContext context, double size) {
    // Flat composed icon: speech bubble + check
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.chat_bubble, size: size, color: Theme.of(context).colorScheme.primary),
        Positioned(
          right: size * 0.08,
          bottom: size * 0.08,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(4),
            child: const Icon(Icons.check, size: 14, color: Colors.white),
          ),
        )
      ],
    );
  }

  Future<void> _finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarded', true);
    await prefs.setString('language', _language);
    await prefs.setInt('dailyGoal', _dailyGoal);
    await prefs.setBool('notifications', _notifications);

    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                children: [
                  // Page 1: Welcome
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildIcon(context, 120),
                        const SizedBox(height: 24),
                        const Text('Microlições', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        const Text(
                          'Curto, focado e repetido — aprenda com revisões espaçadas adaptadas ao seu tempo.',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  // Page 2: Study cycles & privacy
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 12),
                          const Text('Ciclos de estudo', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 12),
                          const Text(
                            'Sessões curtas e frequentes com espaçamento crescente entre revisões. ' 
                            'Isto maximiza retenção e cabe no seu dia a dia.',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          const Text('Privacidade', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 12),
                          const Text(
                            'Seus dados (idioma, meta diária e progresso) ficam armazenados no seu dispositivo. ' 
                            'Não enviamos conteúdo pessoal para servidores sem aviso prévio.',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          const Text('Notificações', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 12),
                          const Text(
                            'Podemos enviar lembretes para suas microlições. Você decide ativá-las. ' 
                            'Ative abaixo se quiser receber lembretes simples e não intrusivos.',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          SwitchListTile(
                            title: const Text('Ativar lembretes'),
                            value: _notifications,
                            onChanged: (v) => setState(() => _notifications = v),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Page 3: Language + daily goal
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Primeiros passos', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        const Text('Escolha o idioma que você quer praticar:'),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          value: _language,
                          items: const [
                            DropdownMenuItem(value: 'Português', child: Text('Português')),
                            DropdownMenuItem(value: 'Inglês', child: Text('Inglês')),
                            DropdownMenuItem(value: 'Espanhol', child: Text('Espanhol')),
                            DropdownMenuItem(value: 'Francês', child: Text('Francês')),
                          ],
                          onChanged: (v) => setState(() => _language = v ?? _language),
                        ),
                        const SizedBox(height: 20),
                        const Text('Meta diária'),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ChoiceChip(
                              label: const Text('5 termos'),
                              selected: _dailyGoal == 5,
                              onSelected: (_) => setState(() => _dailyGoal = 5),
                            ),
                            const SizedBox(width: 12),
                            ChoiceChip(
                              label: const Text('10 termos'),
                              selected: _dailyGoal == 10,
                              onSelected: (_) => setState(() => _dailyGoal = 10),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),
                        ElevatedButton(
                          onPressed: _finishOnboarding,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                            child: Text('Começar'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      _controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                    },
                    child: const Text('Voltar'),
                  ),
                  TextButton(
                    onPressed: () {
                      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                    },
                    child: const Text('Próximo'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
