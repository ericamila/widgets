import 'package:flutter/material.dart';

class NavigationBarCustom extends StatefulWidget {
  const NavigationBarCustom({super.key});

  @override
  State<NavigationBarCustom> createState() => _NavigationBarCustomState();
}

class _NavigationBarCustomState extends State<NavigationBarCustom> {
  int pagina = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Página ${pagina + 1}',
          style: const TextStyle(fontSize: 30),
        ),
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Colors.lightBlue.withOpacity(0.1),
          indicatorColor: Colors.blueGrey[200],
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        child: NavigationBar(
          selectedIndex: pagina,
          onDestinationSelected: (int i) => setState(() => pagina = i),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.email_outlined, size: 30),
              selectedIcon: Icon(Icons.email, size: 30),
              label: 'E-mail',
            ),
            NavigationDestination(
              icon: Icon(Icons.videocam_outlined, size: 30),
              selectedIcon: Icon(Icons.videocam, size: 30),
              label: 'Reunião',
            ),
          ],
        ),
      ),
    );
  }
}