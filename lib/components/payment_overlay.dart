import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_yt_app/components/button.dart';

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

  int index = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Row(
            children: [
              Text(
                "Payment",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Button(
                  child: SvgPicture.asset(
                    "assets/icons/close-outline.svg",
                    width: 24,
                  ),
                  onClick: () {
                    Navigator.pop(context);
                  }),
            ],
          ),
          Center(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 1000),
              constraints: BoxConstraints(maxWidth: 150),
              child: Image.asset(
                paymentOr[index],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              'แพคเกจ 6 เดือน 600 ฿',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}
