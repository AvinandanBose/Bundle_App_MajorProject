import 'package:flashchatapplication_new/BitCoinTicker/price_screen.dart';
import 'package:flashchatapplication_new/MainBody/Body.dart';
import 'package:flashchatapplication_new/WeatherUpdate/screens/loading_screen.dart';
import 'package:flutter/material.dart';

class ResfulAPIBody extends StatefulWidget {
  const ResfulAPIBody({Key? key}) : super(key: key);

  @override
  State<ResfulAPIBody> createState() => _ResfulAPIBodyState();
}

class _ResfulAPIBodyState extends State<ResfulAPIBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF10163B),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0B102A),
          title: const Text('Restful APIs Applications'),
          centerTitle: true,
          actions:<Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const BodyMain()));
                });

              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.exit_to_app),
              ),
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoadingScreen()),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: Color(0xFF1D1E33),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        height: 200.0,
                        width: 170.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/weatherApp.png',
                              height: 130,
                              width: 130,
                            ),
                            const SizedBox(height: 15.0),
                            const Text(
                              'Weather Update App',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => PriceScreen()),
                        );
                      },

                      child: Container(
                        margin: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: Color(0xFF1D1E33),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        height: 200.0,
                        width: 170.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/bitcoin.png',
                              height: 130,
                              width: 130,
                            ),
                            const SizedBox(height: 15.0),
                            const Text(
                              'Crypto Currency Comparator',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
