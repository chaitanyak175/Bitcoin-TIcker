import 'package:bitcointicker/constants/homeMeshBackground.dart';
import 'package:bitcointicker/constants/homeScreenFrostedButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitcointicker/constants/coin_data.dart';
import 'package:bitcointicker/services/actualCoinData.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  String selectedCurrency = 'AUD';
  String selectedCoin = 'BTC';

  // List<DropdownMenuItem<String>> getDropdownItem() {
  //   List<DropdownMenuItem<String>> dropdownItems = [];
  //   for (String curreny in currenciesList)
  //     var newItem = DropdownMenuItem(
  //       child: Center(
  //         child: Text(
  //           curreny,
  //           style: TextStyle(fontFamily: 'SuisseIntl'),
  //         ),
  //       ),
  //       value: curreny,
  //     );
  //     print(curreny);
  //     dropdownItems.add(newItem);
  //   }
  //   return dropdownItems;
  // }

  double rate1 = 0.0;
  double rate2 = 0.0;
  double rate3 = 0.0;
  CoinData getdata = CoinData();
  dynamic coinData;
  bool isLoading1 = true;
  bool isLoading2 = true;
  bool isLoading3 = true;
  String crypto1 = cryptoList[0];
  String crypto2 = cryptoList[1];
  String crypto3 = cryptoList[2];

  @override
  void initState() {
    fetchCoinData(crypto1);
    fetchCoinData(crypto2);
    fetchCoinData(crypto3);
    super.initState();
    setHighRefreshRate();
  }

  Future<void> setHighRefreshRate() async {
    try {
      await FlutterDisplayMode.setHighRefreshRate();
    } on PlatformException catch (e) {
      print("Error setting refresh rate: $e");
    }
  }

  Future<void> fetchCoinData(String selectedCoin) async {
    setState(() {
      if (selectedCoin == crypto1) {
        isLoading1 = true;
      } else if (selectedCoin == crypto2) {
        isLoading2 = true;
      } else if (selectedCoin == crypto3) {
        isLoading3 = true;
      }
    });

    try {
      coinData = await getdata.getCoinData(selectedCoin, selectedCurrency);
      updateCoinRate(selectedCoin, coinData);
    } catch (e) {
      print("Error fetching BTC Data: $e");
    } finally {
      setState(() {
        if (selectedCoin == crypto1) {
          isLoading1 = false;
        } else if (selectedCoin == crypto2) {
          isLoading2 = false;
        } else if (selectedCoin == crypto3) {
          isLoading3 = false;
        }
      });
    }
  }

  void updateCoinRate(String coin, dynamic coinData) {
    setState(() {
      double newRate = 0.0;
      if (coinData != null && coinData.containsKey('rate')) {
        newRate = double.parse(coinData['rate'].toStringAsFixed(2));
      }

      if (coin == crypto1) {
        rate1 = newRate;
        isLoading1 = false;
        print("Updated rate1: $rate1");
      } else if (coin == crypto2) {
        rate2 = newRate;
        isLoading2 = false;
        print("Updated rate2: $rate2");
      } else if (coin == crypto3) {
        rate3 = newRate;
        isLoading3 = false;
        print("Updated rate3: $rate3");
      }
    });
  }

  CupertinoPicker getCupertinoPicker() {
    return CupertinoPicker(
      // offAxisFraction: -1.1,
      backgroundColor: Colors.transparent,
      itemExtent: 32.0,
      onSelectedItemChanged: (selecedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selecedIndex];
          isLoading1 = true;
          isLoading2 = true;
          isLoading3 = true;
        });

        fetchCoinData(crypto1);
        fetchCoinData(crypto2);
        fetchCoinData(crypto3);
        print(selectedCurrency);
        HapticFeedback.lightImpact();
      },
      children: List.generate(
        currenciesList.length,
        (index) {
          return Center(
            child: Text(
              currenciesList[index],
              style: TextStyle(fontFamily: 'SuisseIntl'),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: <Widget>[
            Homemeshbackground(),
            Positioned(
              top: 100.0,
              left: 20.0,
              right: 20.0,
              child: Column(
                children: <Widget>[
                  Homescreenfrostedbutton(
                    onPressed: () => fetchCoinData(crypto1),
                    text: isLoading1
                        ? 'Loading'
                        : '1 $crypto1 = $rate1 $selectedCurrency',
                  ),
                  SizedBox(height: 20),
                  Homescreenfrostedbutton(
                    onPressed: () => fetchCoinData(crypto2),
                    text: isLoading2
                        ? 'Loading'
                        : '1 $crypto2 = $rate2 $selectedCurrency',
                  ),
                  SizedBox(height: 20),
                  Homescreenfrostedbutton(
                    onPressed: () => fetchCoinData(crypto3),
                    text: isLoading3
                        ? 'Loading'
                        : '1 $crypto3 = $rate3 $selectedCurrency',
                  ),
                  SizedBox(
                    height: 420,
                  ),
                  Container(
                    height: 150,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(bottom: 30),
                    color: Colors.transparent,
                    child: Container(
                      width: 100,
                      child: getCupertinoPicker(),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// DropdownButton<String>(
//                       enableFeedback: true,
//                       value: selectedCurrency,
//                       items: getDropdownItem(),
//                       onChanged: (value) {
//                         setState(() {
//                           selectedCurrency = value!;
//                         });

//                         print(value);
//                         HapticFeedback.heavyImpact();
//                       },
//                     ),


