import 'package:auto_size_text_plus/auto_size_text_plus.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_asset.dart';
import 'package:winit_agent/core/constants/app_dimension.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/data/view_models/landing_vm.dart';
import 'package:winit_agent/core/utilities/extensions/color_extensions.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/pages/authentication/login.dart';
import 'package:winit_agent/ui/pages/onboarding/registration_requirements.dart';
import 'package:winit_agent/ui/widgets/custom_svg.dart';

import '../../core/constants/color_path.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_dot.dart';

class Landing extends ConsumerWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(landingViewModel);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: ColorPath.stratosBlue,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 48.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                            child: CustomAssetViewer(asset: AppAsset.landingImage, height: 250.h, width: double.infinity,)),
                        SizedBox(height: 83.h,),
                        SizedBox(
                          height: 180.h,
                          child: Swiper(
                            autoplay: true,
                            autoplayDisableOnInteraction: true,
                            controller: vm.swiperController,
                            itemCount:vm.titles.length,
                            duration: 1000,
                            autoplayDelay: 3000,
                            scale: 0.8,
                            itemHeight: double.infinity,
                            itemWidth: double.infinity,
                            curve: Curves.easeInOut,
                            onIndexChanged: (index)=>vm.updateIndex(index),
                            itemBuilder: (BuildContext context, int index) {
                              final title = vm.titles[index];
                              final subtitle = vm.subtitles[index];

                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: AppDimension.paddingLeft),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      title,
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          fontSize: 30.sp,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white
                                      ),
                                    ),
                                    SizedBox(height: 4.h,),
                                    Flexible(
                                      child: AutoSizeText(
                                        subtitle,
                                        // minFontSize: 12,
                                        // maxFontSize: 16,
                                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            //fontSize: 16,
                                            color: ColorPath.frenchGrey
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              );
                          
                            },
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Padding(
                          padding: EdgeInsets.only(left: AppDimension.paddingLeft),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                                vm.titles.length,
                                    (index) => CustomDot(
                                  activeColor: Colors.white,
                                  inactiveColor: Colors.white.withCustomOpacity(0.16),
                                  isActive: vm.currentIndex == index,
                                )),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.h,),
                Padding(
                  padding: EdgeInsets.only(
                      left: AppDimension.paddingLeft,
                      right: AppDimension.paddingRight,
                      bottom: 24.h
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomButton(
                            buttonText: 'Sign Up',
                            bgColor: ColorPath.grayGrey.withCustomOpacity(0.25),
                            suffixIcon: AppAsset.chevronTopRight,
                            onPressed: () async{
                              pushNavigation(context: context, widget: const RegistrationRequirements(), routeName: NamedRoutes.registrationRequirements);
                            }
                        ),
                      ),
                      SizedBox(width: 16.w,),
                      Expanded(
                        child: CustomButton(
                            buttonText: 'Login',
                            bgColor: ColorPath.grayGrey.withCustomOpacity(0.25),
                            suffixIcon: AppAsset.login,
                            onPressed: () async{
                              pushNavigation(context: context, widget: const Login(), routeName: NamedRoutes.login);
                            }
                        ),
                      ),
                    ],
                  ),
                )
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}
