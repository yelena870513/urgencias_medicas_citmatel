import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeNamedButtonLink extends StatelessWidget {
  final ValueNotifier<bool> isHomeButtonTapped = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isHomeButtonTapped,
      builder: (context, value, child) {
        return AnimatedContainer(
          duration: const Duration(seconds: 1),
          curve: Curves.ease,
          width: value ? 0 : 60,
          height: value ? 0 : 60,
          child: child,
        );
      },
      child: InkWell(
        child: Center(
            child: Image.asset(
          'assets/logos/home.png',
          width: 32,
          height: 32,
          fit: BoxFit.cover,
        )),
        onTap: () async {
          isHomeButtonTapped.value = true;
          await Future<dynamic>.delayed(const Duration(milliseconds: 500));
          Navigator.of(context).popAndPushNamed('/home');
        },
      ),
    );
  }
}
