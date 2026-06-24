import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_asset.dart';
import 'package:winit_agent/ui/widgets/clickable.dart';
import 'package:winit_agent/ui/widgets/custom_svg.dart';

import '../../core/constants/color_path.dart';

class CustomCheckBox extends StatefulWidget {
  final double? height;
  final double? width;
  final ValueChanged<bool> onchanged;
  final Color? color;
  final bool initialValue;
  const CustomCheckBox({super.key, this.initialValue = false, this.color, this.height, this.width, required this.onchanged});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool _active = false;

  @override
  void initState() {
    _active = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onPressed: (){
        setState(() {
          _active = !_active;
        });
        widget.onchanged(_active);
      },
      child: Container(
        height: 20.h,
        width: 20.w,
        padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 3.w),
        decoration: BoxDecoration(
          border: Border.all(color: widget.color ?? ColorPath.blueBlue, width: 1.w),
          borderRadius: BorderRadius.all(Radius.circular(6.r))
        ),
        child: Center(
          child: _active ? CustomAssetViewer(asset: AppAsset.checkMark, height: 14.h, width: 14.w,):SizedBox.shrink(),
        ),
      ),
    );
  }
}
