import 'package:flutter/material.dart';

class HomeBackgroundColor extends AnimatedWidget {
  final Animation<double> opacity;

  const HomeBackgroundColor(this.opacity, {Key? key})
      : super(key: key, listenable: opacity);

  Animation<double> get progress => opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height / 2.4) * progress.value,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green, Color.fromARGB(255, 3, 3, 55)],
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
    );
  }
}
