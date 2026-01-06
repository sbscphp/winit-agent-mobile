import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/data/models/game.dart';
import 'package:winit_agent/core/data/view_models/games/search_games_vm.dart';
import 'package:winit_agent/ui/widgets/app_loader.dart';
import 'package:winit_agent/ui/widgets/error_state.dart';
import '../../../core/constants/app_asset.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/data/enum/view_state.dart';
import '../../../core/utilities/debouncer.dart';
import '../../../core/utilities/utilities.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/listview_items/game_item.dart';
import '../../widgets/show_flush_bar.dart';
import '../../widgets/text_fields/search_field.dart';

class SearchGames extends ConsumerStatefulWidget {
  const SearchGames({super.key});

  @override
  ConsumerState<SearchGames> createState() => _SearchGamesState();
}

class _SearchGamesState extends ConsumerState<SearchGames> {

  late ScrollController _scrollController;
  final _keyWord = TextEditingController();
  late Debouncer debouncer;

  @override
  void initState() {
    _scrollController = ScrollController();
    debouncer = Debouncer(milliseconds: 800);
    _scrollListener();
    super.initState();
  }

  _scrollListener() {
    final vm = ref.read(searchGamesViewModel);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //check paginated state
        if(vm.paginatedState != ViewState.error){
          //check if data is not being currently fetched and also check total records
          if (vm.paginatedState != ViewState.busy && vm.searchResults.length < vm.totalRecords) {
            //fetch more events
            vm.fetchSearchResults(
                firstCall: false,
                keyWord: _keyWord.text
            );
          }
        }
      }
    });
  }

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
              hintText: 'Enter Raffle name',
              keyboardType: TextInputType.text,
              onChanged: (value){
                debouncer.performAction(action: () async {
                  if (value.isNotEmpty &&
                      value.length >= 3){
                    Utilities.hideKeyboard(context);
                    //search games
                    final vm = ref.read(searchGamesViewModel);
                    await vm.fetchSearchResults(keyWord: value.trim(), firstCall: true);
                    showFlushBar(
                        context: context,
                        success: vm.state == ViewState.retrieved,
                        message: vm.message
                    );
                  }
                });
              },
            ),
            SizedBox(height: 32.h,),
              Consumer(
                builder: (context, ref, child){
                  final vm = ref.watch(searchGamesViewModel);

                  if(vm.state == ViewState.busy){
                    return Expanded(
                      child: AppLoader(),
                    );
                  }

                  if(vm.state == ViewState.retrieved){
                    if(vm.searchResults.isEmpty){
                      return Expanded(
                        child:Center(
                            child: EmptyState(
                              asset: AppAsset.emptyState,
                              title: 'No Search Result',
                              subtitle: 'Enter a new keyword to search for Raffles',
                            )
                        ),
                      );
                    }
                    return Expanded(
                      child: Column(
                        children: [
                          Expanded(
                              child: GridView.builder(
                                controller: _scrollController,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: vm.searchResults.length,
                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 15.h,
                                    crossAxisSpacing: 16.w,
                                    mainAxisExtent: 190.h,
                                  ),
                                  itemBuilder: (BuildContext context, int index) {
                                  final game = vm.searchResults[index];
                                    return GameItem(
                                      index: index,
                                      returnSmallCard: true,
                                      game: game,
                                    );
                                  })),
                          if(vm.paginatedState == ViewState.busy)
                            Padding(
                              padding: EdgeInsets.only(top: 5.h),
                              child: const Align(
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
                                onPressed: ()=>vm.fetchSearchResults(firstCall: false, keyWord: _keyWord.text.trim()))
                        ],
                      ),
                    );
                  }

                  if(vm.state == ViewState.error){
                    Expanded(
                      child: Center(
                        child: ErrorState(
                          message: vm.message,
                            onPressed: ()=>vm.fetchSearchResults(keyWord: _keyWord.text)),
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              )

          ],
        ),
      ),
    );
  }

}
