import 'package:flutter/material.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({super.key});

  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abas'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: "Home",
              icon: Icon(Icons.home),
            ),
            Tab(
              text: "email",
              icon: Icon(Icons.email),
            ),
            Tab(
              text: "conta",
              icon: Icon(Icons.account_circle),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          PrimeiraPagina(),
          SegundaPagina(),
          TerceiraPagina(),
        ],
      ),
    );
  }
}

class PrimeiraPagina extends StatelessWidget {
  const PrimeiraPagina({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Primeira página'));
  }
}

class SegundaPagina extends StatelessWidget {
  const SegundaPagina({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Segunda página'));
  }
}

class TerceiraPagina extends StatelessWidget {
  const TerceiraPagina({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Terceira página'));
  }
}
