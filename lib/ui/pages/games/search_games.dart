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
import '../../widgets/listview_items/game_item.dart';
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
            if(1 + 1 == 2)
              Expanded(
                child: GridView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 8,
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15.h,
                  crossAxisSpacing: 16.w,
                  mainAxisExtent: 186.h,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GameItem(
                    index: index,
                    returnSmallCard: true,
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
