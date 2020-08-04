import 'dart:convert';

import 'package:bd_class/models/payment.models.dart';
import 'package:bd_class/services/api_data.service.dart';
import 'package:bd_class/utils/apiHelper.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class PaymentRepository {
  ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  Future<List<PaymentModel>> fetchAllPayments() async {
    List<PaymentModel> results = [];
    Iterable list;
    String url = APP_MOBILE_API + 'payment/all/';
    await this._apiBaseHelper.get(
      url
    ).then((value) {
      list = jsonDecode(value.body);
      results = list.map((model) {
        return PaymentModel.fromJson(model);
      }).toList();
    });
    return results;
  }

  Future<http.Response> addPayment(PaymentCreateModel payloads) {
    String url = APP_MOBILE_API + 'payment/create/';
    return this._apiBaseHelper.post(url, jsonEncode(payloads));
  }
}
