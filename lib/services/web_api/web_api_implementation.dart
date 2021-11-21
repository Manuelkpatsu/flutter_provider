// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutterprovider/business_logic/models/rate.dart';
import 'package:http/http.dart' as http;
import 'web_api.dart';

class WebApiImpl implements WebApi {
  final _baseUrl = 'http://api.exchangeratesapi.io';
  final _path = '/v1/latest';
  final _accessKey = "f4a1bc2c38223b377ad87dd3c22d92c6";
  final Map<String, String> _headers = {'Accept': 'application/json'};

  List<Rate> _rateCache = [];

  @override
  Future<List<Rate>> fetchExchangeRates() async {
    if (_rateCache.isEmpty) {
      var url = "$_baseUrl$_path?access_key=$_accessKey";
      print('getting rates from the web');
      final uri = Uri.parse(url);
      final results = await http.get(uri, headers: _headers);
      final jsonObject = json.decode(results.body);
      print(jsonObject);
      _rateCache = _createRateListFromRawMap(jsonObject);
    } else {
      print('getting rates from cache');
    }
    return _rateCache;
  }

  List<Rate> _createRateListFromRawMap(Map jsonObject) {
    final Map rates = jsonObject['rates'];
    final String base = jsonObject['base'];
    List<Rate> list = [];
    list.add(Rate(baseCurrency: base, quoteCurrency: base, exchangeRate: 1.0));
    for (var rate in rates.entries) {
      list.add(
        Rate(
          baseCurrency: base,
          quoteCurrency: rate.key,
          exchangeRate:  double.parse(rate.value.toString()),
        ),
      );
    }
    return list;
  }
}
