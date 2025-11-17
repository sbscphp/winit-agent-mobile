import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/constants/color_path.dart';
import 'package:winit_agent/core/utilities/input_formatters/money_input_formatter.dart';
import 'package:winit_agent/core/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/ui/widgets/winit_container.dart';


class WalletActionTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Color? hintColor;
  final String? currencyString;
  final ValueChanged<String>? onChanged;
  final TextAlign? textAlign;
  final String? hintText;
  final FontWeight? hintFontWeight;
  final bool addCurrencySign;
  final Widget? prefixIcon;
  final Color textColor;
  final FocusNode? focusNode;
  final Color borderColor;
  final Color fillColor;
  final String label;
  const WalletActionTextField({super.key, required this.label, required this.fillColor, required this.borderColor, this.focusNode, required this.textColor, this.prefixIcon, this.addCurrencySign = true, this.hintFontWeight, this.hintText, this.textAlign, this.onChanged, this.controller, this.hintColor, this.currencyString = "₵"});

  @override
  Widget build(BuildContext context) {
    return WinitContainer(
      bgColor: ColorPath.remyPink,
      padding: EdgeInsets.only(
          top: 16.h,
          bottom: 26.h,
          left: 16.w,
          right: 16.w
      ),
      borderRadius: BorderRadius.all(Radius.circular(16.r)),
      border: Border.all(color: ColorPath.pigPink, width: 2.w),
      child: Column(
        children: [
          Text(
            'How much do you want to Withdraw ?',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.textSecondary
            ),
          ),
          SizedBox(height: 4.h,),
          TextFormField(
            controller: controller,
            cursorColor: textColor,
            focusNode: focusNode,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: onChanged,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 30.sp,
              color: textColor,
            ),
            inputFormatters: [
              MoneyInputFormatter(useCurrency: addCurrencySign)
            ],
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              prefixIconConstraints: BoxConstraints(
                minWidth: 24.w,
                minHeight: 24.h,
              ),
              contentPadding: const EdgeInsets.all(0),
              isDense: true,
              hintText: hintText ?? Utilities.nairaSign,
              hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 30.sp,
                color: textColor,
              ),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.transparent,
            ),
            textAlign: textAlign ?? TextAlign.center,
          )
        ],
      ),
    );
  }
}


