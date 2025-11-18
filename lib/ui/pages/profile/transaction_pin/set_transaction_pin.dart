import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';

import '../../../../core/constants/app_asset.dart';
import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/color_path.dart';
import '../../../../core/constants/named_routes.dart';
import '../../../../core/utilities/navigator.dart';
import '../../../../core/utilities/validator.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/screen_title.dart';
import '../../../widgets/text_fields/custom_text_field.dart';

class SetTransactionPin extends StatefulWidget {
  final bool isChangePin;
  const SetTransactionPin({super.key, this.isChangePin = false});

  @override
  State<SetTransactionPin> createState() => _SetTransactionPinState();
}

class _SetTransactionPinState extends State<SetTransactionPin> {

  final _otp = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ScreenTitle(title: widget.isChangePin ? 'Change Transaction PIN':'Setup Transaction PIN',
                          titleSize: 18.sp,
                          subtitleSize: 14.sp,
                          subtitleColor: Theme.of(context).colorScheme.textSecondary,
                          subtitle: widget.isChangePin ?"Enter your current Transaction PIN to set up a new one and keep your account secure.":'Set up your four (4)-digit transaction PIN easily. This PIN will be used to secure transactions and authorise actions on your WinIt Agent account.'
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
                                text: ' OLD Transaction PIN ',
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
                          controller: _otp,
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
              SizedBox(height: 10.h,),
              CustomButton(
                  buttonText: 'Continue',
                  suffixIcon: AppAsset.pin2,
                  onPressed: () {
                    pushNavigation(context: context, widget: const SetTransactionPin(), routeName: NamedRoutes.setTransactionPin);
                  }
              )

            ],
          ),
        ),
      ),
    );
  }
}
