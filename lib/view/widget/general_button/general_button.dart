import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/theam_manager.dart';

class GeneralButton extends StatelessWidget {
  const GeneralButton(
      {super.key,
      required this.Width,
      required this.onTap,
      this.isSelected = false,
      required this.label});

  final double Width;
  final Function()? onTap;
  final String label;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: height * 0.055,
        width: Width,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? colorGrey : colorMainTheme,
            borderRadius: BorderRadius.circular(Width * 0.04),
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontSize: width * 0.045,
                  color: colorWhite,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
