import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/data/view_models/profile/profile_vm.dart';
import 'package:winit_agent/ui/pages/profile/referral_management/view_all_referral_transactions.dart';
import 'package:winit_agent/ui/widgets/app_loader.dart';
import 'package:winit_agent/ui/widgets/clickable.dart';
import 'package:winit_agent/ui/widgets/error_state.dart';

import '../../../../core/constants/app_asset.dart';
import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/named_routes.dart';
import '../../../../core/data/enum/view_state.dart';
import '../../../../core/data/view_models/referral_vm.dart';
import '../../../../core/utilities/date_utilitites.dart';
import '../../../../core/utilities/navigator.dart';
import '../../../widgets/alert_dialogs/base_dialog.dart';
import '../../../widgets/alert_dialogs/transaction_receipt.dart';
import '../../../widgets/balance_summary_card.dart';
import '../../../widgets/copy_details.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_svg.dart';
import '../../../widgets/empty_state.dart';
import '../../../widgets/list_header.dart';
import '../../../widgets/listview_items/transaction_item.dart';

class ReferralManagement extends ConsumerStatefulWidget {
  const ReferralManagement({super.key});

  @override
  ConsumerState<ReferralManagement> createState() => _ReferralManagementState();
}

class _ReferralManagementState extends ConsumerState<ReferralManagement> {


  @override
  void initState() {
    final vm = ref.read(referralViewModel);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      vm.fetchReferralHistory();
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(referralViewModel);
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Referral Management',
      ),
      body: Builder(
        builder: (context) {
          if(vm.state == ViewState.busy){
            return Center(
              child: AppLoader(),
            );
          }

          if(vm.state == ViewState.retrieved){
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: AppDimension.paddingLeft,
                  vertical: 14.h
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BalanceSummaryCard(
                    label: 'Referral Balance',
                    balance: vm.referralBalance,
                    amountAdded: vm.lastPeriodBalance,
                    duration: vm.lastPeriod.split(' ')[0],
                  ),
                  SizedBox(height: 16.h,),
                  CopyDetails(
                      label: 'Referral Code',
                      subtitle: 'Copy and Share link',
                      detailToCopy: ref.read(profileViewModel).referralCode
                  ),
                  SizedBox(height: 32.h,),
                  ListHeader(
                    label: 'Referral Transactions',
                    subtitle: 'Incentives paid for Referrals',
                    showAllVisible: vm.state == ViewState.retrieved && vm.referralHistory.isNotEmpty,
                    onPressed: (){
                      pushNavigation(context: context, widget: const ViewAllReferralTransactions(), routeName: NamedRoutes.viewAllReferralTransactions);
                    },
                  ),
                  SizedBox(height: 24.h,),
                  if(vm.referralHistory.isNotEmpty)ListView.separated(
                    itemCount: vm.referralHistory.length > 5 ? 5 : vm.referralHistory.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) {
                      final transaction = vm.referralHistory[index];
                      final desc = transaction.reason ?? 'N/A';
                      final date = transaction.dateReferred ?? DateTime.now();
                      final amount = double.tryParse(transaction.rewardAmount?.toString() ?? '0') ?? 0;
                      final status = transaction.status ?? '';
                      final firstname = transaction.user?.firstname ?? 'N/A';
                      final lastname = transaction.user?.lastname ?? 'N/A';
                      return Clickable(
                        onPressed: (){
                          baseDialog(
                            context: context,
                            content: TransactionReceipt(transaction: transaction, isReferral: true,),
                          );
                        },
                        child: TransactionItem(
                          label: desc,
                          date: date,
                          amount: amount,
                          status: status,
                          subtitleWidget: Row(
                            children: [
                              Row(
                                children: [
                                  CustomAssetViewer(asset: AppAsset.avatar2, height: 14.h, width: 14.w,),
                                  SizedBox(width: 4.w,),
                                  Text(
                                    '$firstname $lastname',
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
                                    DateUtilities.dayMonthYear(date: date),
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context).colorScheme.textTertiary
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
                        title: 'No Referrals Yet',
                        subtitle: 'You currently have no referrals yet. ',
                      ),
                      // SizedBox(height: 16.h,),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 39.5.w),
                      //   child: CustomButton(
                      //       buttonText: 'Purchase Game Ticket',
                      //       suffixIcon: AppAsset.ticketPurchase,
                      //       onPressed: () {
                      //
                      //       }
                      //   ),
                      // )
                    ],
                  )

                ],
              ),
            );
          }

          if(vm.state == ViewState.error){
            return Center(
              child: ErrorState(
                message: vm.message,
                  onPressed: ()=>vm.fetchReferralHistory()),
            );
          }

          return const SizedBox.shrink();

        }
      ),
    );
  }
}
