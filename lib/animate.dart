import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatePage extends StatefulWidget {
  const AnimatePage({super.key});

  @override
  State<AnimatePage> createState() => _AnimatePageState();
}

class _AnimatePageState extends State<AnimatePage> {
  final start = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade800,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('\u{1F3C0}', style: TextStyle(fontSize: 190))
                .animate(onPlay: (controller) => controller.repeat())
                .moveY(
                    begin: -25,
                    end: 15,
                    curve: Curves.easeInOut,
                    duration: 1000.ms)
                .then()
                .moveY(begin: 15, end: -25, curve: Curves.easeInOut),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                width: 150,
                height: 15,
                decoration: const BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.all(Radius.elliptical(150, 15))),
              ),
            )
                .animate(onPlay: (controller) => controller.repeat())
                .scaleX(
                    begin: 0.8,
                    end: 1.2,
                    curve: Curves.easeInOut,
                    duration: 1000.ms)
                .then()
                .scaleX(begin: 1.2, end: 0.8, curve: Curves.easeInOut),
            const SizedBox(height: 100),
            ValueListenableBuilder(
              valueListenable: start,
              builder: (context, started, _) => SizedBox(
                width: MediaQuery.of(context).size.width - 60,
                height: 70,
                child: FilledButton(
                  onPressed: () => start.value = !start.value,
                  child: Text(
                    'JOGAR',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(.7),
                    ),
                  ),
                ),
              )
                  .animate(
                    target: started ? 1 : 0,
                    onPlay: (controller) => controller.reverse(),
                    onComplete: (controller) => debugPrint('Completou'),
                  )
                  .elevation(
                      end: 20,
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(50))
                  .shake(hz: 2, rotation: 0.2)
                  .flip(begin: -0.2)
                  .slideY(end: -0.5)
                  .scaleXY(begin: .7)
                  .animate(onPlay: (controller) {
                    controller.repeat();
                    if (started) {
                      controller.stop();
                    }
                  })
                  .shimmer(delay: 5000.ms, duration: 1000.ms)
                  .shakeX(hz: 5),
            ),
          ],
        ),
      ),
    );
  }
}
