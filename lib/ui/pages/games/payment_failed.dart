import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';

import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/constants/named_routes.dart';
import '../../../core/data/view_models/bottom_nav_view_model.dart';
import '../../../core/utilities/navigator.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/render_lottie.dart';


class PaymentFailed extends ConsumerStatefulWidget {
  const PaymentFailed({super.key});

  @override
  ConsumerState<PaymentFailed> createState() => _PaymentFailedState();
}

class _PaymentFailedState extends ConsumerState<PaymentFailed> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final bottomNavVm = ref.read(bottomNavViewModel);
    return Scaffold(
      appBar: customAppBar(
          context: context,
          hideTooBarHeight: true
        //title: '',
        // actions: [
        //   const HomeIcon()
        // ]
      ),
      body: Padding(
        padding: EdgeInsets.only(left: AppDimension.paddingLeft, right: AppDimension.paddingRight, bottom:49.h, top: 50.h),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const RenderLottie(
                      lottieAsset: 'assets/json/failed.json',
                      repeat: false,
                      fit: BoxFit.contain,
                      alignment: Alignment.bottomCenter,
                    ),
                    SizedBox(height: 8.h,),
                    Text(
                     'Payment Failed',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.textPrimary
                      ),
                    ),
                    SizedBox(height: 8.h,),
                    Text(
                      'So sorry, your payment for this raffle ticket(s) failed',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.textPrimary
                      ),
                      textAlign: TextAlign.center,
                    ),



                  ],
                ),
              ),
              Column(
                children: [
                  CustomButton(
                      buttonText: 'Try Again',
                      onPressed: (){
                        popUntilNavigation(context: context, route: NamedRoutes.selectPaymentMethod);
                      }
                  ),
                  SizedBox(height: 12.h,),
                  CustomButton(
                      buttonText: 'Home',
                      useBorderColor: true,
                      borderColor: ColorPath.athensGrey2,
                      buttonTextColor: Theme.of(context).colorScheme.textPrimary,
                      onPressed: (){
                        bottomNavVm.updateIndex(4);
                        popUntilNavigation(context: context, route: NamedRoutes.bottomNav);
                      }
                  ),
                ],
              )
            ],
          ),
        ),
      ),

    );
  }
}
