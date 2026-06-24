import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/utilities/navigator.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/constants/color_path.dart';
import '../custom_button.dart';
import '../custom_svg.dart';

class ActionConfirmation extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onPressed;
  final double? assetSize;
  final String? asset;
  final String? buttonText;
  final Color? buttonColor;
  final bool popInternally;
  const ActionConfirmation({super.key, this.popInternally = true, this.buttonColor, this.buttonText, this.asset, this.assetSize, required this.title, required this.subtitle, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 24.h,
          horizontal: 24.w
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomAssetViewer(asset: asset ??  AppAsset.warning, height: assetSize?.h ?? 120.h, width: assetSize?.w ?? 120.w,),
          SizedBox(height: 32.h,),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: Theme.of(context).colorScheme.textPrimary
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h,),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.textSecondary
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child:  CustomButton(
                  useSuffixIcon: false,
                  bgColor: buttonColor ?? ColorPath.ribbonRed,
                    buttonText: buttonText ?? 'Yes, Proceed',
                    onPressed: popInternally ? (){
                    popNavigation(context: context);
                    onPressed();
                    }:onPressed
                ),
              ),
              SizedBox(width: 8.w,),
              Expanded(
                child:  CustomButton(
                    useSuffixIcon: false,
                    useBorderColor: true,
                    buttonTextColor: Theme.of(context).colorScheme.textPrimary,
                    bgColor: ColorPath.ribbonRed,
                    buttonText: 'No, Close',
                    onPressed: ()=>popNavigation(context: context)
                ),
              )
            ],
          ),


        ],
      ),
    );
  }
}
