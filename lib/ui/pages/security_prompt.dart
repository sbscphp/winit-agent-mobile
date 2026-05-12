import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_dimension.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';

import '../widgets/custom_button.dart';

class SecurityPrompt extends StatelessWidget {
  final String appName;
  const SecurityPrompt({super.key, required this.appName});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Padding(
          padding:EdgeInsets.symmetric(
            vertical: AppDimension.paddingTop,
            horizontal: AppDimension.paddingLeft
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Security Alert',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.textTertiary
                ),
              ),
              SizedBox(height: 16.h,),
              Text(
                'For your protection, $appName cannot run on this device. Please use a device with standard security settings',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.textSecondary
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h,),
              CustomButton(
                  buttonText: 'Exit Application',
                  onPressed: (){
                    if (Platform.isAndroid) {
                      SystemNavigator.pop();
                    } else if (Platform.isIOS) {
                      exit(0);
                    }
                  },
              ),


            ],
          ),
        ),
      ),
    );
  }
}
