import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_dimension.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/pages/wallet/view_all_transactions.dart';
import 'package:winit_agent/ui/widgets/balance_summary_card.dart';
import 'package:winit_agent/ui/widgets/bottom_sheets/wallet_quick_actions.dart';
import 'package:winit_agent/ui/widgets/copy_details.dart';
import 'package:winit_agent/ui/widgets/empty_state.dart';
import 'package:winit_agent/ui/widgets/list_header.dart';
import 'package:winit_agent/ui/widgets/listview_items/transaction_item.dart';
import '../../../core/constants/app_asset.dart';
import '../../widgets/action_icon.dart';
import '../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/profile/profile_image.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          context: context,
          centerTitle: true,
          leadingIcon: ProfileImage(),
          title: 'Explore',
          actions: [
            ActionIcon(label: 'Quick Actions', asset: AppAsset.walletActions,
              onPressed: (){
                baseBottomSheet(
                  context: context,
                  content: WalletQuickActions(),
                );
              },
            )
          ]
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
                label: 'Wallet Balance',
                balance: 405674,
                amountAdded: 2500
            ),
            SizedBox(height: 16.h,),
            CopyDetails(
                label: 'Wallet Account No.',
                subtitle: 'Jide Ticket LLC ',
                detailToCopy: '0069000592'
            ),
            SizedBox(height: 32.h,),
            ListHeader(
                label: 'Wallet Transaction',
                subtitle: 'Purchase transaction done via wallet',
              onPressed: (){
                  pushNavigation(context: context, widget: const ViewAllTransactions(), routeName: NamedRoutes.viewAllTransactions);
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
                    status: 'successful'
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
