import 'package:flutter/material.dart';
import 'package:teste_p/dropdown_menu.dart';
import 'package:teste_p/space.dart';

import 'elevatedbutton_icon.dart';
import 'navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: onDropdownMenu,
              child: const Text('DropdownMenu'),
            ),
            TextButton(
              onPressed: onElevatedButtonIcon,
              child: const Text('ElevatedButtonIcon'),
            ),
            TextButton(
              onPressed: onNavigationBar,
              child: const Text('NavigationBar'),
            ),
            TextButton(
              onPressed: onSpacer,
              child: const Text('Spacer'),
            ),
          ],
        ),
      ),
    );
  }

  onDropdownMenu() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DropPageCustom()));
  }

  onElevatedButtonIcon() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ElevatedButtonIconCustom(
                icon: Icons.co_present, onPressed: () {}, label: 'Botão')));
  }

  onNavigationBar() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const NavigationBarCustom()));
  }

  onSpacer() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const SpacerPage()));
  }
}
