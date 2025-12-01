import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/pages/games/select_quantity.dart';
import '../../../core/constants/app_asset.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/data/models/game.dart';
import '../../../core/utilities/date_utilitites.dart';
import '../clickable.dart';
import '../custom_svg.dart';

class GameItem extends StatelessWidget {
  final int index;
  final bool returnSmallCard;
  final double? cardWidth;
  final bool fromExploreScreen;
  final Game game;
  const GameItem({
    super.key,
    this.cardWidth,
    required this.index,
    this.returnSmallCard = false,
    this.fromExploreScreen = false,
    required this.game
  });

  @override
  Widget build(BuildContext context) {
    final isBig = returnSmallCard ? false : index % 3 == 0;
    //final height = isBig ? 270.h : 210.h;
    //final game = Game();
    final name = game.categoryName ?? 'N/A';
    final month = DateUtilities.monthOnly(date: game.endDate);
    final day = DateUtilities.getDayOfMonthSuffix(
      game.endDate ?? DateTime.now(),
    );
    final remainingDays = DateUtilities.daysBetween(
      game.endDate?.toString() ?? DateTime.now().toString(),
    );
    final details = game.name ?? 'N/A';
    final ctaText = game.ctaText ?? 'N/A';
    final colorTheme = game.colorThemes;
    final textColor = ColorPath.dynamicColor(
      colorTheme?.entryStateTextColor,
      Theme.of(context).colorScheme.textPrimary,
    );
    final buttonColor = ColorPath.dynamicColor(
      colorTheme?.entryStateButtonColor,
      Theme.of(context).colorScheme.brandColor,
    );
    final cardBgColor = ColorPath.dynamicColor(
      colorTheme?.entryStateBackgroundColor,
      Theme.of(context).colorScheme.brandColor2,
    );
    final buttonTextColor = ColorPath.dynamicColor(
      colorTheme?.entryStateButtonTextColor,
      Theme.of(context).colorScheme.whiteText,
    );

    if (returnSmallCard) {
      return Clickable(
        onPressed: (){
          pushNavigation(context: context, widget: const SelectQuantity(), routeName: NamedRoutes.selectQuantity);
        },
        child: Container(
          //height: 186,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          width: cardWidth ?? double.infinity,
          decoration: BoxDecoration(
            color: cardBgColor,
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
          ),
          child: smallCard(
            context,
            name: name,
            month: month,
            day: day,
            remainingDays: remainingDays,
            details: details,
            ctaText: ctaText,
            textColor: textColor,
            btnColor: buttonColor,
            cardBgColor: cardBgColor,
            btnTextColor: buttonTextColor,
          ),
        ),
      );
    }

    return StaggeredGridTile.fit(
      crossAxisCellCount: isBig ? 2 : 1,
      child: Clickable(
        onPressed: () {
          pushNavigation(context: context, widget: const SelectQuantity(), routeName: NamedRoutes.selectQuantity);
        },
        child: Container(
          //height: 186,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          width: cardWidth ?? double.infinity,
          decoration: BoxDecoration(
            color: cardBgColor,
            borderRadius: BorderRadius.all(Radius.circular(isBig ? 16.r : 8.r)),
          ),
          child: isBig
              ? bigCard(
                  context,
                  name: name,
                  month: month,
                  day: day,
                  remainingDays: remainingDays,
                  details: details,
                  ctaText: ctaText,
                  textColor: textColor,
                  btnColor: buttonColor,
                  cardBgColor: cardBgColor,
                  btnTextColor: buttonTextColor,
                )
              : smallCard(
                  context,
                  name: name,
                  month: month,
                  day: day,
                  remainingDays: remainingDays,
                  details: details,
                  ctaText: ctaText,
                  textColor: textColor,
                  btnColor: buttonColor,
                  cardBgColor: cardBgColor,
                  btnTextColor: buttonTextColor,
                ),
        ),
      ),
    );
  }

  smallCard(
    BuildContext context, {
    required String name,
    required String month,
    required String day,
    required int remainingDays,
    required String details,
    required String ctaText,
    required Color textColor,
    required Color btnColor,
    required Color cardBgColor,
    required Color btnTextColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomAssetViewer(
                  asset: AppAsset.calendar2,
                  height: 10.h,
                  width: 10.w,
                  colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
                ),
                SizedBox(width: 4.w),
                Flexible(
                  child: FittedBox(
                    child: Text(
                      'Draw: $month $day',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: textColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),
            Row(
              children: [
                CustomAssetViewer(
                  asset: AppAsset.clock,
                  height: 10.h,
                  width: 10.w,
                  colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
                ),
                SizedBox(width: 4.w),
                Text(
                  '$remainingDays ${remainingDays > 1 ? 'days' : 'day'} left',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: textColor,
                  ),
                ),
              ],
            ),
            Container(
              height: 1.h,
              width: double.infinity,
              margin: EdgeInsets.only(top: 4.h, bottom: 8.h),
              color: textColor,
            ),
            Text(
              name,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        if(fromExploreScreen)SizedBox(height: 32.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              details,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
                color: textColor,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: btnColor,
                borderRadius: BorderRadius.all(Radius.circular(1000.r)),
              ),
              child: Text(
                ctaText,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: btnTextColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  bigCard(
    BuildContext context, {
    required String name,
    required String month,
    required String day,
    required int remainingDays,
    required String details,
    required String ctaText,
    required Color textColor,
    required Color btnColor,
    required Color cardBgColor,
    required Color btnTextColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomAssetViewer(
                      asset: AppAsset.calendar2,
                      height: 14.h,
                      width: 14.w,
                      colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Draw: $month $day',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 5.w),
                Flexible(
                  child: FittedBox(
                    child: Row(
                      children: [
                        CustomAssetViewer(
                          asset: AppAsset.clock,
                          height: 14.h,
                          width: 14.w,
                          colorFilter: ColorFilter.mode(
                            textColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '$remainingDays ${remainingDays > 1 ? 'days' : 'day'} left',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: textColor,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 1.h,
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 8.h),
              color: textColor,
            ),
            Text(
              name,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        SizedBox(height: 48.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              details,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 32.sp,
                fontWeight: FontWeight.w800,
                color: textColor,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: btnColor,
                borderRadius: BorderRadius.all(Radius.circular(1000.r)),
              ),
              child: Text(
                ctaText,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: btnTextColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
