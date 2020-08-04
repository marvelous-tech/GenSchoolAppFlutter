import 'dart:convert';

import 'package:bd_class/models/notice_board.model.dart';
import 'package:bd_class/services/api_data.service.dart';
import 'package:bd_class/utils/apiHelper.dart';

class NoticeBoardRepository {
  ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  Future<List<NoticeBoardModel>> fetchAllNotices() async {
    List<NoticeBoardModel> results = [];
    Iterable list;
    String url = APP_MOBILE_API + 'notice_board/all/';
    await this._apiBaseHelper.get(
      url
    ).then((value) {
      list = jsonDecode(value.body);
      results = list.map((model) {
        return NoticeBoardModel.fromJson(model);
      }).toList();
    });
    return results;
  }
}
