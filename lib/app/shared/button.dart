import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';
import 'size.dart';
import 'text_view.dart';

class MyButton {
  static Widget fill(
      {required BuildContext context,
      Size? size,
      required String text,
      bool disabled = false,
      Color? backgroundColor,
      Color? textColor,
      FontWeight? fontWeight,
      double? fontSize,
      Widget? suffixWidget,
      bool? isTextButton,
      BorderRadiusGeometry? borderRadius,
      bool loading = false,
      required void Function()? onPressed}) {
    return AbsorbPointer(
      absorbing: disabled || loading,
      child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: (disabled
                      ? backgroundColor?.withOpacity(.5)
                      : loading
                          ? backgroundColor?.withOpacity(.5)
                          : backgroundColor) ??
                  (disabled
                      ? AppColors.primaryColor.withOpacity(.5)
                      : AppColors.primaryColor),
              side: isTextButton == true
                  ? BorderSide.none
                  : const BorderSide(
                      color: Color(0xFFFFA726), 
                      width: 1.5, 
                    ),
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(12),
              ),
              minimumSize: size ?? const Size(0, 59),
              textStyle: GoogleFonts.inter(
                  textStyle: TextStyle(
                      color: textColor ?? AppColors.textColor,
                      fontWeight: fontWeight ?? FontWeight.w700,
                      fontSize: fontSize ?? 16)),
              foregroundColor: textColor ?? Colors.white),
          onPressed: onPressed,
          child: loading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                )
              : FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    children: [
                      if (suffixWidget != null) ...[S.w(10), suffixWidget],
                      suffixWidget != null ? S.w(6.w) : const SizedBox.shrink(),
                      TextView(
                          text: text,
                          // lineHeight: 0,
                          textAlign: TextAlign.center,
                          color: textColor ?? Colors.white,
                          fontWeight: fontWeight ?? FontWeight.w700,
                          fontSize: fontSize ?? 16
                          // style: Theme.of(context).textTheme.titleLarge,
                          ),
                    ],
                  ),
                )),
    );
  }

  static Widget outlined(
      {required BuildContext context,
      Size? size,
      required String text,
      final Color? bgColor,
      bool disabled = false,
      bool hasIcon = false,
      Widget? iconWidget,
      required void Function()? onPressed}) {
    return AbsorbPointer(
      absorbing: disabled,
      child: OutlinedButton(
          style: TextButton.styleFrom(
              backgroundColor:
                  disabled ? AppColors.primaryColor.withOpacity(.5) : bgColor,
              side: BorderSide(
                  color: AppColors.textColor, width: disabled ? .5 : .2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              minimumSize: size ?? const Size(0, 59),
              textStyle: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w700,
              ),
              foregroundColor: AppColors.primaryColor),
          onPressed: onPressed,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: hasIcon == true
                ? Row(
                    children: [
                      iconWidget!,
                      S.w(10.w),
                      TextView(
                        text: text,
                        textAlign: TextAlign.center,
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w700,

                        // style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  )
                : TextView(
                    text: text,
                    textAlign: TextAlign.center,
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w700,

                    // style: Theme.of(context).textTheme.titleLarge,
                  ),
          )),
    );
  }
}
