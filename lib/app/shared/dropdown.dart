import 'package:fleet_app/app/shared/colors.dart';
import 'package:flutter/material.dart';
import 'text_view.dart';

class MyDropDown extends StatelessWidget {
  final List<String> items;
  final String hint;
  final String? value;
  final String? errorText;
  final String? Function(String?)? validator;
  final ValueChanged<String?> onChanged;
  final Color? borderColor;
  final TextStyle? style;
  final double? height;
  final bool? isDense;
  final Widget? prefixIcon;

  const MyDropDown({
    Key? key,
    required this.items,
    required this.hint,
    required this.value,
    this.errorText,
    required this.onChanged,
    this.borderColor,
    this.validator,
    this.style,
    this.height = 50,
    this.isDense = false,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: height,
      // padding: const EdgeInsets.only(left: 11.53, right: 16),

      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          isCollapsed: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 11, vertical: 3),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: .5,
                color: borderColor ?? const Color(0xffAEB3B8),
              )),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                width: 1,
                color: AppColors.errorColor,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: .5,
                color: borderColor ?? const Color(0xffAEB3B8),
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: .5,
                color: borderColor ?? const Color(0xffAEB3B8),
              )),
        ),
        isDense: isDense!,
        style: const TextStyle(
          fontSize: 14,
          height: 1,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        isExpanded: true,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                height: 1,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          );
        }).toList(),
        value: value,
        hint: TextView(
          text: hint,
          color: AppColors.disabledTextColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}