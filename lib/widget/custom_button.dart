import 'package:admin_panal/widget/constant_color.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;  // optionally fixed width
  final double? height; 
  final Widget? child;// optionally fixed height

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.width,
    this.height,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // To match FormContainer width behavior, we let width be full width of parent or provided width
    double buttonWidth = width ?? MediaQuery.of(context).size.width;
    double buttonHeight = height ?? 60; // slightly taller for card-like appearance

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Container(
        width: buttonWidth,
        height: buttonHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Color(0x33000000),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(
            color: Color(0x1A000000),
            width: 1,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: child ?? Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFE3F2F3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.book_outlined,
                      color: themeblue,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          text,
                          style: TextStyle(
                            color: Colors.black87,
                            fontFamily: "Ubuntu",
                            fontSize: MediaQuery.of(context).size.width * 0.045,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Advanced level questions",
                          style: TextStyle(
                            color: Color(0xFF757575),
                            fontFamily: "Ubuntu",
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFFBDBDBD),
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
