import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/data/view_models/profile/transaction_pin_vm.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/widgets/show_flush_bar.dart';
import '../../../core/constants/app_asset.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/data/enum/view_state.dart';
import '../../../core/utilities/utilities.dart';
import '../../../core/utilities/validator.dart';
import '../clickable.dart';
import '../custom_button.dart';
import '../custom_svg.dart';
import '../text_fields/custom_text_field.dart';

class EnterTransactionPin extends ConsumerStatefulWidget {
  final ValueChanged<bool> onDone;
  final ValueChanged<bool>? onLoading;
  final String? buttonText;
  final String? title;
  final String? subtitle;
  const EnterTransactionPin({super.key, this.onLoading, required this.onDone, this.buttonText, this.title, this.subtitle});

  @override
  ConsumerState<EnterTransactionPin> createState() => _EnterTransactionPinState();
}

class _EnterTransactionPinState extends ConsumerState<EnterTransactionPin> {

  final _pin = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(transactionPinViewModel);
    return IgnorePointer(
      ignoring: vm.state == ViewState.busy,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 24.h,
            horizontal: 24.w
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAssetViewer(asset: AppAsset.warning, height: 48.h, width: 48.w,),
              SizedBox(height: 32.h,),
              Text(
                widget.title ?? 'Enter Transaction PIN',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.textPrimary
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h,),
              Text(
                widget.subtitle ?? 'Enter your four (4) Digit Transaction pin to complete this action',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.textSecondary
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h,),
              CustomTextField(
                isOtp: true,
                keyboardType: TextInputType.number,
                controller: _pin,
                validator: FieldValidator.validate,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(4),
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              SizedBox(height: 16.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Forgot Pin? ",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.textTertiary
                    ),
                  ),
                  Clickable(
                    onPressed: (){
                    },
                    child: Text(
                      "Reset",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: ColorPath.ribbonRed,
                          decoration: TextDecoration.underline,
                          decorationColor: ColorPath.ribbonRed
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h,),
              CustomButton(
                buttonHeight: 40,
                  useSuffixIcon: false,
                  showLoader: vm.state == ViewState.busy,
                  buttonText: widget.buttonText ?? 'Complete Action',
                  onPressed: () async{

                  final validate = _formKey.currentState!.validate();
                  if(validate){

                    Utilities.hideKeyboard(context);

                    //disable dialog dismissible property
                    widget.onLoading?.call(true);

                    //validate pin
                    await vm.validateTransactionPin(pin: _pin.text);


                    //enable dialog dismissible property
                    widget.onLoading?.call(false);
                    if(vm.state == ViewState.retrieved){
                      widget.onDone(true);
                      popNavigation(context: context);
                    }else{
                      showFlushBar(
                          context: context,
                          message: vm.message,
                        success: false
                      );
                    }
                  }







                  }
              )


            ],
          ),
        ),
      ),
    );
  }
}
