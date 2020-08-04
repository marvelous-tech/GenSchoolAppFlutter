import 'dart:convert';

import 'package:bd_class/models/quote.models.dart';
import 'package:http/http.dart';

class QuoteAPIService {

  Future<QuoteAPIModel> fetchQOTD() async {
    QuoteAPIModel quoteAPIModel;
    await get("https://favqs.com/api/qotd")
    .then((value) {
      quoteAPIModel = QuoteAPIModel.fromJson(jsonDecode(value.body));
    });
    return quoteAPIModel;
  }
}
