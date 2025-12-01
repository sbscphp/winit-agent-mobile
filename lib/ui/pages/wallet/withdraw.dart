import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/data/view_models/profile/bank_account_details_vm.dart';
import 'package:winit_agent/core/data/view_models/profile/transaction_pin_vm.dart';
import 'package:winit_agent/core/data/view_models/wallet/wallet_transactions_vm.dart';
import 'package:winit_agent/core/data/view_models/wallet/wallet_vm.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/widgets/alert_dialogs/action_completed.dart';
import 'package:winit_agent/ui/widgets/alert_dialogs/complete_withdrawal_request.dart';
import 'package:winit_agent/ui/widgets/alert_dialogs/enter_transaction_pin.dart';
import 'package:winit_agent/ui/widgets/busy_overlay.dart';
import 'package:winit_agent/ui/widgets/cross_fade_widget.dart';
import 'package:winit_agent/ui/widgets/list_header.dart';
import 'package:winit_agent/ui/widgets/listview_items/bank_account_item.dart';
import 'package:winit_agent/ui/widgets/show_flush_bar.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/constants/named_routes.dart';
import '../../../core/data/enum/view_state.dart';
import '../../../core/utilities/utilities.dart';
import '../../widgets/alert_dialogs/base_dialog.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/naira_display.dart';
import '../../widgets/text_fields/wallet_action_text_field.dart';
import '../profile/manage_bank_accounts/manage_bank_accounts.dart';

class Withdraw extends ConsumerStatefulWidget {
  const Withdraw({super.key});

  @override
  ConsumerState<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends ConsumerState<Withdraw> {

  final  _amount = TextEditingController();
  final _focusNode = FocusNode();
  final switchNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    ref.read(bankAccountDetailsViewModel).reset();
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
    return BusyOverlay(
      show: vm.secondState == ViewState.busy,
      child: Scaffold(
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
                                amount: vm.walletBalance,
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
                          onPressed: (){
                            pushNavigation(context: context, widget: const ManageBankAccounts(), routeName: NamedRoutes.manageBankAccounts);
                          },
                        ),
                        SizedBox(height: 16.h,),
                        Consumer(
                          builder: (context, ref, child){
                            final bankAccountsVm = ref.watch(bankAccountDetailsViewModel);
                            return ListView.separated(
                              itemCount: bankAccountsVm.bankAccounts.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemBuilder: (BuildContext context, int index) {
                                final bankAccount = bankAccountsVm.bankAccounts[index];
                                final isSelected = bankAccountsVm.selectedBankAccount?.uuid == bankAccount.uuid;
                                return BankAccountItem(
                                  index: index,
                                  bankAccount: bankAccount,
                                  isSelected: isSelected,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 24.h,);
                              },
                            );
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

                      Utilities.hideKeyboard(context);

                      final amount = Utilities.formatToDouble(value: _amount.text);

                      if(amount < 1){
                        showFlushBar(
                            context: context,
                            message: 'Kindly enter a valid amount to proceed',
                          success: false
                        );
                        return;
                      }

                      if(amount > vm.walletBalance){
                        showFlushBar(
                            context: context,
                            message: 'Insufficient balance',
                            success: false
                        );
                        return;
                      }

                      if(ref.read(bankAccountDetailsViewModel).selectedBankAccount == null){
                        showFlushBar(
                            context: context,
                            message: 'Kindly select a withdrawal account to proceed',
                          success: false
                        );
                      }

                      baseDialog(
                        context: context,
                        content: CrossFadeWidget(
                          switchNotifier: switchNotifier,
                          firstChild: CompleteWithdrawalRequest(
                              onDone: (value){},
                              onPressed: () => switchNotifier.value = true,
                          ),
                          secondChild: EnterTransactionPin(
                              visitingRoute: NamedRoutes.withdraw,
                              onDone: (value)async{
                                Future.delayed(const Duration(milliseconds: 50), () async{

                                  await vm.withdraw(
                                      amount: amount,
                                      pin: ref.read(transactionPinViewModel).currentPin ?? ''
                                  );

                                  if(vm.secondState == ViewState.retrieved){
                                    //re-fetch wallet summary
                                    vm.fetchWalletSummary(showLoader: false);

                                    //re-fetch transaction history
                                    ref.read(walletTransactionsViewModel).fetchTransactions(id: vm.walletId, refreshUi: false);

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
                                  }
                                  else{
                                    showFlushBar(
                                        context: context,
                                        message: vm.message,
                                      success: false
                                    );
                                  }


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
      ),
    );
  }
}
