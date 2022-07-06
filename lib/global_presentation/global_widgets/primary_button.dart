
import '../../constants/exports.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? title;
  final Color? color;
  final Color? fontColor;
  final double? fontSize;

  const PrimaryButton(
      {Key? key,
      required this.onPressed,
      required this.title,
      this.color,
      this.fontSize = 15,
      this.fontColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: 50.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: color ?? ColorManager.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.h),
          ),
          elevation: 0,
        ),
        child: PrimaryText(
          title!,
          fontSize: fontSize!.sp,
          color: fontColor,
          fontWeight: FontWeightManager.bold,
        ),
      ),
    );
  }
}
