import 'package:wocontacts/utils/app_colors.dart';
import 'package:wocontacts/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSearchField extends StatelessWidget {

  const CustomSearchField({super.key, required this.hint});
  final String hint;

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 56,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 16),
      decoration: ShapeDecoration(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: AppColors.black_20),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      alignment: Alignment.centerLeft,
      child: Row(
          children: [
            SvgPicture.asset(AppIcons.search),
            const SizedBox(width: 8),
            Expanded(
              child: TextFormField(
                cursorColor: AppColors.black_10,
                style: GoogleFonts.poppins(color: AppColors.black_100, fontSize: 14, fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsetsDirectional.only(top: -24),
                    hintText: hint,
                    hintStyle: GoogleFonts.montserrat(
                      color: AppColors.black_40,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none
                ),
              ),
            )
          ]
      ),
    );
  }
}