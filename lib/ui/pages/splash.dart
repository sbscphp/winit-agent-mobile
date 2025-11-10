import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_asset.dart';
import 'package:winit_agent/core/constants/color_path.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/pages/bottom_nav.dart';
import 'package:winit_agent/ui/pages/landing.dart';
import 'package:winit_agent/ui/widgets/custom_svg.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    initUserAndNavigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: ColorPath.stratosBlue,
          child: Center(
            child: CustomAssetViewer(asset: AppAsset.logo, height: 120.h, width: 112.w,),
          ),
        ),
      ),
    );
  }

  initUserAndNavigate()async{
    // _savedUser = await SecureStorageUtils.retrieveUser();
    // userExist = _savedUser != null;
    Timer(const Duration(seconds: 2), () {
      // if(userExist){
      //   //nav returning user to login screen
      //   replaceNavigation(
      //       context: context,
      //       transitionType: PageTransitionType.rightToLeft,
      //       widget: const Login(),
      //       routeName: NamedRoutes.login);
      //   return;
      // }
      //nav user to onboarding screen
      replaceNavigation(
          context: context,
          widget: Landing(),
          routeName: NamedRoutes.landing);
    });
  }
}
