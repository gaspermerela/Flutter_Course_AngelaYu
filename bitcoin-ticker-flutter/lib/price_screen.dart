import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:http/http.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = new CoinData();
  Map<String, String> prices = {};

  String selectedCurrency = 'EUR'; // middle card
  bool isWaiting = false; // to display '?' while we wait for the data

  void getData() async {
    isWaiting = true;
    try {
      var data = await coinData.getCoinPrices(selectedCurrency);
      isWaiting = false;
      setState(() {
        prices = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  DropdownButton<String> androidDropdownButton() {
    List<DropdownMenuItem<String>> items = [];
    for (String cur in currenciesList) {
      items.add(
        DropdownMenuItem<String>(
          child: Text(cur),
          value: cur,
        ),
      );
    }
    return DropdownButton(
      value: selectedCurrency,
      items: items,
      onChanged: (String value) async {
        setState(() {
          selectedCurrency = value;
          getData();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Widget> items = [];
    for (String cur in currenciesList) {
      items.add(Text(cur));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
        selectedCurrency = currenciesList[selectedIndex];
        getData();
      },
      children: items,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (String crypto in cryptoList)
            CurrencyCard(
              cryptoCur: crypto,
              price: isWaiting ? '?' : prices[crypto],
              fiatCur: selectedCurrency,
            ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 150.0,
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 30.0),
                color: Colors.lightBlue,
                child: Platform.isIOS ? iOSPicker() : androidDropdownButton(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CurrencyCard extends StatelessWidget {
  const CurrencyCard({this.cryptoCur, this.price, this.fiatCur});

  final String cryptoCur;
  final String price;
  final String fiatCur;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCur = $price $fiatCur',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
