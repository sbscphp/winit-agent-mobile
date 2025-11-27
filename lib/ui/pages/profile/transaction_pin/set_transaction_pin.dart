import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/data/view_models/bottom_nav_view_model.dart';
import 'package:winit_agent/core/data/view_models/profile/profile_vm.dart';
import 'package:winit_agent/core/data/view_models/profile/transaction_pin_vm.dart';
import 'package:winit_agent/core/utilities/utilities.dart';
import 'package:winit_agent/ui/widgets/busy_overlay.dart';
import 'package:winit_agent/ui/widgets/show_flush_bar.dart';
import '../../../../core/constants/app_asset.dart';
import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/color_path.dart';
import '../../../../core/constants/named_routes.dart';
import '../../../../core/data/enum/view_state.dart';
import '../../../../core/utilities/navigator.dart';
import '../../../../core/utilities/validator.dart';
import '../../../widgets/alert_dialogs/action_completed.dart';
import '../../../widgets/alert_dialogs/base_dialog.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/screen_title.dart';
import '../../../widgets/text_fields/custom_text_field.dart';

class SetTransactionPin extends ConsumerStatefulWidget {
  final bool isChangePin;
  final bool isEnterNewPin;
  const SetTransactionPin({super.key, this.isChangePin = false, this.isEnterNewPin = false});

  @override
  ConsumerState<SetTransactionPin> createState() => _SetTransactionPinState();
}

class _SetTransactionPinState extends ConsumerState<SetTransactionPin> {

  final _pin = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(transactionPinViewModel);
    return BusyOverlay(
      show: vm.state == ViewState.busy,
      child: Scaffold(
        appBar: widget.isChangePin ? customAppBar(
          context: context,
          title: 'Change Transaction PIN',
        ) : customAppBar(
            context: context,
            centerTitle: false,
            useCustomTitleWidget: true,
            titleWidget: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color:  ColorPath.turquoiseGreen,
                ),
                children: [
                  TextSpan(
                    text: 'Setup: ',
                  ),
                  TextSpan(
                    text: 'Transaction PIN',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.white
                    ),
                  ),

                ],
              ),
            ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
              left: AppDimension.paddingLeft,
              right: AppDimension.paddingRight,
              top: 32.h,
              bottom: 80.h
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ScreenTitle(title: widget.isChangePin ? 'Change Transaction PIN':'Setup Transaction PIN',
                              titleSize: 18.sp,
                              subtitleSize: 14.sp,
                              subtitleColor: Theme.of(context).colorScheme.textSecondary,
                              subtitle: widget.isChangePin
                                  ?   widget.isEnterNewPin ? "Enter your new Transaction pin to keep your account secure."
                                      :"Enter your current Transaction PIN to set up a new one and keep your account secure."
                                  :'Set up your four (4)-digit transaction PIN easily. This PIN will be used to secure transactions and authorise actions on your WinIt Agent account.'
                          ),
                          SizedBox(height: 65.h,),
                          Align(
                            alignment: Alignment.center,
                            child: widget.isChangePin
                                ? RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color:  Theme.of(context).colorScheme.textTertiary,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Enter',
                                  ),
                                  TextSpan(
                                    text: widget.isEnterNewPin ? ' NEW Transaction PIN ':' OLD Transaction PIN ',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: ColorPath.blueBlue
                                    ),

                                  ),
                                  TextSpan(
                                    text: 'Below',
                                  ),
                                ],
                              ),
                            )
                                :RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color:  Theme.of(context).colorScheme.textTertiary,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Enter',
                                  ),
                                  TextSpan(
                                    text: ' PIN ',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: ColorPath.blueBlue
                                    ),

                                  ),
                                  TextSpan(
                                    text: 'Below',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40.w),
                            child: CustomTextField(
                              isOtp: true,
                              keyboardType: TextInputType.number,
                              controller: _pin,
                              validator: FieldValidator.validate,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(4),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h,),
                CustomButton(
                    buttonText: widget.isChangePin ?
                    widget.isEnterNewPin ? 'Update Pin':'Continue'
                        :'Setup PIN',
                    suffixIcon: AppAsset.pin2,
                    onPressed: () async{
                      
                      final validate = _formKey.currentState!.validate();
                      if(validate){

                        Utilities.hideKeyboard(context);
                        
                        if(widget.isChangePin){
                          if(widget.isEnterNewPin){
                            //update pin
                            await vm.updateTransactionPin(newPin: _pin.text);
                            if(vm.state == ViewState.retrieved){
                              baseDialog(
                                context: context,
                                content: ActionCompleted(
                                  title: 'PIN update successful',
                                  assetSize: 80,
                                  subtitle:
                                  'Transaction PIN updated successfully!',
                                  buttonText: 'Close',
                                  onPressed: () {
                                    popUntilNavigation(context: context, route: NamedRoutes.transactionPin);
                                  },
                                ),
                              );
                            }else{
                              showFlushBar(
                                  context: context,
                                  message: vm.message,
                                  success: false
                              );
                            }
                          }
                          else{
                            //validate current pin
                            await vm.validateTransactionPin(pin: _pin.text);
                            if(vm.state == ViewState.retrieved){
                              //route user to enter new pin
                              pushNavigation(context: context, widget: const SetTransactionPin(
                                isChangePin: true,
                                isEnterNewPin: true,
                              ), routeName: NamedRoutes.setTransactionPin);
                            }
                            showFlushBar(
                                context: context,
                                message: vm.message,
                                success: vm.state == ViewState.retrieved
                            );
                          }
                        } else{
                          //set up transaction pin flow
                          await vm.setTransactionPin(pin: _pin.text);
                          if(vm.state == ViewState.retrieved){
                            //update transaction pin field
                            ref.read(profileViewModel).updatePinProperty();
                            baseDialog(
                              context: context,
                              content: ActionCompleted(
                                title: 'PIN setup successful',
                                assetSize: 80,
                                subtitle:
                                'Transaction PIN set successfully! You can now use your PIN to authorise and secure all transactions on your WinIt Agent account.',
                                buttonText: 'Explore Games',
                                onPressed: () {
                                  ref.read(bottomNavViewModel).updateIndex(0);
                                  popUntilNavigation(context: context, route: NamedRoutes.bottomNav);
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
                        }
                      }
                      
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
