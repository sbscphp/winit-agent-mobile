import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/data/view_models/profile/bank_account_details_vm.dart';
import 'package:winit_agent/core/data/view_models/utility/banks_vm.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/widgets/bottom_sheets/banks.dart';
import 'package:winit_agent/ui/widgets/busy_overlay.dart';
import 'package:winit_agent/ui/widgets/clickable.dart';
import 'package:winit_agent/ui/widgets/show_flush_bar.dart';
import 'package:winit_agent/ui/widgets/text_fields/onboarding_drop_down.dart';

import '../../../../core/constants/app_asset.dart';
import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/color_path.dart';
import '../../../../core/data/enum/view_state.dart';
import '../../../../core/utilities/utilities.dart';
import '../../../../core/utilities/validator.dart';
import '../../../widgets/alert_dialogs/action_completed.dart';
import '../../../widgets/alert_dialogs/base_dialog.dart';
import '../../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_check_box.dart';
import '../../../widgets/text_fields/onboarding_text_field.dart';
import '../../../widgets/screen_title.dart';

class VerifyBankDetails extends ConsumerStatefulWidget {
  const VerifyBankDetails({super.key});

  @override
  ConsumerState<VerifyBankDetails> createState() => _VerifyBankDetailsState();
}

class _VerifyBankDetailsState extends ConsumerState<VerifyBankDetails> {

  final _accountNumber = TextEditingController();
  final _accountName = TextEditingController();


  String? _selectedBank;
  List<String> dummyBanks = [];

  bool _setAsDefault = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(banksViewModel).fetchBanks();
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(banksViewModel);
    final bankAccountVm = ref.watch(bankAccountDetailsViewModel);
    return BusyOverlay(
      show: bankAccountVm.state == ViewState.busy,
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
                        ScreenTitle(
                            title: 'Add Bank Account Details',
                            subtitle: 'Add a new bank account details with ease'
                        ),
                        SizedBox(height: 16.h,),
                        Clickable(
                          onPressed: (){
                            baseBottomSheet(
                              context: context,
                              content: Banks(
                                onDone: (value){
                                  _selectedBank = value.name;
                                  dummyBanks.add(_selectedBank ?? '');
                                  _accountNumber.clear();
                                  vm.selectedBank = value;
                                },
                              ),
                            );
                          },
                          child: OnboardingDropDown(
                            hintText: "Select Bank",
                            label: 'Bank',
                            value: _selectedBank,
                            enabled: false,
                            items: dummyBanks,
                          ),
                        ),
                        SizedBox(height: 24.h,),
                        OnboardingTextField(
                          label: 'Account Number',
                          hintText: 'Enter Account Number',
                          controller: _accountNumber,
                          enabled: _selectedBank != null,
                          validator: FieldValidator.validate,
                          keyboardType: TextInputType.number,
                          bottomHintText: 'Enter 10 digit account number',
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          onChanged: (value)async{
                            if(value.trim().length == 10){
                              print('here');
                              Utilities.hideKeyboard(context);
                              await bankAccountVm.addBankAccount(
                                  accountNumber: _accountNumber.text,
                                  bankCode: vm.selectedBank?.code ?? '',
                                  isDefault: _setAsDefault,
                                isVerifyingAccount: true,
                                saveToDb: false
                              );
                              if(bankAccountVm.state == ViewState.retrieved){
                                setState(() {
                                  _accountName.text = bankAccountVm.accountName;
                                });
                              }
                              showFlushBar(
                                  context: context,
                                  message: bankAccountVm.message,
                                success: bankAccountVm.state == ViewState.retrieved
                              );
                            }
                          },
                        ),
                        SizedBox(height: 24.h,),
                        OnboardingTextField(
                          label: 'Account Name',
                          hintText: 'Auto-mated',
                          enabled: false,
                          controller: _accountName,
                          validator: FieldValidator.validate,
                          keyboardType: TextInputType.text,
                          bottomHintText: 'Your account name is automatically generated from your account number',
                        ),
                        SizedBox(height: 16.h,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomCheckBox(
                                height: 24,
                                width: 24,
                                color: ColorPath.mischkaGrey,
                                onchanged: (value){
                                  setState(() {
                                    _setAsDefault = value;
                                  });
                                }
                            ),
                            SizedBox(width: 10.w,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Set as Default ',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).colorScheme.textSecondary
                                    ),
                                  ),
                                  SizedBox(height: 1.h,),
                                  Text(
                                    'Set this account number as the default for withdrawal',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context).colorScheme.textSecondary
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h,),
                Column(
                  children: [
                    CustomButton(
                        buttonText: 'Add Bank Account Number',
                        suffixIcon: AppAsset.building3,
                        onPressed: () {

                          if(_selectedBank == null){
                            showFlushBar(
                                context: context,
                                message: 'Kindly select a bank to proceed',
                              success: false
                            );
                            return;
                          }

                          if(_accountNumber.text.isEmpty){
                            showFlushBar(
                                context: context,
                                message: 'Kindly enter your account number to verify your bank account details',
                                success: false
                            );
                            return;
                          }

                          if(_accountName.text.isEmpty){
                            showFlushBar(
                                context: context,
                                message: 'Kindly verify your bank account details to proceed',
                                success: false
                            );
                            return;
                          }

                          baseDialog(
                            context: context,
                            content: ActionCompleted(
                              asset: AppAsset.warning,
                              title: 'Add Bank Account Details ?',
                              assetSize: 80,
                              subtitle:
                              'Are you sure you want to add this bank account as a withdrawal option?',
                              buttonText: 'Yes, Add Bank Account',
                              onPressed: () async{
                                popNavigation(context: context);
                                await bankAccountVm.addBankAccount(
                                    accountNumber: _accountNumber.text,
                                    bankCode: vm.selectedBank?.code ?? '',
                                    isDefault: _setAsDefault,
                                    isVerifyingAccount: false,
                                    saveToDb: true,
                                );
                                if(bankAccountVm.state == ViewState.retrieved){
                                  popNavigation(context: context);
                                }
                                showFlushBar(
                                    context: context,
                                    message: bankAccountVm.message,
                                  success: bankAccountVm.state == ViewState.retrieved
                                );

                              },
                            ),
                          );
                        }
                    ),
                    SizedBox(height: 12.h,),
                    Align(
                      alignment: Alignment.center,
                      child: FittedBox(
                        child: Text(
                          'You can only add a maximum of two (2) Bank Accounts.',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.textPrimary
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
