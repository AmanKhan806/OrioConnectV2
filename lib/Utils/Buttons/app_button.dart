import 'package:flutter/material.dart';
import 'package:orioconnect/Utils/Colors/colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.mediaQuery,
    this.backgroundColor = ColorResources.appMainColor,
    required this.onPressed,
    required this.child,
    required this.isLoading,
  });

  final MediaQueryData mediaQuery;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: mediaQuery.size.height * 0.06,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: isLoading
              ? ColorResources.greyColor
              : backgroundColor,
          foregroundColor: Colors.white, // Text/icon color
          elevation: 0, // Remove shadow for cleaner look
        ),
        child: isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Container(
                decoration: isLoading
                    ? null
                    : BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                alignment: Alignment.center,
                child: child,
              ),
      ),
    );
  }
}
