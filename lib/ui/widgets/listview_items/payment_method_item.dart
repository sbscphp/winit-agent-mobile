import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/data/enum/checkout_type.dart';
import 'package:winit_agent/core/data/models/payment_method.dart';
import 'package:winit_agent/core/data/view_models/checkout/payment_vm.dart';
import 'package:winit_agent/ui/widgets/clickable.dart';

import '../custom_radio_button.dart';
import '../media_placeholder.dart';

class PaymentMethodItem extends StatelessWidget {
  final bool showRadioButton;
  final PaymentMethod paymentMethod;
  final bool isClickable;
  const PaymentMethodItem({super.key, this.isClickable = true, this.showRadioButton = true, required this.paymentMethod});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child){
        final vm = ref.watch(paymentViewModel);
        final isSelected = vm.checkoutType == CheckoutType.paystack;
        return Clickable(
          onPressed: (){
            if(!isClickable){
              return;
            }
            vm.checkoutType = CheckoutType.paystack;
            vm.selectedPaymentMethod = paymentMethod;
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if(showRadioButton)CustomRadioButton(disableClick: true, value: isSelected,),
              if(showRadioButton)SizedBox(width: 8.w,),
              SizedBox(
                height: 24.h,
                width: 24.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(4.r)),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    imageUrl: paymentMethod.logo ?? '',
                    placeholder: (context, url) => const MediaPlaceholder(),
                    errorWidget: (context, url, error) => const MediaPlaceholder(),
                  ),
                ),
              ),
              SizedBox(width: 8.w,),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      paymentMethod.name ?? 'N/A',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.textPrimary
                      ),
                    ),
                    // SizedBox(height: 2.h,),
                    // Text(
                    //   'Pay with paystack',
                    //   style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    //       fontWeight: FontWeight.w400,
                    //       color: Theme.of(context).colorScheme.textTertiary
                    //   ),
                    // ),

                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
