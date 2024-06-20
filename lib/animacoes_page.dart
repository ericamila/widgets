import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimacoesPage extends StatefulWidget {
  const AnimacoesPage({super.key});

  @override
  State<AnimacoesPage> createState() => _AnimacoesPageState();
}

class _AnimacoesPageState extends State<AnimacoesPage> {
  open(pagina) {
    Navigator.push(context, MaterialPageRoute(builder: pagina));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Exemplos'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Exemplo: Delivery'),
            onTap: () => open((_) => const DeliveryPage()),
          ),
          const Divider(),
          ListTile(
            title: const Text('Exemplo: Switch + Controller'),
            onTap: () => open((_) => const SwitchPage()),
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class DeliveryPage extends StatelessWidget {
  const DeliveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.red[900],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 120, bottom: 24),
              child: Lottie.network(
                "https://assets5.lottiefiles.com/packages/lf20_6YCRFI.json",
              ),
            ),
            const Text(
              "Marcos está a caminho",
              style: TextStyle(
                  fontSize: 32,
                  letterSpacing: -1.2,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                "Seu pedido deve chegar em 10 minutos",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red[100],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SwitchPage extends StatefulWidget {
  const SwitchPage({super.key});

  @override
  SwitchPageState createState() => SwitchPageState();
}

class SwitchPageState extends State<SwitchPage> with TickerProviderStateMixin {
  late final AnimationController _controller;
  bool checked = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.duration = const Duration(milliseconds: 600);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  toggle() {
    (!checked) ? _controller.forward() : _controller.reverse();
    checked = !checked;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Opção Animada'),
        elevation: 0,
      ),
      body: Center(
        child: GestureDetector(
          onTap: toggle,
          child: SizedBox(
            width: 100,
            child: Lottie.asset(
              "lottie/lottie_toggle.json",
              controller: _controller,
            ),
          ),
        ),
      ),
    );
  }
}
