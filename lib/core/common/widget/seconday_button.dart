import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption_app/config/constants/theme_constant.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final double? verticalPadding;
  final double? buttonWidth;
  final double? buttonHeight;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;

  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isLoading,
    this.verticalPadding,
    this.buttonWidth,
    this.buttonHeight,
    this.borderRadius,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        boxShadow: boxShadow ??
            [
              const BoxShadow(
                blurRadius: 45,
                spreadRadius: 0,
                color: Color.fromRGBO(120, 37, 139, 0.25),
                offset: Offset(0, 25),
              )
            ],
        color: const Color.fromRGBO(225, 225, 225, 0.28),
      ),
      height: buttonHeight ?? size.height * 0.050,
      width: buttonWidth ?? double.infinity,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ThemeConstant.buttonColor,
                borderRadius: borderRadius ?? BorderRadius.circular(10),
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Opacity(
              opacity: isLoading ? 1.0 : 0.0,
              child: Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            if (isLoading)
              const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 2.0,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
