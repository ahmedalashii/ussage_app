import 'package:google_fonts/google_fonts.dart';

import '../../constants/exports.dart';


class PrimaryText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final int maxLines;
  final bool lineThrow;
  final double height;
  final double? letterSpacing;


  const PrimaryText(
    this.text, {
    Key? key,
    this.fontSize = 15,
    this.color,
    this.letterSpacing,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.clip,
    this.maxLines = 5,
    this.lineThrow = false,
    this.height = 1.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
      color: color ?? ColorManager.white,
      fontSize: (fontSize - 2).sp,
      fontWeight: fontWeight,
      height: height,
      decoration: lineThrow ? TextDecoration.lineThrough : TextDecoration.none,
      letterSpacing: letterSpacing,
    );
    return Text(text.tr,
        textAlign: textAlign,
        overflow: overflow,
        maxLines: maxLines,
        softWrap: false,
        textDirection: TextDirection.ltr,
        style: Get.locale!.languageCode == 'en'
            ? GoogleFonts.varelaRound(textStyle: style)
            : GoogleFonts.tajawal(
                textStyle: style,
              ));
  }
}
