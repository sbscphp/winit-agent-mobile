import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winit_agent/core/constants/app_constants.dart';
import 'package:winit_agent/core/data/data_provider/utility_data_provider/utility_data_provider.dart';
import 'package:winit_agent/core/data/enum/view_state.dart';
import 'package:winit_agent/core/data/states/base_state.dart';
import 'package:winit_agent/core/utilities/utilities.dart';
import 'package:winit_agent/locator.dart';

class TermsVm extends BaseState{

  //utility data provider
  final UtilityDataProvider _utilityDp = locator<UtilityDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //terms
  String _terms = '';
  String get terms => _terms;


  //fetch terms
  fetchTerms() async {
    setState(ViewState.busy);
    await _utilityDp.fetchTerms().then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      //_terms = response.data ?? '';
      _terms = sanitizeHtml(response.data ?? '');
      setState(ViewState.retrieved);
    }).catchError((e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }

  String sanitizeHtml(String html) {
    // 1. Decode HTML entities if any (like &lt; etc)
    final unescaped = html.replaceAll('&nbsp;', ' ');

    // 2. Remove <style>, <head>, and <html> wrappers
    String cleaned = unescaped
        .replaceAll(RegExp(r'<!DOCTYPE[^>]*>', dotAll: true), '')
        .replaceAll(RegExp(r'<html[^>]*>|</html>', dotAll: true), '')
        .replaceAll(RegExp(r'<head[^>]*>.*?</head>', dotAll: true), '')
        .replaceAll(RegExp(r'<style[^>]*>.*?</style>', dotAll: true), '');

    // 3. Extract only the <td class="content">...</td> block if it exists
    final match = RegExp(r'<td[^>]*class="content"[^>]*>([\s\S]*?)<\/td>')
        .firstMatch(cleaned);
    if (match != null) cleaned = match.group(1)!;

    // 4. Remove <table>, <tr>, <td> wrappers — keep inner content
    cleaned = cleaned.replaceAll(RegExp(r'</?(table|tr|td)[^>]*>', dotAll: true), '');

    // 5. Trim whitespace
    return cleaned.trim();
  }

}

final termsViewModel = ChangeNotifierProvider.autoDispose<TermsVm>((ref){
  return TermsVm();
});