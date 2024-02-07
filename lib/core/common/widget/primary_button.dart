import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption_app/config/constants/theme_constant.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final double? buttonWidth;
  final double? buttonHeight;
  final Color? buttonColor;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isLoading,
    this.buttonWidth,
    this.buttonHeight,
    this.buttonColor,
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
                color: buttonColor ?? ThemeConstant.buttonColor,
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
