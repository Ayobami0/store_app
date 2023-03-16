import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final Widget child;
  final int value;
  final Color? color;
  const Badge({required this.child, required this.value, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          right: 4,
          top: 4,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: color ?? Theme.of(context).colorScheme.secondary
            ),
            constraints: const BoxConstraints(maxHeight: 17, maxWidth: 17),
            child: Text(value.toString(), textAlign: TextAlign.center,),
          ),
        )
      ],
    );
  }
}
