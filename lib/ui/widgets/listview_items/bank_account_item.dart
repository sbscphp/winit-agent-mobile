import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/data/models/bank_account.dart';
import 'package:winit_agent/core/data/view_models/profile/bank_account_details_vm.dart';
import 'package:winit_agent/core/data/view_models/profile/transaction_pin_vm.dart';
import 'package:winit_agent/ui/widgets/alert_dialogs/action_confirmation.dart';
import 'package:winit_agent/ui/widgets/clickable.dart';
import 'package:winit_agent/ui/widgets/show_flush_bar.dart';
import '../../../core/constants/app_asset.dart';
import '../../../core/constants/named_routes.dart';
import '../../../core/data/enum/view_state.dart';
import '../../../core/utilities/navigator.dart';
import '../alert_dialogs/action_completed.dart';
import '../alert_dialogs/base_dialog.dart';
import '../alert_dialogs/enter_transaction_pin.dart';
import '../cross_fade_widget.dart';
import '../custom_radio_button.dart';
import '../custom_svg.dart';
import '../winit_container.dart';

class BankAccountItem extends StatefulWidget {
  final bool canDelete;
  final int index;
  final BankAccount bankAccount;
  final bool isSelected;
  const BankAccountItem({super.key, this.isSelected = false, this.canDelete = false, required this.index, required this.bankAccount});

  @override
  State<BankAccountItem> createState() => _BankAccountItemState();
}

class _BankAccountItemState extends State<BankAccountItem> {

  final switchNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final accountName = widget.bankAccount.accountName ?? 'N/A';
    final accountNumber = widget.bankAccount.accountNumber ?? 'N/A';
    final bankName = widget.bankAccount.bankName ?? 'N/A';
    return Clickable(
      onPressed: (){
        if(!widget.canDelete){
          //set selected bank account
          final container =
          ProviderScope.containerOf(context);
          final bankAccountVm =
          container.read(bankAccountDetailsViewModel);
          bankAccountVm.selectedBankAccount = widget.bankAccount;
        }
      },
      child: WinitContainer(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(!widget.canDelete)CustomRadioButton(
                    disableClick: true,
                    value: widget.isSelected,
                  ),
                  if(!widget.canDelete)SizedBox(width: 8.w,),
                  CustomAssetViewer(asset: AppAsset.building4, height: 32.h, width: 32.w,),
                  SizedBox(width: 8.w,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bankName,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: Theme.of(context).colorScheme.textPrimary
                          ),
                        ),
                        SizedBox(height: 4.h,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomAssetViewer(asset: AppAsset.avatar2, height: 14.h, width: 14.w,),
                            SizedBox(width: 4.w,),
                            Flexible(
                              child: Text(
                                accountName,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).colorScheme.textSecondary
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h,),
                        Row(
                          children: [
                            CustomAssetViewer(asset: AppAsset.accountNo, height: 14.h, width: 14.w,),
                            SizedBox(width: 4.w,),
                            Flexible(
                              child: Text(
                                accountNumber,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).colorScheme.textSecondary
                                ),
                              ),
                            ),

                          ],
                        ),
                        // Row(
                        //   children: [
                        //     Row(
                        //       children: [
                        //         CustomAssetViewer(asset: AppAsset.avatar2, height: 14.h, width: 14.w,),
                        //         SizedBox(width: 4.w,),
                        //         Text(
                        //           accountName,
                        //           style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        //               fontWeight: FontWeight.w400,
                        //               color: Theme.of(context).colorScheme.textSecondary
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //     Container(
                        //       height: 16.h,
                        //       width: 1.w,
                        //       color: ColorPath.athensGrey3,
                        //       margin: EdgeInsets.symmetric(horizontal: 11.w),
                        //     ),
                        //     Row(
                        //       children: [
                        //         CustomAssetViewer(asset: AppAsset.accountNo, height: 14.h, width: 14.w,),
                        //         SizedBox(width: 4.w,),
                        //         Text(
                        //           accountNumber,
                        //           style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        //               fontWeight: FontWeight.w400,
                        //               color: Theme.of(context).colorScheme.textSecondary
                        //           ),
                        //         ),
                        //
                        //       ],
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  )
                ],
              ),
            ),
            if(widget.canDelete)Clickable(
              onPressed: (){

                // baseDialog(
                //   context: context,
                //   content: CrossFadeWidget(
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
                //         onDone: (value){
                //           Future.delayed(const Duration(milliseconds: 50), () {
                //             baseDialog(
                //               context: context,
                //               content: ActionCompleted(
                //                 title: 'Bank Account Details  Removed',
                //                 assetSize: 80,
                //                 subtitle:
                //                 'Your bank account has been successfully removed as a withdrawal option',
                //                 onPressed: () {
                //                   popNavigation(context: context);
                //                 },
                //               ),
                //             );
                //           });
                //         }
                //     ),
                //   ),
                //   onClosed: () {
                //     switchNotifier.value = false;
                //   },
                // );



                controllableBaseDialog(
                  context: context,
                  onClosed: () {
                    switchNotifier.value = false;
                  },
                  builder: (context, setDismissible) {
                    return CrossFadeWidget(
                      switchNotifier: switchNotifier,
                      firstChild: ActionConfirmation(
                        popInternally: false,
                        title: 'Remove Bank Account Details ?',
                        subtitle:
                        'Are you sure you want to remove this bank account as a withdrawal option? This action cannot be undone, and all saved details will be permanently deleted."',
                        buttonText: 'Yes, Remove',
                        onPressed: () => switchNotifier.value = true,
                      ),
                      secondChild: EnterTransactionPin(
                        visitingRoute: NamedRoutes.manageBankAccounts,
                        buttonText: 'Remove Withdrawal Details',
                        onDone: (success) async{
                         // setDismissible(true);

                          final container =
                          ProviderScope.containerOf(context);

                          final bankAccountVm =
                          container.read(bankAccountDetailsViewModel);
                          final transactionPinVm =
                          container.read(transactionPinViewModel);

                          await bankAccountVm.deleteBankAccount(
                              index: widget.index,
                            pin: transactionPinVm.currentPin
                          );
                          if(bankAccountVm.secondState == ViewState.retrieved){
                            Future.delayed(const Duration(milliseconds: 50), () {
                              baseDialog(
                                context: context,
                                content: ActionCompleted(
                                  title: 'Bank Account Details Removed',
                                  assetSize: 80,
                                  subtitle:
                                  'Your bank account has been successfully removed as a withdrawal option',
                                  onPressed: () {
                                    popNavigation(context: context);
                                  },
                                ),
                              );
                            });
                          }else{
                            showFlushBar(
                                context: context,
                                message: bankAccountVm.message,
                              success: false
                            );
                          }


                        },
                        onLoading: (loading) {
                          setDismissible(!loading);
                        },
                      )
                    );

                  },
                );


              },
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: CustomAssetViewer(asset: AppAsset.delete2, height: 18.h, width: 18.w,),
                ))
          ],
        ),
      ),
    );
  }
}
