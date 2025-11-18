import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/ui/widgets/clickable.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/constants/color_path.dart';
import '../custom_radio_button.dart';
import '../custom_svg.dart';
import '../winit_container.dart';

class BankAccountItem extends StatelessWidget {
  final bool canDelete;
  const BankAccountItem({super.key, this.canDelete = false});

  @override
  Widget build(BuildContext context) {
    return WinitContainer(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(!canDelete)CustomRadioButton(disableClick: true,),
                if(!canDelete)SizedBox(width: 8.w,),
                CustomAssetViewer(asset: AppAsset.building4, height: 32.h, width: 32.w,),
                SizedBox(width: 8.w,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Access Bank PLC',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).colorScheme.textPrimary
                        ),
                      ),
                      SizedBox(height: 4.h,),
                      FittedBox(
                        child: Row(
                          children: [
                            Row(
                              children: [
                                CustomAssetViewer(asset: AppAsset.avatar2, height: 14.h, width: 14.w,),
                                SizedBox(width: 4.w,),
                                Text(
                                  'Adekunle',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).colorScheme.textSecondary
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 16.h,
                              width: 1.w,
                              color: ColorPath.athensGrey3,
                              margin: EdgeInsets.symmetric(horizontal: 11.w),
                            ),
                            Row(
                              children: [
                                CustomAssetViewer(asset: AppAsset.accountNo, height: 14.h, width: 14.w,),
                                SizedBox(width: 4.w,),
                                Text(
                                  '0069000592',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).colorScheme.textSecondary
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          if(canDelete)Clickable(
            onPressed: (){},
              child: CustomAssetViewer(asset: AppAsset.delete2, height: 18.h, width: 18.w,))
        ],
      ),
    );
  }
}
