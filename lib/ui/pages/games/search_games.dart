import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/data/models/color_theme.dart';
import '../../../core/data/models/game.dart';
import '../../../core/utilities/date_utilitites.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_svg.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/text_fields/search_field.dart';

class SearchGames extends StatefulWidget {
  const SearchGames({super.key});

  @override
  State<SearchGames> createState() => _SearchGamesState();
}

class _SearchGamesState extends State<SearchGames> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Search',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimension.paddingLeft, vertical: AppDimension.paddingTop),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchField(
              hintText: 'Enter Game name',
              keyboardType: TextInputType.text,
              onChanged: (value){

              },
            ),
            SizedBox(height: 32.h,),
            if(1 + 1 == 3)
              Expanded(
                child: GridView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 8,
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 32.h,
                  crossAxisSpacing: 16.w,
                  mainAxisExtent: 186.h,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final dateText = 10.sp;
                  final nameText = 12.sp;
                  final detailsText =  16.sp;
                  final ctaTextSize = 10.sp;
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
                  return Container(
                    // height: height,
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: cardBgColor,
                        borderRadius: BorderRadius.all(Radius.circular(16.r))
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
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
                        SizedBox(height: 10.h,),
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
                                  horizontal: 8.w,
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
                  );
                }))
            else Expanded(
              child: Center(
                  child: EmptyState(
                    asset: AppAsset.emptyState,
                    title: 'No Search Result',
                    subtitle: 'Enter a new keyword to search for Games',
                  )
              ),
            )

          ],
        ),
      ),
    );
  }
}
