import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:winit_agent/core/constants/app_asset.dart';
import 'package:winit_agent/ui/widgets/custom_svg.dart';



class AppLoader extends StatelessWidget {
  final double? size;
  const AppLoader({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitSpinningCircle(
        size: size ?? 80, //200
        itemBuilder: (BuildContext context, int index) {

          return CustomSvg(
            asset: AppAsset.logo,
            height: size?.h,
            width: size?.w,
          );
        },
      ),
    );
  }
}
