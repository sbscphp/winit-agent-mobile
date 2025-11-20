import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';

import '../custom_radio_button.dart';
import '../media_placeholder.dart';

class PaymentMethodItem extends StatelessWidget {
  final bool showRadioButton;
  const PaymentMethodItem({super.key, this.showRadioButton = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(showRadioButton)CustomRadioButton(disableClick: true,),
        if(showRadioButton)SizedBox(width: 8.w,),
        SizedBox(
          height: 24.h,
          width: 24.w,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            imageUrl: '',
            placeholder: (context, url) => const MediaPlaceholder(),
            errorWidget: (context, url, error) => const MediaPlaceholder(),
          ),
        ),
        SizedBox(width: 8.w,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PayStack',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.textPrimary
                ),
              ),
              SizedBox(height: 2.h,),
              Text(
                'Pay with paystack',
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
