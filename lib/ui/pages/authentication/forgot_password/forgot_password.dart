import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/data/enum/otp_type.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/core/utilities/validator.dart';
import 'package:winit_agent/ui/pages/authentication/otp.dart';

import '../../../../core/constants/app_dimension.dart';
import '../../../../core/utilities/input_formatters/nigerian_phone_number_formatter.dart';
import '../../../../core/utilities/utilities.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/text_fields/custom_text_field.dart';

class ForgotPassword extends StatefulWidget {
  final bool isEmail;
  const ForgotPassword({super.key, this.isEmail = true});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final _choice = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Forgot Password',
      ),
      body:  Padding(
        padding: EdgeInsets.symmetric(vertical: AppDimension.paddingTop, horizontal: AppDimension.paddingLeft),
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
                      Text(
                        widget.isEmail ? 'Enter Your Email Address below':'Enter your phone number',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.textPrimary
                        ),
                      ),
                      SizedBox(height: 16.h,),
                      if(widget.isEmail)CustomTextField(
                        label: 'Email Address',
                        keyboardType: TextInputType.emailAddress,
                        controller: _choice,
                        validator: EmailValidator.validateEmail,
                      )
                      else CustomTextField(
                        label: 'Phone Number',
                        controller: _choice,
                        validator: FieldValidator.validate,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(18),
                          NigerianPhoneNumberFormatter()
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h,),
            CustomButton(
                buttonText: 'Send OTP',
                onPressed: () async{

                  final validate = _formKey.currentState!.validate();
                  if(validate){
                    pushNavigation(context: context, widget: Otp(
                        isEmail: widget.isEmail,
                        otpType: OtpType.forgotPassword,
                        identifier: widget.isEmail
                      ? _choice.text
                      : Utilities.cleanPhoneNumber(phoneNumber: _choice.text),
                    ),
                      routeName: NamedRoutes.otp
                    );
                  }

                }
            ),



          ],
        ),
      ),
    );
  }
}
