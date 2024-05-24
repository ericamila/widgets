import 'package:flutter/material.dart';

class DropPageCustom extends StatelessWidget {
  DropPageCustom({super.key});

  final dropValue = ValueNotifier('');
  final dropOpcoes = ['Audi', 'BMW', 'Ferrary', 'Lamborghini', 'Tesla'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ValueListenableBuilder(
            valueListenable: dropValue,
            builder: (context, value, _) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  icon: const Icon(Icons.drive_eta),
                  hint: const Text('Escolha a marca'),
                  decoration: InputDecoration(
                      label: const Text('Marca'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      )),
                  value: (value.isEmpty) ? null : value,
                  onChanged: (escolha) => dropValue.value = escolha.toString(),
                  items: dropOpcoes
                      .map(
                        (opcao) => DropdownMenuItem(
                          value: opcao,
                          child: Text(opcao),
                        ),
                      )
                      .toList(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
