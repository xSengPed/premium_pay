import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_yt_app/components/sx_button.dart';
import 'package:flutter_yt_app/configs/size_config.dart';

class MemberCard extends StatelessWidget {
  const MemberCard({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double defaultSize = SizeConfig.defaultSize;
    return Container(
      padding: const EdgeInsets.all(16),
      height: 14.0 * defaultSize,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/yt_premium.svg',
                width: 2.4 * defaultSize,
                height: 2.4 * defaultSize,
              ),
              SizedBox(
                width: 6.4 * defaultSize,
              ),
              Expanded(
                child: SxButton(
                  backgroundColor: Colors.red[700],
                  shape: SxButtonShape.rounded,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text('จ่ายเงิน'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                'ชำระเงินล่าสุด',
                style: TextStyle(
                    fontSize: 1.4 * defaultSize, fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 0.4 * defaultSize),
              Text(
                '1 เมษายน 2566',
                style: TextStyle(fontSize: 1.4 * defaultSize),
              ),
              const Spacer(),
              Text(
                'หมดอายุ',
                style: TextStyle(
                    fontSize: 1.4 * defaultSize, fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 0.4 * defaultSize),
              Text(
                '1 เมษายน 2567',
                style: TextStyle(fontSize: 1.4 * defaultSize),
              ),
            ],
          )
        ],
      ),
    );
  }
}
