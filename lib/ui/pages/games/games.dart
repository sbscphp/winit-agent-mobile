import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:winit_agent/core/constants/app_asset.dart';
import 'package:winit_agent/core/constants/app_dimension.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/pages/games/search_games.dart';
import 'package:winit_agent/ui/widgets/action_icon.dart';
import 'package:winit_agent/ui/widgets/profile/profile_image.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/listview_items/game_item.dart';

class Games extends StatefulWidget {
  const Games({super.key});

  @override
  State<Games> createState() => _GamesState();
}

class _GamesState extends State<Games> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        centerTitle: true,
        leadingIcon: ProfileImage(),
        title: 'Explore',
        actions: [
          ActionIcon(label: 'Search', asset: AppAsset.search,
            onPressed: (){
              pushNavigation(context: context, widget: const SearchGames(), routeName: NamedRoutes.searchGames);
            },
          )
        ]
      ),
      body: 1 + 1 == 2
          ? SingleChildScrollView(
        padding: EdgeInsets.only(left: AppDimension.paddingLeft, right: AppDimension.paddingRight, top: AppDimension.paddingTop),
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16.h,
          crossAxisSpacing: 16.w,
          children: List.generate(4, (index) {

            return GameItem(
              index: index,
            );

          }),
        ),
      )
      : Center(
          child: EmptyState(
            asset: AppAsset.emptyState,
            title: 'No Game Yet',
            subtitle: 'There are currently no games yet to Purchase Raffle ticket for',
          )
      ),
    );
  }
}
