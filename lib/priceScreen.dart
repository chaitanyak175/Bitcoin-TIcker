import 'package:bitcointicker/constants/homeMeshBackground.dart';
import 'package:bitcointicker/constants/mainScreenFrostedButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitcointicker/constants/coin_data.dart';
import 'package:bitcointicker/services/btcData.dart';

class Pricescreen extends StatefulWidget {
  const Pricescreen({super.key});

  @override
  State<Pricescreen> createState() => _PricescreenState();
}

class _PricescreenState extends State<Pricescreen> {
  String selectedCurrency = 'USD';

  // List<DropdownMenuItem<String>> getDropdownItem() {
  //   List<DropdownMenuItem<String>> dropdownItems = [];
  //   for (String curreny in currenciesList) {
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

  double rate = 0.0;
  Btcdata getdata = Btcdata();
  dynamic btcData;
  bool isLoading = true;

  @override
  void initState() {
    fetchBtcData();
    super.initState();
  }

  Future<void> fetchBtcData() async {
    try {
      btcData = await getdata.getBtcData(selectedCurrency);
      updateBtcRate(btcData);
    } catch (e) {
      print("Error fetching BTC Data $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void updateBtcRate(dynamic btcData) {
    setState(
      () {
        if (btcData == null || !btcData.containsKey('rate')) {
          rate = 0.0;
          return;
        }
        rate = btcData['rate'];
        rate = double.parse(rate.toStringAsFixed(2));
      },
    );
    print(rate);
  }

  CupertinoPicker getCupertinoPicker() {
    return CupertinoPicker(
      // offAxisFraction: -1.1,
      backgroundColor: Colors.transparent,
      itemExtent: 32.0,
      onSelectedItemChanged: (selecedIndex) {
        selectedCurrency = currenciesList[selecedIndex];
        fetchBtcData();
        print(selectedCurrency);
        // HapticFeedback.lightImpact();
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
                  Mainscreenfrostedbutton(
                      text: isLoading
                          ? 'Loading'
                          : '1 BTC = $rate $selectedCurrency'),
                  SizedBox(
                    height: 600,
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


