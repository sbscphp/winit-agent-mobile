import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_asset.dart';
import 'package:winit_agent/core/constants/color_path.dart';
import 'package:winit_agent/ui/widgets/clickable.dart';
import 'package:winit_agent/ui/widgets/custom_svg.dart';

class CustomBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const CustomBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: 15.h),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: EdgeInsets.only(left:12.w, right: 12.w, top: 16.h),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: ColorPath.athensGrey,
                    width: 1.w
                  ),
                ),
              ),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  navItem(context, 0, 'Games', AppAsset.games),
                  //navItem(context, 0, 'Games', AppAsset.games),
                  SizedBox(width: 4.w),
                  navItem(context, 1, 'My Wallet', AppAsset.myWallet),
                  SizedBox(width: 78.w,),
                  navItem(context, 2, 'Notification', AppAsset.notification),
                  SizedBox(width: 4.w),
                  navItem(context, 3, 'Profile', AppAsset.profile),
                ],
              ),
            ),
            //Custom center button
            Positioned(
              left: 0,
              right: 0,
              top: -15,
              //bottom: 10,
              //left: MediaQuery.of(context).size.width / 2 - 35,
              child: GestureDetector(
                onTap: () {
                  onChanged(4);
                },
                child: Container(
                  width: 78.w,
                  height: 78.h,
                  decoration: BoxDecoration(
                    color: ColorPath.stratosBlue,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: ColorPath.stratosBlue.withOpacity(0.32),
                        blurRadius: 32,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomSvg(asset: AppAsset.home,
                        colorFilter: ColorFilter.mode(
                          ColorPath.turquoiseGreen,
                          BlendMode.srcIn,
                        ),),
                      SizedBox(height: 4.h,),
                      Text(
                          'Home',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: ColorPath.turquoiseGreen,
                          )
                      ),


                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget navItem(BuildContext context, int index, String label, String asset) {
    final isSelected = selectedIndex == index;
    return Clickable(
      onPressed: () => onChanged(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomSvg(
            asset: asset,
            colorFilter: isSelected
                ? const ColorFilter.mode(ColorPath.curiousBlue, BlendMode.srcIn)
                : null,
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? ColorPath.curiousBlue
                    : ColorPath.frenchGrey,
            )
          ),
        ],
      ),
    );
  }
}