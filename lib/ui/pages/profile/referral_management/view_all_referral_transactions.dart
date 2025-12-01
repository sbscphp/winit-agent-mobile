import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/data/view_models/referral_vm.dart';

import '../../../../core/constants/app_asset.dart';
import '../../../../core/constants/app_dimension.dart';
import '../../../../core/data/enum/view_state.dart';
import '../../../../core/utilities/date_utilitites.dart';
import '../../../widgets/alert_dialogs/base_dialog.dart';
import '../../../widgets/alert_dialogs/transaction_receipt.dart';
import '../../../widgets/app_loader.dart';
import '../../../widgets/clickable.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_svg.dart';
import '../../../widgets/empty_state.dart';
import '../../../widgets/error_state.dart';
import '../../../widgets/listview_items/transaction_item.dart';

class ViewAllReferralTransactions extends ConsumerStatefulWidget {
  const ViewAllReferralTransactions({super.key});

  @override
  ConsumerState<ViewAllReferralTransactions> createState() => _ViewAllReferralTransactionsState();
}

class _ViewAllReferralTransactionsState extends ConsumerState<ViewAllReferralTransactions> {

  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollListener();
    super.initState();
  }

  _scrollListener() {
    final vm = ref.read(referralViewModel);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //check paginated state
        if(vm.paginatedState != ViewState.error){
          //check if data is not being currently fetched and also check total records
          if (vm.paginatedState != ViewState.busy && vm.referralHistory.length < vm.totalRecords) {
            //fetch more referrals
            vm.fetchReferralHistory(
                firstCall: false
            );
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(referralViewModel);
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
        child: Builder(
          builder: (context) {

            if(vm.state == ViewState.busy){
              return Center(
                child: AppLoader(),
              );
            }

            if(vm.state == ViewState.retrieved){

              if(vm.referralHistory.isEmpty){
                return Center(
                  child: EmptyState(
                    asset: AppAsset.emptyState,
                    title: 'No Referrals Yet',
                    subtitle: 'You currently have no referrals yet. ',
                  ),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.separated(
                      controller: _scrollController,
                      itemCount: vm.referralHistory.length,
                      shrinkWrap: true,
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
                    ),
                  ),
                  if(vm.paginatedState == ViewState.busy)
                    Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: const Align(
                        alignment: Alignment.center,
                        child: AppLoader(
                          size: 16,
                        ),
                      ),
                    ),
                  if(vm.paginatedState == ViewState.error)
                    ErrorState(
                        message: vm.message,
                        isPaginationType: true,
                        onPressed: ()=>vm.fetchReferralHistory(firstCall: false))
                ],
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
      ),
    );
  }
}
