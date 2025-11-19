import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/ui/pages/profile/referral_management/view_all_referral_transactions.dart';

import '../../../../core/constants/app_asset.dart';
import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/named_routes.dart';
import '../../../../core/utilities/date_utilitites.dart';
import '../../../../core/utilities/navigator.dart';
import '../../../widgets/balance_summary_card.dart';
import '../../../widgets/copy_details.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_svg.dart';
import '../../../widgets/empty_state.dart';
import '../../../widgets/list_header.dart';
import '../../../widgets/listview_items/transaction_item.dart';

class ReferralManagement extends StatefulWidget {
  const ReferralManagement({super.key});

  @override
  State<ReferralManagement> createState() => _ReferralManagementState();
}

class _ReferralManagementState extends State<ReferralManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Referral Management',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: AppDimension.paddingLeft,
            vertical: 14.h
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BalanceSummaryCard(
                label: 'Referral Balance',
                balance: 405674,
                amountAdded: 2500
            ),
            SizedBox(height: 16.h,),
            CopyDetails(
                label: 'Referral Code',
                subtitle: 'Copy and Share link',
                detailToCopy: 'Adeaio0x25'
            ),
            SizedBox(height: 32.h,),
            ListHeader(
              label: 'Referral Transactions',
              subtitle: 'Incentives paid for Referrals',
              onPressed: (){
                pushNavigation(context: context, widget: const ViewAllReferralTransactions(), routeName: NamedRoutes.viewAllReferralTransactions);
              },
            ),
            SizedBox(height: 24.h,),
            if(1 + 1 == 2)ListView.separated(
              itemCount: 5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
            )else Column(
              children: [
                EmptyState(
                  asset: AppAsset.emptyState,
                  title: 'No Transaction Yet',
                  subtitle: 'You currently have no ticket purchase transaction yet. ',
                ),
                SizedBox(height: 16.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 39.5.w),
                  child: CustomButton(
                      buttonText: 'Purchase Game Ticket',
                      suffixIcon: AppAsset.ticketPurchase,
                      onPressed: () {

                      }
                  ),
                )
              ],
            )

          ],
        ),
      ),
    );
  }
}
