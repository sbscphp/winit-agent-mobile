import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_asset.dart';
import 'package:winit_agent/ui/widgets/clickable.dart';
import 'package:winit_agent/ui/widgets/custom_svg.dart';





class LeadingIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool addPadding;
  final bool show;
  const LeadingIcon({super.key, this.onPressed, this.addPadding = true, this.show = false});

  @override
  Widget build(BuildContext context) {
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final bool canPop = parentRoute?.canPop ?? false;
    if(canPop || show){
      return Clickable(
        onPressed:onPressed ?? (){

          Navigator.pop(context);
        },
        child: Padding(
          padding: EdgeInsets.only(left: addPadding ? 22.h : 0),
          child: SizedBox(
            height: 50.h,
            width: 30.w,
            child: const Align(
                alignment: Alignment.centerLeft,
                child: CustomSvg(
                  asset: AppAsset.leadingIcon,
                )
            ),
          ),
        ),
      );
    }
      return Container();
  }
}
