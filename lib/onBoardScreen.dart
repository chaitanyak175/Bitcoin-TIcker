import 'package:bitcointicker/constants/frostedButton.dart';
import 'package:bitcointicker/priceScreen.dart';
import 'package:flutter/material.dart';
import 'constants/meshBackground.dart';

class onboardScreen extends StatefulWidget {
  const onboardScreen({super.key});

  @override
  State<onboardScreen> createState() => _onboardScreenState();
}

class _onboardScreenState extends State<onboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: <Widget>[
            Meshbackground(),
            Positioned(
              bottom: 50.0,
              left: 20.0,
              right: 20.0,
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      'More than just Bitcoin Price Converter',
                      style: TextStyle(
                        fontFamily: 'SuisseIntl',
                        fontSize: 45.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Ensure text is visible
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Divider(
                    indent: 15,
                    endIndent: 15,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  FrostedButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Pricescreen(),
                        ),
                      );
                    },
                    text: "Enter Bitcoin Ticker",
                    icon: Icon(Icons.arrow_forward_outlined),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
