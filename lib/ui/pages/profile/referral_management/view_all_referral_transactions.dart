import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';

import '../../../../core/constants/app_asset.dart';
import '../../../../core/constants/app_dimension.dart';
import '../../../../core/utilities/date_utilitites.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_svg.dart';
import '../../../widgets/listview_items/transaction_item.dart';

class ViewAllReferralTransactions extends StatefulWidget {
  const ViewAllReferralTransactions({super.key});

  @override
  State<ViewAllReferralTransactions> createState() => _ViewAllReferralTransactionsState();
}

class _ViewAllReferralTransactionsState extends State<ViewAllReferralTransactions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'View all Referral Transactions',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppDimension.paddingLeft,
            vertical: 14.h
        ),
        child: ListView.separated(
          itemCount: 7,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (BuildContext context, int index) {
            return TransactionItem(
                label: 'Purchased of 15 Ticket Unit',
                date: DateTime.now(),
                amount: 2500,
                status: 'successful',
              subtitleWidget: Row(
                children: [
                  Row(
                    children: [
                      CustomAssetViewer(asset: AppAsset.avatar2, height: 14.h, width: 14.w,),
                      SizedBox(width: 4.w,),
                      Text(
                        'Sample Name',
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
                      CustomAssetViewer(asset: AppAsset.calendar, height: 14.h, width: 14.w,),
                      SizedBox(width: 4.w,),
                      Text(
                        DateUtilities.dayMonthYear(date: DateTime.now()),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.textTertiary
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 16.h,);
          },
        ),
      ),
    );
  }
}
