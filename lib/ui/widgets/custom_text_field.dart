import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';



class CustomTextField extends StatefulWidget {
  final String label;
  final double? labelSize;
  final FontWeight labelFontWeight;
  final Color? labelColor;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final double? textSize;
  final Color textColor;
  final bool obscure;
  final  Widget? suffixIcon;
  final  Widget? prefixIcon;
  final  Widget? prefix;
  final String hintText;
  final String bottomHintText;
  final double? hintSize;
  final Color? hintColor;
  final bool enabled;
  final bool readOnly;
  final bool isCompulsory;
  final FocusNode? focusNode;
  final int maxLines;
  final bool isOtp;


  const CustomTextField(
      {super.key,
        this.label = '',
        this.labelSize,
        this.labelFontWeight = FontWeight.w400,
        this.labelColor,
        this.controller,
        this.onChanged,
        this.validator,
        this.inputFormatters,
        this.keyboardType = TextInputType.text,
        this.textSize,
        this.textColor = Colors.black,
        this.obscure = false,
        this.suffixIcon,
        this.hintText = '',
        this.hintSize,
        this.hintColor,
        this.enabled = true,
        this.readOnly = false,
        this.prefixIcon,
        this.bottomHintText = '',
        this.isCompulsory = true,
        this.focusNode,
        this.maxLines = 1,
        this.isOtp = false,
        this.prefix
      });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {




  
  @override
  Widget build(BuildContext context) {

    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: colorScheme.textFieldFillColor,
              borderRadius: BorderRadius.all(Radius.circular(6.r))
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
            child: TextFormField(
              focusNode: widget.focusNode,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                enabled: widget.enabled,
                readOnly: widget.readOnly,
                validator: widget.validator,
                controller: widget.controller,
                obscureText: widget.obscure,
                textAlign: widget.isOtp ? TextAlign.center : TextAlign.start,
                style: widget.isOtp ? Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: widget.textSize?.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.brandColor,
                  letterSpacing: 24
                ):Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: widget.textSize?.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.brandColor,
                ),
                onChanged: widget.onChanged,
                keyboardType: widget.keyboardType,
                inputFormatters: widget.inputFormatters,
                maxLines: widget.maxLines,
                decoration: InputDecoration(
                  label:widget.isOtp ? null :
                  Text(
                    widget.label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.textSecondary
                    ),
                  ),
                  errorMaxLines: 3,
                  //hintText: widget.hintText,
                  hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.textSecondary
                  ),
                  //TextStyle(fontSize: widget.hintSize.sp, color: widget.hintColor?.withOpacity(0.3) ?? colorScheme.textSecondary, height: 0),
                  suffixIcon: widget.suffixIcon,
                  suffixIconConstraints: BoxConstraints(
                    minWidth: 25.w,
                    minHeight: 25.h,
                  ),
                  prefixIcon: widget.prefixIcon,
                  prefix: widget.prefix,
                  prefixIconConstraints: BoxConstraints(
                    minWidth: 25.w,
                    minHeight: 25.h,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  contentPadding: EdgeInsets.only(left: 16.w, right: 16.w, top: 9.h, bottom: 9.h),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent, width: 1.w),
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: widget.isOtp ? Colors.transparent:colorScheme.brandColor, width: 1.w)),
                  disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent, width: 1.w)),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: widget.isOtp ? Colors.transparent:colorScheme.brandColor, width: 1.w)),
                )
            ),
          ),
        ),
      ],
    );

  }
}
