import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/data/models/color_theme.dart';
import '../../../core/data/models/game.dart';
import '../../../core/utilities/date_utilitites.dart';
import '../clickable.dart';
import '../custom_svg.dart';

class GameItem extends StatelessWidget {
  final int index;
  final bool returnSmallCard;
  final double? cardWidth;
  const GameItem({super.key, this.cardWidth, required this.index, this.returnSmallCard = false});

  @override
  Widget build(BuildContext context) {
    final isBig = returnSmallCard ? false : index % 3 == 0;
    //final height = isBig ? 270.h : 210.h;
    final dateText = isBig ? 12.sp : 10.sp;
    final nameText = isBig ? 18.sp : 12.sp;
    final detailsText = isBig ? 32.sp : 16.sp;
    final ctaTextSize = isBig ? 16.sp : 10.sp;
    final game = Game();
    final name = game.categoryName ?? 'N/A';
    final month = DateUtilities.monthOnly(date: game.endDate);
    final day = DateUtilities.getDayOfMonthSuffix(game.endDate ?? DateTime.now());
    final remainingDays = DateUtilities.daysBetween(game.endDate?.toString() ?? DateTime.now().toString());
    final details = game.name ?? 'N/A';
    final ctaText = game.ctaText ?? 'N/A';
    final colorTheme = ColorTheme();
    final textColor =  ColorPath.dynamicColor(
        colorTheme?.entryStateTextColor,
        Theme.of(context).colorScheme.textPrimary
    );
    final buttonColor =  ColorPath.dynamicColor(
        colorTheme?.entryStateButtonColor,
        Theme.of(context).colorScheme.brandColor
    );
    final cardBgColor =  ColorPath.dynamicColor(
        colorTheme?.entryStateBackgroundColor,
        Theme.of(context).colorScheme.brandColor2
    );
    final buttonTextColor =  ColorPath.dynamicColor(
        colorTheme?.entryStateButtonTextColor,
        Theme.of(context).colorScheme.whiteText
    );
    return StaggeredGridTile.fit(
      crossAxisCellCount: isBig ? 2 : 1,
      child: Clickable(
        onPressed: ()async{
        },
        child: Container(
          //height: 186,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          width: cardWidth ?? double.infinity,
          decoration: BoxDecoration(
              color: cardBgColor,
              borderRadius: BorderRadius.all(Radius.circular(isBig ? 16.r:8.r))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isBig ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CustomAssetViewer(asset: AppAsset.calendar2, height: 14.h, width: 14.w,
                            colorFilter: ColorFilter.mode(
                              textColor,
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(width: 4.w,),
                          Text(
                            'Draw: $month $day',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                fontSize: dateText,
                                fontWeight: FontWeight.w400,
                                color:
                                textColor
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 5.w,),
                      Flexible(
                        child: FittedBox(
                          child: Row(
                            children: [
                              CustomAssetViewer(asset: AppAsset.clock, height: 14.h, width: 14.w,
                                colorFilter: ColorFilter.mode(
                                  textColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                              SizedBox(width: 4.w,),
                              Text(
                                '$remainingDays ${remainingDays > 1 ? 'days':'day'} left',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                    fontSize: dateText,
                                    fontWeight: FontWeight.w400,
                                    color:
                                    textColor
                                ),
                              )
                            ],
                          ),
                        ),
                      )
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
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(
                        fontSize: nameText,
                        fontWeight: FontWeight.w600,
                        color:
                        textColor
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )
                  :Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomAssetViewer(asset: AppAsset.calendar2, height: 10.h, width: 10.w,
                        colorFilter: ColorFilter.mode(
                          textColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 4.w,),
                      Flexible(
                        child: FittedBox(
                          child: Text(
                            'Draw: $month $day',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                fontSize: dateText,
                                fontWeight: FontWeight.w400,
                                color:
                                textColor
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h,),
                  Row(
                    children: [
                      CustomAssetViewer(asset: AppAsset.clock, height: 10.h, width: 10.w,
                        colorFilter: ColorFilter.mode(
                          textColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 4.w,),
                      Text(
                        '$remainingDays ${remainingDays > 1 ? 'days':'day'} left',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(
                            fontSize: dateText,
                            fontWeight: FontWeight.w400,
                            color:
                            textColor
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 0.5.h,
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 4.h, bottom: 8.h),
                    color:  textColor,
                  ),
                  Text(
                    name,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(
                        fontSize: nameText,
                        fontWeight: FontWeight.w600,
                        color:
                        textColor
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              SizedBox(height: isBig ? 48.h:32.h,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    details,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(
                        fontSize: detailsText,
                        fontWeight: FontWeight.w800,
                        color:
                        textColor
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h,),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: isBig ? 16.w:8.w,
                        vertical: 8.h
                    ),
                    decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.all(Radius.circular(1000.r))
                    ),
                    child: Text(
                      ctaText,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                          fontSize: ctaTextSize,
                          fontWeight: FontWeight.w600,
                          color:
                          buttonTextColor
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
