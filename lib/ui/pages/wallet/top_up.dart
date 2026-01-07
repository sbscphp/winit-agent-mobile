import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/data/models/payment_method.dart';
import 'package:winit_agent/core/data/view_models/checkout/payment_vm.dart';
import 'package:winit_agent/core/data/view_models/wallet/wallet_vm.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/widgets/alert_dialogs/action_completed.dart';
import 'package:winit_agent/ui/widgets/clickable.dart';
import 'package:winit_agent/ui/widgets/list_header.dart';
import 'package:winit_agent/ui/widgets/listview_items/payment_method_item.dart';
import 'package:winit_agent/ui/widgets/winit_container.dart';
import '../../../core/constants/app_asset.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../widgets/alert_dialogs/base_dialog.dart';
import '../../widgets/copy_details.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_svg.dart';
import '../../widgets/naira_display.dart';
import '../../widgets/show_flush_bar.dart';
import '../../widgets/text_fields/wallet_action_text_field.dart';

class TopUp extends ConsumerStatefulWidget {
  const TopUp({super.key});

  @override
  ConsumerState<TopUp> createState() => _TopUpState();
}

class _TopUpState extends ConsumerState<TopUp> {

  final  _amount = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _amount.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(walletVm);
    final paymentVm = ref.watch(paymentViewModel);
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Top Up Wallet',
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppDimension.paddingLeft,
              vertical: 32.h
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 48.h,
                            width: 48.w,
                            decoration: BoxDecoration(
                                color: ColorPath.linenBrown,
                                borderRadius: BorderRadius.all(Radius.circular(7.2.r))
                            ),
                            child: Center(
                              child: CustomAssetViewer(asset: AppAsset.building2, height: 27.h, width: 27.w,),
                            ),
                          ),
                          SizedBox(width: 16.w,),
                          Expanded(
                            child: Text(
                              'Send Money to the Account Details Below',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: Theme.of(context).colorScheme.textPrimary
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 24.h,),
                      WinitContainer(
                        borderRadius: BorderRadius.all(Radius.circular(16.r)),
                        border: Border.all(color: ColorPath.athensGrey3),
                          child: Consumer(
                            builder: (context, ref, child){
                              final wVm = ref.read(walletVm);
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Account Name',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context).colorScheme.textTertiary
                                        ),
                                      ),
                                      SizedBox(width: 20.w,),
                                      Flexible(
                                        child: Text(
                                          wVm.walletAccountName,
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              fontWeight: FontWeight.w800,
                                              color: Theme.of(context).colorScheme.textPrimary
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Account Number',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context).colorScheme.textTertiary
                                        ),
                                      ),
                                      SizedBox(width: 20.w,),
                                      Flexible(
                                        child: Clickable(
                                          onPressed: (){
                                            Clipboard.setData(
                                                ClipboardData(text: wVm.walletAccountNumber))
                                                .then((value) {
                                              //show user 'copy' success message
                                              showFlushBar(
                                                  context: context,
                                                  message: 'Account number Copied!'
                                              );
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                wVm.walletAccountNumber,
                                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                    fontWeight: FontWeight.w800,
                                                    color: Theme.of(context).colorScheme.textPrimary
                                                ),
                                              ),
                                              SizedBox(width: 11.w,),
                                              CustomAssetViewer(asset: AppAsset.copy2, height: 16.h, width: 16.w,)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Bank Name',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context).colorScheme.textTertiary
                                        ),
                                      ),
                                      SizedBox(width: 20.w,),
                                      Flexible(
                                        child: Text(
                                          wVm.bankName,
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              fontWeight: FontWeight.w800,
                                              color: Theme.of(context).colorScheme.textPrimary
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          )
                      ),
                      SizedBox(height: 24.h,),
                      WinitContainer(
                          bgColor: ColorPath.athensGrey,
                          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CustomAssetViewer(asset: AppAsset.alert, height: 16.h, width: 16.w,),
                                  SizedBox(width: 8.w,),
                                  Text(
                                    'Kindly Note',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: ColorPath.ribbonRed
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 8.h,),
                              ListView.separated(
                                itemCount: 3,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.only(
                                  left: 7.w
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 2.h,
                                        width: 2.w,
                                        decoration: BoxDecoration(
                                            color: ColorPath.charcoalBlack,
                                            shape: BoxShape.circle
                                        ),
                                      ),
                                      SizedBox(width: 10.w,),
                                      Flexible(
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: RichText(
                                              textAlign: TextAlign.left,
                                              text: TextSpan(
                                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.italic,
                                                  color: ColorPath.charcoalBlack,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: index == 0 ? 'Maximum Single Deposit is ':'Daily cumulative transaction limit is ',
                                                  ),
                                                  TextSpan(
                                                    text: '₦100,000',
                                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                      fontWeight: FontWeight.w600,
                                                      fontStyle: FontStyle.italic,
                                                      color: ColorPath.charcoalBlack,
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )

                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(height: 4.h,);
                                },
                              )
                            ],
                          )
                      )



                    ],
                  ),
                ),
              ),











              // Expanded(
              //   child: SingleChildScrollView(
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         WalletActionTextField(
              //           label: 'How much do you want to Top Up?',
              //           fillColor: ColorPath.chalkPurple,
              //           borderColor: ColorPath.fogPurple,
              //           textColor: ColorPath.blueBlue,
              //           controller: _amount,
              //           focusNode: _focusNode,
              //         ),
              //         SizedBox(height: 16.h,),
              //         if(1 + 1 == 3)Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Text(
              //               'Maximum Single Deposit:',
              //               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              //                   fontWeight: FontWeight.w400,
              //                   color: Theme.of(context).colorScheme.textSecondary
              //               ),
              //             ),
              //             SizedBox(width: 8.w,),
              //             Flexible(
              //               child: NairaDisplay(
              //                 amount: 34567,
              //                 fontSize: 14.sp,
              //                 color:Theme.of(context).colorScheme.textPrimary,
              //                 fontWeight: FontWeight.w700,
              //               ),
              //             ),
              //           ],
              //         )
              //         else Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Text(
              //               'Maximum Top Up Exceeded:',
              //               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              //                   fontWeight: FontWeight.w400,
              //                   color: ColorPath.ribbonRed
              //               ),
              //             ),
              //             SizedBox(width: 8.w,),
              //             Flexible(
              //               child: NairaDisplay(
              //                 amount: 34567,
              //                 fontSize: 14.sp,
              //                 color:ColorPath.ribbonRed,
              //                 fontWeight: FontWeight.w700,
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 32.h,),
              //         ListHeader(
              //           label: 'Top Up from',
              //           subtitle: 'Select an option to Top up with',
              //           showAllVisible: false,
              //         ),
              //         SizedBox(height: 16.h,),
              //         ListView.separated(
              //           itemCount: paymentVm.paymentMethods.length,
              //           shrinkWrap: true,
              //           physics: const NeverScrollableScrollPhysics(),
              //           padding: EdgeInsets.zero,
              //           itemBuilder: (BuildContext context, int index) {
              //             final paymentMethod = paymentVm.paymentMethods[index];
              //             return PaymentMethodItem(paymentMethod: paymentMethod,);
              //           },
              //           separatorBuilder: (context, index) {
              //             return SizedBox(height: 24.h,);
              //           },
              //         ),
              //         SizedBox(height: 48.h,),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Expanded(
              //               child: Container(
              //                 height: 1.h,
              //                 color: ColorPath.athensGrey3,
              //               ),
              //             ),
              //             Padding(
              //               padding: EdgeInsets.symmetric(horizontal: 16.w),
              //               child: Text(
              //                 'OR',
              //                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              //                     fontWeight: FontWeight.w800,
              //                     color: Theme.of(context).colorScheme.textPrimary
              //                 ),
              //               ),
              //             ),
              //             Expanded(
              //               child: Container(
              //                 height: 1.h,
              //                 color: ColorPath.athensGrey3,
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 4.h,),
              //         Align(
              //           alignment: Alignment.center,
              //           child: Text(
              //             'Send Money to the Account Below',
              //             style: Theme.of(context).textTheme.bodySmall?.copyWith(
              //                 fontWeight: FontWeight.w400,
              //                 color: Theme.of(context).colorScheme.textSecondary
              //             ),
              //           ),
              //         ),
              //         SizedBox(height: 16.h,),
              //         CopyDetails(
              //             label: 'Wallet Account No.',
              //             subtitle: vm.walletAccountName,
              //             detailToCopy: vm.walletAccountNumber
              //         ),
              //         SizedBox(height: 16.h,),
              //         WinitContainer(
              //           bgColor: ColorPath.athensGrey,
              //           padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
              //             child: Row(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 CustomAssetViewer(asset: AppAsset.alert),
              //                 SizedBox(width: 12.w,),
              //                 Expanded(
              //                   child: ListView.separated(
              //                     itemCount: 3,
              //                     shrinkWrap: true,
              //                     physics: const NeverScrollableScrollPhysics(),
              //                     padding: EdgeInsets.zero,
              //                     itemBuilder: (BuildContext context, int index) {
              //                       return Row(
              //                         crossAxisAlignment: CrossAxisAlignment.center,
              //                         children: [
              //                           Container(
              //                             height: 2.h,
              //                             width: 2.w,
              //                             decoration: BoxDecoration(
              //                               color: ColorPath.charcoalBlack,
              //                               shape: BoxShape.circle
              //                             ),
              //                           ),
              //                           SizedBox(width: 10.w,),
              //                           Flexible(
              //                             child: FittedBox(
              //                               fit: BoxFit.scaleDown,
              //                               child: Align(
              //                                 alignment: Alignment.centerLeft,
              //                                 child: RichText(
              //                                   textAlign: TextAlign.left,
              //                                   text: TextSpan(
              //                                     style: Theme.of(context).textTheme.bodySmall?.copyWith(
              //                                       fontWeight: FontWeight.w400,
              //                                       fontStyle: FontStyle.italic,
              //                                       color: ColorPath.charcoalBlack,
              //                                     ),
              //                                     children: [
              //                                       TextSpan(
              //                                         text: index == 0 ? 'Maximum Single Deposit is ':'Daily cumulative transaction limit is ',
              //                                       ),
              //                                       TextSpan(
              //                                         text: '₦100,000',
              //                                         style: Theme.of(context).textTheme.bodySmall?.copyWith(
              //                                           fontWeight: FontWeight.w600,
              //                                           fontStyle: FontStyle.italic,
              //                                           color: ColorPath.charcoalBlack,
              //                                         ),
              //                                       ),
              //
              //                                     ],
              //                                   ),
              //                                 ),
              //                               ),
              //                             ),
              //                           )
              //
              //                         ],
              //                       );
              //                     },
              //                     separatorBuilder: (context, index) {
              //                       return SizedBox(height: 4.h,);
              //                     },
              //                   ),
              //                 )
              //               ],
              //             )
              //         )
              //
              //
              //
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(height: 10.h,),
              // CustomButton(
              //     buttonText: 'Continue',
              //     onPressed: () {
              //       baseDialog(
              //         context: context,
              //         content: ActionCompleted(
              //           title: 'Top Up Completed',
              //           assetSize: 80,
              //           subtitle:
              //           'Congratulations, your successfully Completed. Top up your Wallet',
              //           onPressed: () {
              //             popNavigation(context: context);
              //           },
              //         ),
              //       );
              //     }
              // )
            ],
          ),
        ),
      ),
    );
  }
}
