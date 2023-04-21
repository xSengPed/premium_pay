import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_yt_app/components/button.dart';
import 'package:flutter_yt_app/components/sx_button.dart';

class PaymentOverlay extends StatefulWidget {
  const PaymentOverlay({super.key});

  @override
  State<PaymentOverlay> createState() => _PaymentOverlayState();
}

class _PaymentOverlayState extends State<PaymentOverlay> {
  final List<String> paymentOr = [
    "assets/images/half-year.png",
    "assets/images/full-year.png"
  ];

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.centerLeft,
            child: Text("Payment"),
          ),
          Spacer(),
          AnimatedContainer(
            duration: Duration(milliseconds: 1000),
            child: Image.asset(
              paymentOr[index],
              width: MediaQuery.of(context).size.width * 0.25,
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: SxButton(
                    label: "6 Months",
                    labelStyle: TextStyle(color: Colors.white),
                    backgroundColor: Colors.indigo[800],
                    onClick: () {
                      setState(() {
                        index = 0;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: SxButton(
                    label: "12 Months",
                    labelStyle: TextStyle(color: Colors.white),
                    backgroundColor: Colors.indigo[800],
                    onClick: () {
                      setState(() {
                        index = 1;
                      });
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
