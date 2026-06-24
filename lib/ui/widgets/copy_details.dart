import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/ui/widgets/show_flush_bar.dart';

import '../../core/constants/app_asset.dart';
import '../../core/constants/color_path.dart';
import 'clickable.dart';
import 'custom_svg.dart';

class CopyDetails extends StatelessWidget {
  final String label;
  final String subtitle;
  final String detailToCopy;
  const CopyDetails({super.key, required this.label, required this.subtitle, required this.detailToCopy});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          vertical: 14.h,
          horizontal: 16.w
      ),
      decoration: BoxDecoration(
          color: ColorPath.titanPurple,
          borderRadius: BorderRadius.all(Radius.circular(12.r))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: ColorPath.blueBlue
                  ),
                ),
                SizedBox(height: 2.h,),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: ColorPath.charcoalBlack
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10.w,),
          Clickable(
            onPressed: (){
              Clipboard.setData(
                  ClipboardData(text: detailToCopy))
                  .then((value) {
                //show user 'copy' success message
                showFlushBar(
                    context: context,
                    message: '$label Copied!'
                );
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: 8.h,
                  horizontal: 16.w
              ),
              decoration: BoxDecoration(
                  color: ColorPath.fogPurple,
                  borderRadius: BorderRadius.all(Radius.circular(10000.r))
              ),
              child: Row(
                children: [
                  Text(
                    detailToCopy,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: ColorPath.blueBlue
                    ),
                  ),
                  SizedBox(width: 8.w,),
                  CustomAssetViewer(asset: AppAsset.copy, height: 16.h, width: 16.w,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
