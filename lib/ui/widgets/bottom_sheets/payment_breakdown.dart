import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/utilities/utilities.dart';
import '../close_icon.dart';
import '../custom_button.dart';
import '../naira_display.dart';

class PaymentBreakdown extends StatelessWidget {
  const PaymentBreakdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 24.h,
          left: 17.w,
          right: 17.w,
          bottom: 16.h
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Payment Summary',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).colorScheme.textPrimary
                    ),
                  ),
                ),
                CloseIcon()

              ],
            ),
            SizedBox(height: 16.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Payment Method',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.textPrimary
                  ),
                ),
                SizedBox(width: 10.w,),
                Flexible(
                  child: Text(
                    'Wallet',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.textPrimary
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 16.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Tickets:',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.textPrimary
                  ),
                ),
                SizedBox(width: 10.w,),
                Flexible(
                  child: Text(
                    '12',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.textPrimary
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 16.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sub-total',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.textPrimary
                  ),
                ),
                SizedBox(width: 10.w,),
                Flexible(
                  child:  NairaDisplay(
                    amount: 22000,
                    fontSize: 14.sp,
                    color:Theme.of(context).colorScheme.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
            SizedBox(height: 16.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Amount to Pay now',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.textPrimary
                  ),
                ),
                SizedBox(width: 10.w,),
                Flexible(
                  child:  NairaDisplay(
                    amount: 22000,
                    fontSize: 16.sp,
                    color:ColorPath.blueBlue,
                    fontWeight: FontWeight.w800,
                  ),
                )
              ],
            ),
            SizedBox(height: 40.h,),
            CustomButton(
                buttonText: 'Pay ₦${Utilities.formatAmount(
                  amount: 45000,
                  addDecimal: false
                )}',
                onPressed: () {

                }
            ),


          ],
        ),
      ),
    );
  }
}
