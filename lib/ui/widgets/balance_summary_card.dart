import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';

import '../../core/constants/color_path.dart';
import '../../core/utilities/utilities.dart';
import 'naira_display.dart';

class BalanceSummaryCard extends StatelessWidget {
  final String label;
  final double balance;
  final double amountAdded;
  const BalanceSummaryCard({super.key, required this.label, required this.balance, required this.amountAdded});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          vertical: 16.h,
          horizontal: 16.w
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.brandColor,
          borderRadius: BorderRadius.all(Radius.circular(16.r))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: ColorPath.mischkaGrey
            ),
          ),
          SizedBox(height: 10.h,),
          NairaDisplay(
            amount: balance,
            fontSize: 24.sp,
            color:Colors.white,
            fontWeight: FontWeight.w800,
          ),
          SizedBox(height: 10.h,),
          FittedBox(
            child: amountAdded != 0 ? RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  color: ColorPath.turquoiseGreen,
                ),
                children: [
                  TextSpan(
                    text: '+ ₦ ${Utilities.formatAmount(
                      amount: amountAdded,
                      addDecimal: true
                    )}',
                  ),
                  TextSpan(
                    text: ' added in last 4 days',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: ColorPath.frenchGrey
                    ),
                  ),

                ],
              ),
            ):Text(
              'No data available',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                color: ColorPath.turquoiseGreen,
              ),
            ),
          )
        ],
      ),
    );
  }
}
