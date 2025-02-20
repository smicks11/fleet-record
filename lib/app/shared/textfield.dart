import 'package:fleet_app/app/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final Widget? suffixIcon;
  final Widget? preffixIcon;
  final bool obscure;
  final double? height;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final BoxConstraints? prefixIconConstraints;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final Function()? onTap;
  final bool readOnly;
  final void Function(String)? onChanged;
  final bool enable;
  final String? initialValue;
  final bool autofocus;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  const CustomTextField({
    Key? key,
    required this.hint,
    this.suffixIcon,
    this.onFieldSubmitted,
    this.obscure = false,
    this.height,
    this.preffixIcon,
    this.inputFormatters,
    this.keyboardType,
    this.prefixIconConstraints,
    this.controller,
    this.initialValue,
    this.validator,
    this.onTap,
    this.onChanged,
    this.readOnly = false,
    this.autofocus = false,
    this.enable = true,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14.r),
      // height: height,
      child: TextFormField(
        controller: controller,
        autofocus: autofocus,
        obscureText: obscure,
        expands: height != null ? true : false,
        maxLines: height != null ? null : 1,
        focusNode: focusNode,
        initialValue: initialValue,
        cursorColor: AppColors.primaryColor,
        onFieldSubmitted: onFieldSubmitted,
        // maxLength: null,
        // textAlign: TextAlign.end,
        // enabled: false,
        readOnly: readOnly,
        onChanged: onChanged,
        onTap: onTap,
        textAlignVertical: height != null ? TextAlignVertical.top : null,
        style: TextStyle(
          fontSize: 16,
          height: 1,
          fontWeight: FontWeight.w400,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : AppColors.textColor,
        ),
        validator: validator,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 24.h),
          // enabled: enable,
          // filled: !enable ? true : null,
          filled: true,
          fillColor: Theme.of(context).brightness == Brightness.dark
              ? const Color.fromARGB(221, 17, 16, 16)
              : Colors.grey[200],
          prefixIconConstraints: prefixIconConstraints,
          prefixIcon: preffixIcon,
           suffixIcon: suffixIcon == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      suffixIcon ?? Container(),
                    ],
                  ),
                ),
          // labelText: Platform.isAndroid ? label : null,
          // isDense: true,
          // floatingLabelStyle: Theme.of(context)
          //     .textTheme
          //     .labelLarge!
          //     .copyWith(color: Theme.of(context).primaryColor),
          // labelStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
          //       color: greySwatch[400],
          //     ),

          hintStyle: const TextStyle(
            fontSize: 14,
            height: 0,
            fontWeight: FontWeight.w400,
            color: Color(0xff758089),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class CustomOutlineTextField extends StatelessWidget {
  final String hint;
  final Widget? suffixIcon;
  final Widget? preffixIcon;
  final bool obscure;
  final double? height;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final BoxConstraints? prefixIconConstraints;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final Function()? onTap;
  final bool readOnly;
  final void Function(String)? onChanged;
  final bool enable;
  final String? initialValue;
  final bool autofocus;
  final FocusNode? focusNode;
  const CustomOutlineTextField({
    Key? key,
    required this.hint,
    this.suffixIcon,
    this.obscure = false,
    this.height,
    this.preffixIcon,
    this.inputFormatters,
    this.keyboardType,
    this.prefixIconConstraints,
    this.controller,
    this.initialValue,
    this.validator,
    this.onTap,
    this.onChanged,
    this.readOnly = false,
    this.autofocus = false,
    this.enable = true,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: height,
      child: TextFormField(
        controller: controller,
        autofocus: autofocus,
        obscureText: obscure,
        expands: height != null ? true : false,
        maxLines: height != null ? null : 1,
        focusNode: focusNode,
        initialValue: initialValue,
        // maxLength: null,
        // textAlign: TextAlign.end,
        // enabled: false,
        readOnly: readOnly,
        onChanged: onChanged,
        onTap: onTap,
        textAlignVertical: height != null ? TextAlignVertical.top : null,

        style: const TextStyle(
          fontSize: 14,
          height: 1,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        validator: validator,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 10),
          hintText: hint,
          enabled: enable,
          filled: !enable ? true : null,
          fillColor: Colors.grey.shade100,
          prefixIconConstraints: prefixIconConstraints,
          // labelText: Platform.isAndroid ? label : null,
          // isDense: true,
          // floatingLabelStyle: Theme.of(context)
          //     .textTheme
          //     .labelLarge!
          //     .copyWith(color: Theme.of(context).primaryColor),
          // labelStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
          //       color: greySwatch[400],
          //     ),

          hintStyle: const TextStyle(
            fontSize: 14,
            height: 0,
            fontWeight: FontWeight.w400,
            color: Color(0xff758089),
          ),
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: .5),
          ),
          prefixIcon: preffixIcon == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(left: 16, right: 0),
                  child: preffixIcon,
                ),
          suffixIcon: suffixIcon == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      suffixIcon ?? Container(),
                    ],
                  ),
                ),
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
          ),
          // constraints: const BoxConstraints(maxHeight: 50, minHeight: 50),
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: .5),
          ),
        ),
      ),
    );
  }
}
