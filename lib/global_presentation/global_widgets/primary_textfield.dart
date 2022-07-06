import 'package:google_fonts/google_fonts.dart';

import '../../constants/exports.dart';

class PrimaryTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final bool readOnly;
  final bool? multiLines;
  final TextInputAction? textInputAction;
  final String? title;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final bool? filled;
  final Color? fillColor;


  const PrimaryTextField({
    Key? key,
    this.hintText,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.onTap,
    this.focusedBorder,
    this.filled,
    this.onChanged,
    this.fillColor,
    this.enabledBorder,
    this.readOnly = false,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.multiLines = false,
    this.textInputAction = TextInputAction.none,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle hintStyle = TextStyle(color: ColorManager.grey, fontSize: 14.sp);
    TextStyle style = TextStyle(color: ColorManager.fontColor);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PrimaryText(
          title ?? "",
          color: ColorManager.fontColor,
        ),
        SizedBox(height: 10.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            color: ColorManager.white,
          ),
          child: TextFormField(
            controller: controller,
            readOnly: readOnly,
            textInputAction: textInputAction,
            maxLines: multiLines! ? 10 : 1,
            cursorColor: ColorManager.fontColor,
            style: Get.locale!.languageCode != 'ar'
                ? GoogleFonts.varelaRound(textStyle: style)
                : GoogleFonts.tajawal(
                    textStyle: style,
                  ),
            keyboardType: keyboardType,
            onTap: onTap ?? () {},
            onFieldSubmitted: onFieldSubmitted ?? (String value) {},
            onChanged: onChanged ?? (String value) {},
            decoration: InputDecoration(
              filled: filled,
              fillColor: fillColor,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              focusColor: ColorManager.primary,
              focusedBorder: focusedBorder,
              enabledBorder: enabledBorder,
              hoverColor: ColorManager.primary,
              hintText: hintText ?? "",
              hintStyle: Get.locale!.languageCode != 'ar'
                  ? GoogleFonts.varelaRound(textStyle: hintStyle)
                  : GoogleFonts.tajawal(
                      textStyle: hintStyle,
                    ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              contentPadding: const EdgeInsets.fromLTRB(15.0, 20.0, 20.0, 20.0),
            ),
            validator: validator ??
                (String? value) {
                  if (value!.length < 6) {
                    // return LocaleKeys.invalid_password.tr;
                  }
                  return null;
                },
          ),
        ),
      ],
    );
  }
}
