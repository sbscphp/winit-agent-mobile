import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/data/view_models/profile/bank_account_details_vm.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/pages/profile/manage_bank_accounts/verify_bank_details.dart';
import 'package:winit_agent/ui/widgets/busy_overlay.dart';
import '../../../../core/constants/app_asset.dart';
import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/color_path.dart';
import '../../../../core/data/enum/view_state.dart';
import '../../../widgets/action_icon.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_svg.dart';
import '../../../widgets/empty_state.dart';
import '../../../widgets/listview_items/bank_account_item.dart';

class ManageBankAccounts extends ConsumerStatefulWidget {
  const ManageBankAccounts({super.key});

  @override
  ConsumerState<ManageBankAccounts> createState() => _ManageBankAccountsState();
}

class _ManageBankAccountsState extends ConsumerState<ManageBankAccounts> {
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(bankAccountDetailsViewModel);
    return BusyOverlay(
      show: vm.secondState == ViewState.busy,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          title: 'Manage Account Number',
            actions: [
              if(vm.bankAccounts.length < 2)ActionIcon(label: 'New', asset: AppAsset.add2,
                onPressed: (){
                  pushNavigation(context: context, widget: const VerifyBankDetails(), routeName: NamedRoutes.verifyBankDetails);
                },
              )
            ]
        ),
        body: Padding(
          padding: EdgeInsets.only(
              left: AppDimension.paddingLeft,
              right: AppDimension.paddingRight,
              top: 32.h,
              bottom: 36.h
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: vm.bankAccounts.isEmpty ? Padding(
                    padding: EdgeInsets.only(top: 40.h),
                    child: Column(
                      children: [
                        EmptyState(
                          asset: AppAsset.emptyState,
                          title: 'No Withdrawal Account Details',
                          subtitle: 'You currently have no withdrawal account yet. ',
                        ),
                        SizedBox(height: 16.h,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 39.5.w),
                          child: CustomButton(
                              buttonText: 'Add a Withdrawal account',
                              onPressed: () {
                                pushNavigation(context: context, widget: const VerifyBankDetails(), routeName: NamedRoutes.verifyBankDetails);
                              }
                          ),
                        )
                      ],
                    ),
                  ):ListView.separated(
                    itemCount: vm.bankAccounts.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) {
                      final bankAccount = vm.bankAccounts[index];
                      return BankAccountItem(
                        canDelete: true,
                        index: index,
                        bankAccount: bankAccount,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 24.h,);
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 16.h,
                      horizontal: 16.w
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12.r)),
                      color: ColorPath.remyPink
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 4.8.h,
                            horizontal:4.8.w
                        ),
                        decoration: BoxDecoration(
                          color: ColorPath.pigPink2,
                          borderRadius: BorderRadius.all(Radius.circular(6.r)),
                        ),
                        child: Center(
                          child: CustomAssetViewer(asset: AppAsset.alert, height: 14.4.h, width: 14.4.w,),
                        ),
                      ),
                      SizedBox(width: 12.w,),
                      Expanded(
                        child:  Text(
                          'You can only add a maximum of two (2) Bank Accounts. ',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: ColorPath.charcoalBlack
                          ),
                        ),

                      )

                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
