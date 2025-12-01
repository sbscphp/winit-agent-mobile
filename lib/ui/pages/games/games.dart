import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:winit_agent/core/constants/app_asset.dart';
import 'package:winit_agent/core/constants/app_dimension.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/data/view_models/games/all_games_vm.dart';
import 'package:winit_agent/core/utilities/extensions/color_extensions.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/pages/games/search_games.dart';
import 'package:winit_agent/ui/widgets/action_icon.dart';
import 'package:winit_agent/ui/widgets/error_state.dart';
import 'package:winit_agent/ui/widgets/profile/profile_image.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/data/enum/view_state.dart';
import '../../widgets/app_loader.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/listview_items/game_item.dart';

class Games extends ConsumerStatefulWidget {
  const Games({super.key});

  @override
  ConsumerState<Games> createState() => _GamesState();
}

class _GamesState extends ConsumerState<Games> {

  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    final vm = ref.read(allGamesViewModel);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      vm.fetchAllGames();
    });
    _scrollListener(vm);
    super.initState();
  }

  _scrollListener(AllGamesVm vm) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //check paginated state
        if(vm.paginatedState != ViewState.error){
          //check if data is not being currently fetched and also check total records
          if (vm.paginatedState != ViewState.busy && vm.allGames.length < vm.totalRecords) {
            //fetch more games
            vm.fetchAllGames(
                firstCall: false
            );
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(allGamesViewModel);
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
      body: Builder(
        builder: (context) {
          if(vm.state == ViewState.busy){
            return Padding(
              padding: EdgeInsets.only(left: AppDimension.paddingLeft, right: AppDimension.paddingRight, top: AppDimension.paddingTop),
              child: Shimmer.fromColors(
                baseColor: ColorPath.silverGrey.withCustomOpacity(0.1),
                highlightColor: ColorPath.athensGrey2,
                child: StaggeredGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 16.w,
                  children: List.generate(4, (index) {
                    final isTwo = index % 3 == 0;
                    final height = isTwo ? 250.h : 180.h;
                    return StaggeredGridTile.fit(
                      crossAxisCellCount: isTwo ? 2 : 1,
                      child: Container(
                        height: height,
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.brandColor2,
                            borderRadius: BorderRadius.all(Radius.circular(16.r))
                        ),
                      ),
                    );
                  }),
                ),
              ),
            );
          }

          if(vm.state == ViewState.retrieved){

            if(vm.allGames.isEmpty){
              return Center(
                  child: EmptyState(
                    asset: AppAsset.emptyState,
                    title: 'No Game Yet',
                    subtitle: 'There are currently no games yet to Purchase Raffle ticket for',
                  )
              );
            }

            return Column(
              children: [
                SingleChildScrollView(
                  controller: _scrollController,
                  padding: EdgeInsets.only(left: AppDimension.paddingLeft, right: AppDimension.paddingRight, top: AppDimension.paddingTop),
                  child: StaggeredGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16.h,
                    crossAxisSpacing: 16.w,
                    children: List.generate(vm.allGames.length, (index) {
                      final game = vm.allGames[index];
                      return GameItem(
                        index: index,
                        fromExploreScreen: true,
                        game: game,
                      );

                    }),
                  ),
                ),
                if(vm.paginatedState == ViewState.busy)
                  Padding(
                    padding: EdgeInsets.only(top: 5.h),
                    child: Align(
                      alignment: Alignment.center,
                      child: AppLoader(
                        size: 16,
                      ),
                    ),
                  ),
                if(vm.paginatedState == ViewState.error)
                  ErrorState(
                      message: vm.message,
                      isPaginationType: true,
                      onPressed: ()=>vm.fetchAllGames(firstCall: false))
              ],
            );
          }

          if(vm.state == ViewState.error){
            return Center(
              child: ErrorState(
                message: vm.message,
                  onPressed: ()=>vm.fetchAllGames()),
            );
          }

          return const SizedBox.shrink();
        }
      )

    );
  }

}
