import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_asset.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/data/view_models/profile/bank_account_details_vm.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/pages/onboarding/terms.dart';
import 'package:winit_agent/ui/pages/profile/manage_bank_accounts/verify_bank_details.dart';
import 'package:winit_agent/ui/widgets/busy_overlay.dart';
import 'package:winit_agent/ui/widgets/clickable.dart';
import 'package:winit_agent/ui/widgets/custom_svg.dart';
import 'package:winit_agent/ui/widgets/show_flush_bar.dart';

import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/data/enum/view_state.dart';
import '../../widgets/alert_dialogs/action_confirmation.dart';
import '../../widgets/alert_dialogs/base_dialog.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/screen_title.dart';

class AddBankDetails extends ConsumerStatefulWidget {
  const AddBankDetails({super.key});

  @override
  ConsumerState<AddBankDetails> createState() => _AddBankDetailsState();
}

class _AddBankDetailsState extends ConsumerState<AddBankDetails> {
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(bankAccountDetailsViewModel);
    return BusyOverlay(
      show: vm.secondState == ViewState.busy,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          title: 'Add Bank Account Details',
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: AppDimension.paddingTop, horizontal: AppDimension.paddingLeft),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ScreenTitle(title: 'Add Bank Account Information',
                            subtitle: 'You can only add a maximum of two (2) bank accounts.'
                        ),
                        if(vm.bankAccounts.isNotEmpty)Padding(
                          padding: EdgeInsets.only(top: 24.h),
                          child: ListView.separated(
                            itemCount: vm.bankAccounts.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemBuilder: (BuildContext context, int index) {
                              final bankAccount = vm.bankAccounts[index];
                              final accountName = bankAccount.accountName ?? 'N/A';
                              final accountNumber = bankAccount.accountNumber ?? 'N/A';
                              final bankName = bankAccount.bankName ?? 'N/A';
                              return Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  vertical: 16.h,
                                  horizontal: 16.w
                                ),
                                decoration: BoxDecoration(
                                  color: ColorPath.athensGrey2,
                                  border: Border.all(color: ColorPath.athensGrey3, width: 1.5.w),
                                  borderRadius: BorderRadius.all(Radius.circular(8.r))
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            accountNumber,
                                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                fontWeight: FontWeight.w700,
                                                color: ColorPath.blueBlue
                                            ),
                                          ),
                                          SizedBox(height: 1.h,),
                                          Text(
                                            '$bankName | $accountName',
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: Theme.of(context).colorScheme.textPrimary
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10.w,),
                                    Clickable(
                                      onPressed:(){
                                        baseDialog(
                                          context: context,
                                          content: ActionConfirmation(
                                            title: 'Remove Bank Account Details ?',
                                            subtitle:
                                            'Are you sure you want to remove this bank account?',
                                            buttonText: 'Yes, Remove',
                                            onPressed: ()async{
                                              await vm.deleteBankAccount(index: index, fromOnboarding: true);
                                              showFlushBar(
                                                  context: context,
                                                  message: vm.message,
                                                success: vm.secondState == ViewState.retrieved
                                              );
                                            },
                                          ),
                                        );
                                      },
                                        child: CustomAssetViewer(asset: AppAsset.delete, height: 24.h, width: 24.w,))
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 16.h,);
                            },
                          ),
                        ),
                        SizedBox(height: 24.h,),
                        if(vm.bankAccounts.length < 2)Clickable(
                          onPressed: (){
                            pushNavigation(context: context, widget: const VerifyBankDetails(), routeName: NamedRoutes.verifyBankDetails);
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                vertical: 12.h,
                                horizontal: 16.w
                            ),
                            decoration: BoxDecoration(
                                color: ColorPath.athensGrey2,
                                border: Border.all(color: ColorPath.athensGrey3, width: 1.5.w),
                                borderRadius: BorderRadius.all(Radius.circular(8.r))
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Bank Account',
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: Theme.of(context).colorScheme.textPrimary
                                        ),
                                      ),
                                      SizedBox(height: 1.h,),
                                      Text(
                                        'Add account Details for Withdrawal',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context).colorScheme.textTertiary
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                SizedBox(width: 10.w,),
                                Container(
                                  height: 48.h,
                                  width: 48.w,
                                  decoration: BoxDecoration(
                                    color: ColorPath.charcoalBlack,
                                    shape: BoxShape.circle
                                  ),
                                  child: Center(
                                    child: CustomAssetViewer(asset: AppAsset.add),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )






                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h,),
                if(vm.bankAccounts.isNotEmpty)CustomButton(
                    buttonText: 'Continue',
                    onPressed: () {
                      pushAndClearNavigation(context: context, widget: const Terms(),  routeName: NamedRoutes.terms, clearRoute: NamedRoutes.login,);
                    }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
