import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import '../custom_svg.dart';

class IdentityVerificationTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final String highlightedText;
  final String imageAsset;
  final Color assetBg;
  final Color highlightedTextColor;
  const IdentityVerificationTitle({super.key, required this.title, required this.subtitle, required this.highlightedText, required this.imageAsset, required this.assetBg, required this.highlightedTextColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 48.h,
          width: 48.w,
          decoration: BoxDecoration(
              color: assetBg,
              borderRadius: BorderRadius.all(Radius.circular(7.2.r))
          ),
          child: Center(
            child: CustomAssetViewer(asset: imageAsset, height: 27.h, width: 27.w,),
          ),
        ),
        SizedBox(width: 16.w,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).colorScheme.textPrimary
                  ),
                  children: [
                    TextSpan(
                      text: '$title ',
                    ),
                    TextSpan(
                      text: highlightedText,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: highlightedTextColor
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 4.h,),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.textTertiary
                ),
              ),

            ],
          ),
        )
      ],
    );
  }
}
