import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/ui/widgets/clickable.dart';
import '../../core/constants/app_dimension.dart';
import '../../core/constants/color_path.dart';
import 'custom_svg.dart';

class ActionIcon extends StatelessWidget {
  final String label;
  final String asset;
  final VoidCallback? onPressed;
  final double? paddingRight;
  const ActionIcon({super.key, this.paddingRight, required this.label, required this.asset, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: paddingRight ?? AppDimension.paddingRight),
      child: Clickable(
        onPressed: onPressed,
        child: Row(
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ColorPath.frenchGrey
              ),
            ),
            SizedBox(width: 4.w,),
            CustomAssetViewer(asset: asset)

          ],
        ),
      ),
    );
  }
}
