import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/data/enum/otp_type.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import '../../../core/constants/app_asset.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/data/enum/view_state.dart';
import '../../../core/data/view_models/authentication/otp_vm.dart';
import '../../../core/utilities/utilities.dart';
import '../../../core/utilities/validator.dart';
import '../clickable.dart';
import '../count_down_timer.dart';
import '../custom_button.dart';
import '../custom_svg.dart';
import '../show_flush_bar.dart';
import '../text_fields/custom_text_field.dart';

class OtpDialog extends ConsumerStatefulWidget {
  final ValueChanged<bool> onDone;
  final ValueChanged<bool>? onLoading;
  final String identifier;
  final String? title;
  final OtpType otpType;
  const OtpDialog({super.key, required this.otpType, this.title, this.onLoading, required this.onDone, required this.identifier});

  @override
  ConsumerState<OtpDialog> createState() => _OtpDialogState();
}

class _OtpDialogState extends ConsumerState<OtpDialog> {

  final _otp = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late DateTime endTime;
  bool _timerElapsed = false;

  @override
  void initState() {
    super.initState();
    _resetTimer();
  }

  void _resetTimer() {
    setState(() {
      endTime = ref.read(otpViewModel).endTime;
      _timerElapsed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(otpViewModel);
    return IgnorePointer(
      ignoring: vm.secondState == ViewState.busy || vm.thirdState == ViewState.busy,
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
              CustomAssetViewer(asset: AppAsset.email, height: 48.h, width: 48.w,),
              SizedBox(height: 32.h,),
              Text(
                widget.title ?? 'Enter OTP to Continue',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.textPrimary
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h,),
              Text(
                'We sent a 6 digit OTP to your email  ${Utilities.maskEmail(email: widget.identifier)}, associated with WinIT. Kindly enter your OTP Below. ',
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
                controller: _otp,
                validator: FieldValidator.validate,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(6),
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              SizedBox(height: 16.h,),
              CountdownTimer(
                key: ValueKey(endTime),
                endTime: endTime,
                builder: (_, time) {
                  final minutes = time.minutes.toString().padLeft(2, '0');
                  final seconds = time.seconds.toString().padLeft(2, '0');
                  return  Align(
                    alignment: Alignment.center,
                    child: Text(
                      '$minutes:$seconds',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: ColorPath.piperBrown
                      ),
                    )
                  );
                },
                onEnd: () {
                  setState(() {
                    _timerElapsed = true;
                  });
                },
              ),
              SizedBox(height: 24.h,),
              FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't receive Code? ",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.textTertiary
                      ),
                    ),
                    IgnorePointer(
                      ignoring: !_timerElapsed,
                      child: Opacity(
                        opacity: _timerElapsed ? 1 : 0.4,
                        child: Clickable(
                          onPressed: !_timerElapsed ? null : ()async{
                            Utilities.hideKeyboard(context);

                            //disable dialog dismissible property
                            widget.onLoading?.call(true);

                            await vm.resendOtp(
                                otpType: widget.otpType,
                                type: 'email'
                            );

                            //disable dialog dismissible property
                            widget.onLoading?.call(false);

                            if(vm.secondState == ViewState.retrieved){
                              _resetTimer();
                            }

                            showFlushBar(
                                context: context,
                                message: vm.message,
                                success: vm.secondState == ViewState.retrieved
                            );
                          },
                          child: Text(
                            "Resend OTP",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: ColorPath.ribbonRed,
                                decoration: TextDecoration.underline,
                                decorationColor: ColorPath.ribbonRed
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h,),
              CustomButton(
                  buttonText: 'Validate Code',
                  showLoader: vm.thirdState == ViewState.busy || vm.secondState == ViewState.busy,
                  useSuffixIcon: false,
                  onPressed: () async{

                    final validate = _formKey.currentState!.validate();
                    if(validate){

                      Utilities.hideKeyboard(context);

                      //disable dialog dismissible property
                      widget.onLoading?.call(true);

                      //validate pin
                      await vm.verifyOtp(
                          otp: _otp.text,
                          otpType: widget.otpType
                      );

                      //enable dialog dismissible property
                      widget.onLoading?.call(false);
                      if(vm.thirdState == ViewState.retrieved){
                        popNavigation(context: context);
                        widget.onDone(true);
                      }
                      showFlushBar(
                          context: context,
                          message: vm.message,
                          success: vm.thirdState == ViewState.retrieved
                      );
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
