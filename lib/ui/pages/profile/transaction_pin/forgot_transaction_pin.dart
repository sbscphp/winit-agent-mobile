import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_asset.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/data/enum/otp_type.dart';
import 'package:winit_agent/core/data/view_models/authentication/otp_vm.dart';
import 'package:winit_agent/core/data/view_models/profile/profile_vm.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/pages/profile/transaction_pin/set_transaction_pin.dart';
import 'package:winit_agent/ui/widgets/alert_dialogs/otp_dialog.dart';
import 'package:winit_agent/ui/widgets/busy_overlay.dart';
import 'package:winit_agent/ui/widgets/custom_svg.dart';
import 'package:winit_agent/ui/widgets/show_flush_bar.dart';

import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/color_path.dart';
import '../../../../core/data/enum/view_state.dart';
import '../../../widgets/alert_dialogs/base_dialog.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/onboarding/identity_verification_notes.dart';
import '../../../widgets/screen_title.dart';

class ForgotTransactionPin extends ConsumerWidget {
  const ForgotTransactionPin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(otpViewModel);
    return BusyOverlay(
      show: vm.state == ViewState.busy,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          title: 'Forgot Transaction PIN?',
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
              left: AppDimension.paddingLeft,
              right: AppDimension.paddingRight,
              top: 32.h,
              bottom: 80.h
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 46.h,
                    width: 46.w,
                    decoration: BoxDecoration(
                      color: ColorPath.pigPink,
                      borderRadius: BorderRadius.all(Radius.circular(11.5.r)),
                    ),
                    child: Center(
                      child: CustomAssetViewer(asset: AppAsset.warning2, height: 27.6.h, width: 27.6.w,),
                    ),
                  ),
                  SizedBox(width: 12.w,),
                  Expanded(
                    child:ScreenTitle(
                        title: 'Reset Transaction PIN',
                        titleSize: 16.sp,
                        subtitle: 'Initiate reset transaction PIN process'
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.h,),
              IdentityVerificationNotes(
                  asset: AppAsset.bulletPoint4,
                  sizeBoxAsSeparator: true,
                  notes: [
                    {
                      'title': 'Step 1:',
                      'subtitle': 'We’ll send a One-Time Password (OTP) to your registered email address linked to your WinIT Account.'
                    },
                    {
                      'title': 'Step 2:',
                      'subtitle': 'Enter the OTP in the space provided to verify your identity.'
                    },
                    {
                      'title': 'Step 3:',
                      'subtitle': 'Once verified, you’ll be redirected to set a new Transaction PIN securely.'
                    }
                  ]
              ),
              SizedBox(height: 125.h,),
              CustomButton(
                  buttonText: 'Reset Transaction PIN',
                  suffixIcon: AppAsset.warning3,
                  onPressed: () async{

                    await vm.sendOtp(
                        otpType: OtpType.forgotTransactionPin,
                        type: 'email'
                    );
                    if(vm.state == ViewState.retrieved){

                      controllableBaseDialog(
                        context: context,
                        onClosed: () {
                        },
                        builder: (context, setDismissible) {
                          return OtpDialog(
                            identifier: ref.read(profileViewModel).email,
                            otpType: OtpType.forgotTransactionPin,
                            onDone: (value){
                              if(value){
                                print('got here>>>');
                                pushNavigation(context: context, widget: const SetTransactionPin(
                                  fromResetPin: true,
                                ), routeName: NamedRoutes.setTransactionPin);
                              }
                            },
                            onLoading: (loading) {
                              setDismissible(!loading);
                            },
                          );


                          // return CrossFadeWidget(
                          //     switchNotifier: switchNotifier,
                          //     firstChild: ActionConfirmation(
                          //       popInternally: false,
                          //       title: 'Remove Bank Account Details ?',
                          //       subtitle:
                          //       'Are you sure you want to remove this bank account as a withdrawal option? This action cannot be undone, and all saved details will be permanently deleted."',
                          //       buttonText: 'Yes, Remove',
                          //       onPressed: () => switchNotifier.value = true,
                          //     ),
                          //     secondChild: EnterTransactionPin(
                          //       buttonText: 'Remove Withdrawal Details',
                          //       onDone: (success) async{
                          //         // setDismissible(true);
                          //
                          //         final container =
                          //         ProviderScope.containerOf(context);
                          //
                          //         final bankAccountVm =
                          //         container.read(bankAccountDetailsViewModel);
                          //         final transactionPinVm =
                          //         container.read(transactionPinViewModel);
                          //
                          //         await bankAccountVm.deleteBankAccount(
                          //             index: widget.index,
                          //             pin: transactionPinVm.currentPin
                          //         );
                          //         if(bankAccountVm.secondState == ViewState.retrieved){
                          //           Future.delayed(const Duration(milliseconds: 50), () {
                          //             baseDialog(
                          //               context: context,
                          //               content: ActionCompleted(
                          //                 title: 'Bank Account Details Removed',
                          //                 assetSize: 80,
                          //                 subtitle:
                          //                 'Your bank account has been successfully removed as a withdrawal option',
                          //                 onPressed: () {
                          //                   popNavigation(context: context);
                          //                 },
                          //               ),
                          //             );
                          //           });
                          //         }else{
                          //           showFlushBar(
                          //               context: context,
                          //               message: bankAccountVm.message,
                          //               success: false
                          //           );
                          //         }
                          //
                          //
                          //       },
                          //       onLoading: (loading) {
                          //         setDismissible(!loading);
                          //       },
                          //     )
                          // );

                        },
                      );

                    }else{
                      showFlushBar(
                          context: context,
                          message: vm.message,
                        success: false
                      );
                    }
                  }
              ),
              SizedBox(height: 16.h,),
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
                      child: RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color:  ColorPath.ribbonRed,
                          ),
                          children: [
                            TextSpan(
                              text: 'TIP: ',
                            ),
                            TextSpan(
                              text: 'Make sure you have access to your registered email before starting this process.',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: ColorPath.troutGrey
                              ),
                            ),

                          ],
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
    );
  }
}
