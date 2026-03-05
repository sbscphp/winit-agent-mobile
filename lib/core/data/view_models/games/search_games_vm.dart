
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winit_agent/core/data/models/game.dart';
import 'package:winit_agent/core/data/states/base_state.dart';

import '../../../../locator.dart';
import '../../../constants/app_constants.dart';
import '../../../utilities/utilities.dart';
import '../../data_provider/game_data_provider.dart';
import '../../enum/view_state.dart';


class SearchGamesVm extends BaseState{

  //event data provider
  final GameDataProvider _gameDp = locator<GameDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //list of search result
  List<Game> _searchResults = [];
  List<Game> get searchResults => _searchResults;

  //page number
  int pageNumber = 1;

  //total records
  int totalRecords = 0;

  //fetch games
  fetchSearchResults({bool firstCall = true, bool refreshUi = true, required String keyWord}) async {
    if(firstCall){
      pageNumber = 1;
      if(refreshUi)setState(ViewState.busy);
    }
    else{
      setPaginatedState(ViewState.busy);
    }



    await _gameDp.fetchAllGames(
        pageNumber: pageNumber,
        filterParams: {
          'search': keyWord
        }

    ).then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      totalRecords = response.data?.total ?? 0;
      if(firstCall){
        //populate list
        _searchResults = response.data?.data ?? [];
        setState(ViewState.retrieved);
      }
      else{
        //add to list
        _searchResults.addAll(response.data?.data ?? []);
        setPaginatedState(ViewState.retrieved);
      }
      pageNumber++;
      //debugPrint("length of search results::::${_searchResults.length}>>>");
    }, onError: (e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      if(firstCall){
        setState(ViewState.error);
      }else{
        setPaginatedState(ViewState.error);
      }
    });
  }
}

final searchGamesViewModel = ChangeNotifierProvider.autoDispose<SearchGamesVm>((ref){
  return SearchGamesVm();
});