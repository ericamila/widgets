import 'package:flutter/material.dart';

class SpacerPage extends StatelessWidget {
  const SpacerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(flex: 5, child: Image.asset('images/baixados.jpeg')),
            const Spacer(),
            Flexible(flex: 5, child: Image.asset('images/baixados1.jpeg')),
            const Spacer(),
            Flexible(flex: 5, child: Image.asset('images/baixados2.jpeg')),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(flex: 5, child: Image.asset('images/baixados.jpeg')),
                const Spacer(),
                Flexible(flex: 5, child: Image.asset('images/baixados1.jpeg')),
                const Spacer(),
                Flexible(flex: 5, child: Image.asset('images/baixados2.jpeg')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
