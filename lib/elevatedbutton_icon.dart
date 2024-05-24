import 'package:flutter/material.dart';

class ElevatedButtonIconCustom extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function()? onPressed;

  const ElevatedButtonIconCustom({
    super.key,
    required this.onPressed,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton.icon(
              icon: Icon(icon),
              label: Text(label),
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
