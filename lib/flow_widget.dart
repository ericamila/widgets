import 'package:flutter/material.dart';

class FlowWidgetPage extends StatefulWidget {
  const FlowWidgetPage({super.key});

  @override
  State<FlowWidgetPage> createState() => _FlowWidgetPageState();
}

class _FlowWidgetPageState extends State<FlowWidgetPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      floatingActionButton: FabMenuButton(),
    );
  }
}

class FabMenuButton extends StatefulWidget {
  const FabMenuButton({super.key});

  @override
  State<FabMenuButton> createState() => _FabMenuButtonState();
}

class _FabMenuButtonState extends State<FabMenuButton>
    with SingleTickerProviderStateMixin {
  final actionButtonColor = Colors.tealAccent.shade100;
  late final AnimationController _controller;
  final menuIsOpen = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  toggleMenu() {
    menuIsOpen.value ? _controller.reverse() : _controller.forward();
    menuIsOpen.value = !menuIsOpen.value;
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      clipBehavior: Clip.none,
      delegate: FabVerticalDelegate(animation: _controller),
      children: [
        FloatingActionButton(
          onPressed: () => toggleMenu(),
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _controller,
          ),
        ),
        FloatingActionButton(
          onPressed: () {},
          backgroundColor: actionButtonColor,
          child: const Icon(Icons.camera_alt_rounded),
        ),
        FloatingActionButton(
          onPressed: () {},
          backgroundColor: actionButtonColor,
          child: const Icon(Icons.link),
        ),
        FloatingActionButton(
          onPressed: () {},
          backgroundColor: actionButtonColor,
          child: const Icon(Icons.attach_file),
        ),
      ],
    );
  }
}

class FabVerticalDelegate extends FlowDelegate {
  final AnimationController animation;

  const FabVerticalDelegate({required this.animation})
      : super(repaint: animation);

  @override
  void paintChildren(FlowPaintingContext context) {
    final lastFabIndex = context.childCount - 1;
    const buttonSize = 56;
    const buttonRadius = buttonSize / 2;
    const buttonMargin = 10;

    final positionX = context.size.width - buttonSize;
    final positionY = context.size.height - buttonSize;

    for (int i = lastFabIndex; i >= 0; i--) {
      final y = positionY - ((buttonSize + buttonMargin) * i * animation.value);
      final size = (i != 0) ? animation.value : 1.0;

      context.paintChild(
        i,
        transform: Matrix4.translationValues(positionX, y, 0)
          ..translate(buttonRadius, buttonRadius)
          ..scale(size)
          ..translate(-buttonRadius, -buttonRadius),
      );
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}
