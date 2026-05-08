import 'package:flutter/material.dart';

class AppLogoWidget extends StatelessWidget {
  final double size;
  final bool showShadow;
  final bool showCircleBackground;

  const AppLogoWidget({
    Key? key,
    this.size = 100,
    this.showShadow = true,
    this.showCircleBackground = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget logo = Image.asset(
      'assets/images/rihlaty_logo.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Icon(
          Icons.local_shipping,
          size: size,
          color: Colors.red,
        );
      },
    );

    if (showCircleBackground) {
      logo = Container(
        width: size + 20,
        height: size + 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: showShadow
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ]
              : [],
        ),
        child: Center(child: logo),
      );
    } else if (showShadow) {
      logo = Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: logo,
      );
    }

    return logo;
  }
}
