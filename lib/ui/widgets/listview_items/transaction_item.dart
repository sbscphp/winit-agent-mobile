import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/utilities/date_utilitites.dart';
import 'package:winit_agent/ui/widgets/winit_container.dart';
import '../../../core/constants/app_asset.dart';
import '../custom_svg.dart';
import '../naira_display.dart';
import '../status_tag.dart';

class TransactionItem extends StatelessWidget {
  final String label;
  final Widget? subtitleWidget;
  final DateTime date;
  final double amount;
  final String status;
  const TransactionItem({super.key, required this.label, this.subtitleWidget, required this.date, required this.amount, required this.status});

  @override
  Widget build(BuildContext context) {
    return WinitContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.textSecondary
                  ),
                ),
                SizedBox(height: 8.h,),
                FittedBox(
                  child: subtitleWidget ?? Row(
                    children: [
                      Row(
                        children: [
                          CustomAssetViewer(asset: AppAsset.calendar, height: 14.h, width: 14.w,),
                          SizedBox(width: 4.w,),
                          Text(
                            DateUtilities.dayMonthYear(date: date),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.textTertiary
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 11.w,),
                      Row(
                        children: [
                          CustomAssetViewer(asset: AppAsset.clockFilled, height: 14.h, width: 14.w,),
                          SizedBox(width: 4.w,),
                          Text(
                            DateUtilities.formatTimeAMPM(dateTime: date),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.textTertiary
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 10.w,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              NairaDisplay(
                amount: amount,
                fontSize: 14.sp,
                color:Theme.of(context).colorScheme.textPrimary,
                fontWeight: FontWeight.w800,
              ),
              SizedBox(height: 4.h,),
              StatusTag(status: status, useEndAlignment: true,)

            ],
          )

        ],
      ),
    );
  }
}
