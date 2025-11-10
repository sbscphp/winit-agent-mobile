import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/data/enum/otp_type.dart';
import 'package:winit_agent/core/data/view_models/authentication/otp_vm.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/utilities/utilities.dart';
import '../../../core/utilities/validator.dart';
import '../../widgets/clickable.dart';
import '../../widgets/count_down_timer.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/screen_title.dart';
import '../onboarding/onboarding_successful.dart';

class Otp extends ConsumerStatefulWidget {
  final OtpType otpType;
  final String identifier;
  const Otp({super.key, required this.otpType, required this.identifier});

  @override
  ConsumerState<Otp> createState() => _OtpState();
}

class _OtpState extends ConsumerState<Otp> {

  final _otp = TextEditingController();

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
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: vm.appBarTitle(otpType: widget.otpType),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: AppDimension.paddingTop, horizontal: AppDimension.paddingLeft),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ScreenTitle(title: vm.otpTitle(otpType: widget.otpType),
                              subtitle: vm.otpSubtitle(otpType: widget.otpType, identifier: '+234 ${Utilities.maskCharacters(subject: '9021074118', startIndex: 0, endIndex: 8)}')
                          ),
                          SizedBox(height: 37.h,),
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
                                child: RichText(
                                  textAlign: TextAlign.left,
                                  text: TextSpan(
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w800,
                                        color: ColorPath.piperBrown
                                    ),
                                    children: [
                                      const TextSpan(
                                        text: 'Expires in ',
                                      ),
                                      TextSpan(
                                        text: '$minutes:$seconds',
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            fontWeight: FontWeight.w800,
                                            color:ColorPath.ribbonRed
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            onEnd: () {
                              setState(() {
                                _timerElapsed = true;
                              });
                            },
                          ),
                          SizedBox(height: 32.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Didn't receive Code? ",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: ColorPath.manateeGrey
                                ),
                              ),
                              IgnorePointer(
                                ignoring: !_timerElapsed,
                                child: Opacity(
                                  opacity: _timerElapsed ? 1 : 0.4,
                                  child: Clickable(
                                    onPressed: !_timerElapsed ? null : ()async{
                                      // Utilities.hideKeyboard(context);
                                      //
                                      // await vm.resendOtp(
                                      //     otpType: widget.otpType,
                                      //     token: widget.otpType == OtpType.verifyEmail
                                      //         ? ref.read(signUpViewModel).emailVerificationToken ?? ''
                                      //         : ref.read(otpViewModel).verificationToken ?? ''
                                      // );
                                      //
                                      // if(vm.state == ViewState.retrieved){
                                      //   _resetTimer();
                                      // }
                                      //
                                      // showFlushBar(
                                      //     context: context,
                                      //     message: vm.message,
                                      //     success: vm.state == ViewState.retrieved
                                      // );
                                    },
                                    child: Text(
                                      "Resend OTP",
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.w500,
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
                        ],
                      )
                    ],
                  ),
                ),
              ),
              CustomButton(
                  buttonText: 'Validate Code',
                  onPressed: () async{
                    if(widget.otpType == OtpType.createAccount){
                      //temporary onboarding done
                      pushNavigation(context: context, widget: const OnboardingSuccessful(), routeName: NamedRoutes.onboardingSuccessful);
                      return;
                    }
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
