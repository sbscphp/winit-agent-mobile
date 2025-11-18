import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_asset.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/ui/widgets/alert_dialogs/enter_transaction_pin.dart';
import 'package:winit_agent/ui/widgets/custom_svg.dart';

import '../../../core/constants/color_path.dart';
import '../custom_button.dart';

class CompleteWithdrawalRequest extends StatefulWidget {
  final ValueChanged<bool> onDone;
  const CompleteWithdrawalRequest({super.key, required this.onDone});

  @override
  State<CompleteWithdrawalRequest> createState() => _CompleteWithdrawalRequestState();
}

class _CompleteWithdrawalRequestState extends State<CompleteWithdrawalRequest> {

  bool _switch = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: confirmation(context),
      secondChild: EnterTransactionPin(
        onDone: (value){
          if(value){
            widget.onDone(value);
          }
        },
      ),
      crossFadeState: _switch ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      // firstCurve: Curves.easeInOut,
      // secondCurve: Curves.easeInOut,
      // sizeCurve: Curves.easeInOut,
      duration: const Duration(milliseconds: 350),
    );
  }

  confirmation(BuildContext context){
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
              'Complete Withdraw Request',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).colorScheme.textPrimary
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16.h,),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.textSecondary,
              ),
              children: [
                TextSpan(
                  text: 'Are you sure you want to complete this withdrawal request for Fund? Kindly note that process takes between 24 - 48 hours business day.   Be patient as your fund would be availed to you very soon.',
                ),
                TextSpan(
                  text: ' Thank YOU. ',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: ColorPath.blueBlue
                  ),
                ),

              ],
            ),
          ),
          SizedBox(height: 32.h,),
          CustomButton(
              buttonText: 'Yes, Complete request',
              onPressed: () {
                setState(() {
                  _switch = true;
                });
              }
          )


        ],
      ),
    );
  }
}
