import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/utilities/extensions/color_extensions.dart';

import '../../../core/constants/color_path.dart';

class OnboardingDropDown extends StatefulWidget {
  final String label;
  final double? height;
  final double? labelSize;
  final FontWeight labelFontWeight;
  final Color? labelColor;
  final TextEditingController? controller;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final double? textSize;
  final Color textColor;
  final Color? fillColor;
  final bool obscure;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hintText;
  final String bottomHintText;
  final double? hintSize;
  final Color? hintColor;
  final Color? bottomHintColor;
  final bool enabled;
  final bool readOnly;
  final bool isCompulsory;
  final FocusNode? focusPointer;
  final int maxLines;
  final bool isOtp;
  final bool showLabel;
  final Color? borderColor;
  final double? borderWidth;
  final bool useDefaultHeight;
  //final String? Function(String?)? validator;
  final List<String> items;
  final String? value;
  final FocusNode? focusNode;




  const OnboardingDropDown({
    super.key,
    this.height,
    this.showLabel = true,
    this.label = '',
    this.labelSize,
    this.labelFontWeight = FontWeight.w500,
    this.labelColor,
    this.controller,
    this.onChanged,
    this.validator,
    this.inputFormatters,
    this.keyboardType = TextInputType.text,
    this.textSize,
    this.textColor = Colors.black,
    this.fillColor,
    this.obscure = false,
    this.suffixIcon,
    this.hintText,
    this.hintSize,
    this.hintColor,
    this.bottomHintColor,
    this.enabled = true,
    this.readOnly = false,
    this.prefixIcon,
    this.bottomHintText = '',
    this.isCompulsory = true,
    this.focusPointer,
    this.maxLines = 1,
    this.isOtp = false,
    this.borderColor,
    this.borderWidth,
    this.useDefaultHeight = true,
    //this.validator,
    this.focusNode,
    required this.items, this.value
  });

  @override
  State<OnboardingDropDown> createState() => _OnboardingDropDownState();
}

class _OnboardingDropDownState extends State<OnboardingDropDown> {

  bool _isFocused = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusPointer ?? FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    if (widget.focusPointer == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showLabel)
          Row(
            children: [
              Text(
                widget.label,
                style: textTheme.bodySmall?.copyWith(
                  color: widget.labelColor ?? colorScheme.textFieldLabel,
                  fontWeight: widget.labelFontWeight,
                ),
              ),
              if (widget.isCompulsory) SizedBox(width: 5.w),
              if (widget.isCompulsory)
                Text(
                  '*',
                  style: textTheme.bodyMedium?.copyWith(
                    color: ColorPath.ribbonRed,
                    fontSize:widget.labelSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        if (widget.showLabel) SizedBox(height: 8.h),
        AbsorbPointer(
          absorbing: !widget.enabled,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: widget.useDefaultHeight ? widget.height?.h ?? 36.h : null,
            width: double.infinity,
            decoration: BoxDecoration(
              color: colorScheme.onboardingTextFieldFillColor,
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
              border: Border.all(
                  color: _isFocused ? colorScheme.textFieldFocusedBorder
                      : colorScheme.textFieldBorder,
                  width: 1.w
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      focusNode: widget.focusNode,
                      value: widget.value,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 0), // ✅ balanced vertically
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: widget.hintText,
                        hintStyle: textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.textFieldHint,
                        ),
                      ),
                      items: widget.items.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(
                            dropDownStringItem,
                            style: textTheme.bodyMedium?.copyWith(
                              fontSize: widget.textSize?.sp,
                              fontWeight: FontWeight.w500,
                              color: colorScheme.brandColor,
                            ),
                          ),
                        );
                      }).toList(),
                      style: textTheme.bodySmall?.copyWith(
                        fontSize: widget.textSize?.sp,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context)
                            .colorScheme
                            .blackText
                            .withCustomOpacity(0.85),
                      ),
                      elevation: 1,
                      icon: const SizedBox.shrink(),
                      onChanged: widget.onChanged,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down,
                      color: colorScheme.textSecondary, size: 20.w),
                ],
              ),
            ),
          ),
        ),
        if (widget.bottomHintText.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: Text(
              widget.bottomHintText,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w400,
                color: widget.bottomHintColor ??
                    Theme.of(context).colorScheme.textFieldHint,
              ),
            ),
          ),
      ],
    );
  }
}
