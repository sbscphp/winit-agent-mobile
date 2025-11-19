import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/widgets/alert_dialogs/action_completed.dart';
import 'package:winit_agent/ui/widgets/alert_dialogs/complete_withdrawal_request.dart';
import 'package:winit_agent/ui/widgets/alert_dialogs/enter_transaction_pin.dart';
import 'package:winit_agent/ui/widgets/cross_fade_widget.dart';
import 'package:winit_agent/ui/widgets/list_header.dart';
import 'package:winit_agent/ui/widgets/listview_items/bank_account_item.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../widgets/alert_dialogs/base_dialog.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/naira_display.dart';
import '../../widgets/text_fields/wallet_action_text_field.dart';

class Withdraw extends StatefulWidget {
  const Withdraw({super.key});

  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {

  final  _amount = TextEditingController();
  final _focusNode = FocusNode();
  final switchNotifier = ValueNotifier(false);

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
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Withdraw Fund',
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
                      WalletActionTextField(
                        label: 'How much do you want to Withdraw ?',
                        fillColor: ColorPath.remyPink,
                        borderColor: ColorPath.pigPink,
                        textColor: ColorPath.ribbonRed,
                        controller: _amount,
                        focusNode: _focusNode,
                      ),
                      SizedBox(height: 16.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Available Balance',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.textSecondary
                            ),
                          ),
                          SizedBox(width: 8.w,),
                          Flexible(
                            child: NairaDisplay(
                              amount: 34567,
                              fontSize: 14.sp,
                              color:Theme.of(context).colorScheme.textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 32.h,),
                      ListHeader(
                        label: 'Withdraw Into',
                        subtitle: 'Select an account to withdraw into',
                        showAllLabel: 'Manage',
                        onPressed: (){},
                      ),
                      SizedBox(height: 16.h,),
                      ListView.separated(
                        itemCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (BuildContext context, int index) {
                          return BankAccountItem(
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 24.h,);
                        },
                      )
        
        
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h,),
              CustomButton(
                  buttonText: 'Continue',
                  onPressed: (){
                    // baseDialog(
                    //   context: context,
                    //   content: CompleteWithdrawalRequest(
                    //     onDone: (value){
                    //
                    //       Future.delayed(const Duration(milliseconds: 50), () {
                    //         baseDialog(
                    //           context: context,
                    //           content: ActionCompleted(
                    //             title: 'Request Completed',
                    //             assetSize: 80,
                    //             subtitle:
                    //             'Congratulations, your withdrawal request has been successfully completed. A notification will be sent to you when fully processed.',
                    //             onPressed: () {
                    //               popNavigation(context: context);
                    //             },
                    //           ),
                    //         );
                    //       });
                    //
                    //     },
                    //   ),
                    // );

                    baseDialog(
                      context: context,
                      content: CrossFadeWidget(
                        switchNotifier: switchNotifier,
                        firstChild: CompleteWithdrawalRequest(
                            onDone: (value){},
                            onPressed: () => switchNotifier.value = true,
                        ),
                        secondChild: EnterTransactionPin(
                            onDone: (value){
                              Future.delayed(const Duration(milliseconds: 50), () {
                                baseDialog(
                                  context: context,
                                  content: ActionCompleted(
                                    title: 'Request Completed',
                                    assetSize: 80,
                                    subtitle:
                                    'Congratulations, your withdrawal request has been successfully completed. A notification will be sent to you when fully processed.',
                                    onPressed: () {
                                      popNavigation(context: context);
                                    },
                                  ),
                                );
                              });
                            }
                        ),
                      ),
                      onClosed: () {
                        switchNotifier.value = false;
                      },
                    );

                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
