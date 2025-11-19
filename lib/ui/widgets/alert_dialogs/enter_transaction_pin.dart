import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import '../../../core/constants/app_asset.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/utilities/validator.dart';
import '../clickable.dart';
import '../custom_button.dart';
import '../custom_svg.dart';
import '../text_fields/custom_text_field.dart';

class EnterTransactionPin extends StatefulWidget {
  final ValueChanged<bool> onDone;
  final String? buttonText;
  const EnterTransactionPin({super.key, required this.onDone, this.buttonText});

  @override
  State<EnterTransactionPin> createState() => _EnterTransactionPinState();
}

class _EnterTransactionPinState extends State<EnterTransactionPin> {

  final _otp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 24.h,
          horizontal: 24.w
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomAssetViewer(asset: AppAsset.warning, height: 48.h, width: 48.w,),
          SizedBox(height: 32.h,),
          FittedBox(
            child: Text(
              'Enter Transaction PIN',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).colorScheme.textPrimary
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16.h,),
          Text(
            'Enter your four (4) Digit Transaction pin to complete this transaction',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.textSecondary
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h,),
          CustomTextField(
            isOtp: true,
            keyboardType: TextInputType.number,
            controller: _otp,
            validator: FieldValidator.validate,
            inputFormatters: [
              LengthLimitingTextInputFormatter(4),
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          SizedBox(height: 16.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Forgot Pin? ",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.textTertiary
                ),
              ),
              Clickable(
                onPressed: (){
                },
                child: Text(
                  "Reset",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: ColorPath.ribbonRed,
                      decoration: TextDecoration.underline,
                      decorationColor: ColorPath.ribbonRed
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h,),
          CustomButton(
              buttonText: widget.buttonText ?? 'Complete Transaction',
              onPressed: () {
                widget.onDone(true);
                popNavigation(context: context);
              }
          )


        ],
      ),
    );
  }
}
