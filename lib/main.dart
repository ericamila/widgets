import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:teste_p/biometria.dart';
import 'package:teste_p/dropdown_menu.dart';
import 'package:teste_p/space.dart';
import 'package:teste_p/tab_bar.dart';

import 'animacoes_page.dart';
import 'animate.dart';
import 'banco.dart';
import 'crud_supabase.dart';
import 'elevatedbutton_icon.dart';
import 'flow_widget.dart';
import 'navigation_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: supabaseUrl, anonKey: anonKey);

  Animate.restartOnHotReload = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
            TextButton(
              onPressed: onTabBar,
              child: const Text('TabBar'),
            ),
            TextButton(
              onPressed: onCRUDSupabase,
              child: const Text('CRUD Supabase'),
            ),
            TextButton(
              onPressed: onMudarCores,
              child: const Text('Mudar Cores'),
            ),
            TextButton(
              onPressed: () => open((_) => const Biometria()),
              child: const Text('Biometria'),
            ),
            TextButton(
              onPressed: () => open((_) => const AnimacoesPage()),
              child: const Text('Animações'),
            ),
            TextButton(
              onPressed: () => open((_) => const FlowWidgetPage()),
              child: const Text('Flow Widget'),
            ),
            TextButton(
              onPressed: () => open((_) => const AnimatePage()),
              child: const Text('Animate'),
            ),
          ],
        ),
      ),
    );
  }

  open(pagina) {
    Navigator.push(context, MaterialPageRoute(builder: pagina));
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

  onTabBar() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const TabBarPage()));
  }

  onCRUDSupabase() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const CRUDSupabase()));
  }

  onMudarCores() {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).primaryColor,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Theme.of(context).primaryColor,
          systemNavigationBarIconBrightness: Brightness.light
        ),
    );
  }

  onBiometria() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const Biometria()));
  }
}
