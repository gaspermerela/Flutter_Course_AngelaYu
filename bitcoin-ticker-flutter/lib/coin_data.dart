import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = '0D0C4C17-0C05-4D34-914F-9714AFEC49FE';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future getCoinPrices(String fiat) async {
    Map<String, String> prices = {};
    for (String cur in cryptoList) {
      String request =
          'https://rest.coinapi.io/v1/exchangerate/$cur/$fiat/?apikey=$apiKey';
      http.Response response = await http.get(request);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        prices[cur] = data['rate'].toStringAsFixed(3);
      } else {
        print(response.statusCode);
      }
    }
    return prices;
  }
}
