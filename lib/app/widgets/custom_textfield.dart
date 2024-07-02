//https://pub.dev/packages/dropdown_button2

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/app/widgets/my_custom_text.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool? obscureText;
  final bool? readOnly;
  final Widget? suffixIcon;
  final Widget? suffixIconColor;
  final Widget? prefixIcon;
  final String? hintText;
  final Widget? label;
  final String? extraLabel;
  final TextStyle? labelStyle;
  final TextStyle? extraLabelStyle;
  final TextStyle? errorStyle;
  final VoidCallback? onTap;
  final AutovalidateMode? autovalidateMode;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function(String)? onChange;
  final EdgeInsetsGeometry? padding;
  final Color? cursorColor;
  final TextAlign? textAlign;
  final double? fontSize;
  final List<TextInputFormatter>? inputFormatters;
  final bool? autofocus;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final String? errorText;
  final VoidCallback? onEditingComplete;
  final int? maxLines;
  final double? marginBottom;
  final bool isFilled;

  const CustomTextField({
    super.key,
    this.controller,
    this.obscureText,
    this.readOnly,
    this.suffixIcon,
    this.prefixIcon,
    this.hintText,
    this.label,
    this.onTap,
    this.autovalidateMode,
    this.keyboardType,
    this.validator,
    this.onChange,
    this.padding,
    this.cursorColor,
    this.inputFormatters,
    this.autofocus,
    this.textAlign,
    this.fontSize,
    this.style,
    this.errorText,
    this.onEditingComplete,
    this.maxLines,
    this.suffixIconColor,
    this.extraLabel,
    this.extraLabelStyle,
    this.labelStyle,
    this.errorStyle,
    this.marginBottom,
    this.hintStyle,
    this.isFilled = false,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ********** extraLabel ********
        if (extraLabel != null) MyCustomText(extraLabel ?? ""),
        if (extraLabel != null)
          const SizedBox(
            height: 10,
          ),
        TextFormField(
          // ********** controller ********
          controller: controller,
          // ********** validator ********
          validator: validator,
          // ********** onChanged ********
          onChanged: onChange,
          // ********** obscureText ********
          obscureText: obscureText ?? false,
          // ********** readOnly ********
          readOnly: readOnly ?? false,
          // ********** autovalidateMode ********
          autovalidateMode: autovalidateMode,
          // ********** cursorColor ********
          cursorColor: cursorColor ?? theme.primaryColor,
          // ********** maxLines ********
          maxLines: maxLines ?? 1,
          // ********** autofocus ********
          autofocus: autofocus ?? false,
          // ********** textAlign ********
          textAlign: textAlign ?? TextAlign.start,
          // ********** onTap ********
          onTap: onTap,
          // ********** style ********
          style: style ?? theme.textTheme.bodyLarge,
          // ********** controller ********
          onEditingComplete: onEditingComplete,
          // ********** keyboardType ********
          keyboardType: keyboardType,
          //! ********** decoration ********
          decoration: InputDecoration(
            filled: isFilled,
            fillColor: theme.scaffoldBackgroundColor,
            // ********** errorText ********
            errorText: errorText,
            errorStyle: errorStyle ??
                theme.textTheme.bodyLarge?.copyWith(color: Colors.red),
            errorMaxLines: 5,
            // ********** padding ********

            contentPadding: padding ??
                const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            // ********** prefixIcon ********
            prefixIcon: prefixIcon,
            // ********** suffixIcon ********
            suffixIcon: suffixIcon,
            // ********** border ********
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: theme.hintColor)),
            // ********** focusedBorder ********
            focusColor: theme.primaryColor,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: BorderSide(color: theme.hintColor)),
            // ********** enabledBorder ********
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: BorderSide(color: theme.hintColor)),
            // ********** errorBorder ********
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: BorderSide(color: theme.hintColor)),
            // ********** hintText ********
            hintText: hintText,
            hintStyle: hintStyle ??
                theme.textTheme.bodyLarge?.copyWith(color: theme.hintColor),
            // ********** label ********
            label: label,
            labelStyle: labelStyle ?? theme.textTheme.labelLarge,
          ),
          // ********** inputFormatters ********
          inputFormatters:
              inputFormatters ?? [LengthLimitingTextInputFormatter(256)],
        ),
        // ********** marginBottom ********
        SizedBox(
          height: marginBottom,
        )
      ],
    );
  }
}

class CustomDropdownTextField extends StatelessWidget {
  const CustomDropdownTextField({
    super.key,
    this.label,
    required this.onChanged,
    this.hint,
    this.icon,
    this.enabledBorderColor,
    this.borderColor,
    this.hintStyle,
    this.value,
    required this.items,
  });

  final String? label;
  final Widget? hint;
  final Widget? icon;
  final Function(String?) onChanged;
  final Color? enabledBorderColor;
  final Color? borderColor;
  final TextStyle? hintStyle;
  final String? value;
  final List<DropdownMenuItem<String>>? items;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) MyCustomText(label ?? ""),
        SizedBox(height: label == null ? 0 : 8),
        DropdownButtonFormField<String>(
          hint: hint ??
              Text(
                'Select',
                style: theme.textTheme.bodyLarge
                    ?.copyWith(color: const Color(0xFFC0C0C0)),
              ),
          icon: icon,
          value: value,
          dropdownColor: theme.scaffoldBackgroundColor,
          focusColor: theme.scaffoldBackgroundColor,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: theme.hintColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: theme.hintColor)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: theme.hintColor)),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
              // filled: true,
              // fillColor: theme.scaffoldBackgroundColor,
              focusColor: theme.scaffoldBackgroundColor,
              hintStyle: hintStyle ??
                  theme.textTheme.bodyLarge?.copyWith(
                      color: theme.hintColor) // Set the background color here
              ),
          items: items,
          onChanged: onChanged,
        ),
        // SizedBox(height: 24.h),
      ],
    );
  }
}
// class CustomTextWithLabel extends StatelessWidget {
//   final String text;
//   final String text2;
//   final Color? color;
//   final double? fontSize;
//   final dynamic fontWeight;
//   final dynamic textAlign;
//   final TextOverflow? overflow;

//   const CustomTextWithLabel(
//       {required this.text,
//       this.color,
//       this.fontSize,
//       this.fontWeight,
//       this.textAlign,
//       Key? key,
//       this.overflow,
//       required this.text2})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) => Row(
//         children: [
//           Text(text,
//               textAlign: textAlign ?? TextAlign.start,
//               overflow: overflow,
//               style: TextStyle(
//                   color: color ?? kTextColor,
//                   fontSize: fontSize ?? 14,
//                   fontWeight: fontWeight ?? FontWeight.w500)),
//           Text(text2,
//               textAlign: textAlign ?? TextAlign.start,
//               overflow: overflow,
//               style: TextStyle(
//                   color: color ?? kTextColor,
//                   fontSize: fontSize ?? 14,
//                   fontWeight: fontWeight ?? FontWeight.w500)),
//         ],
//       );
// }

// class CustomRadioTile1 extends StatelessWidget {
//   final Function(String?)? onChange;
//   final String value, groupValue, title, subtitle;
//   const CustomRadioTile1({
//     Key? key,
//     required this.onChange,
//     required this.value,
//     required this.groupValue,
//     required this.title,
//     required this.subtitle,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 80,
//       child: GestureDetector(
//         onTap: () {
//           onChange!(value);
//         },
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Radio(
//               value: value,
//               groupValue: groupValue,
//               onChanged: onChange,
//               activeColor: kSuccessColor,
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   6.height,
//                   Text(
//                     value,
//                     textAlign: TextAlign.start,
//                     style: kTitleMedium,
//                   ),
//                   SizedBox(
//                     child: Text(
//                       subtitle,
//                       textAlign: TextAlign.start,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w300,
//                         color: Color(0xff222222),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
