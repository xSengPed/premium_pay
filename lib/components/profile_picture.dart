import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yt_app/configs/size_config.dart';

class ProfilePicture extends StatelessWidget {
  final bool isAdmin;
  const ProfilePicture({super.key, this.isAdmin = true});
// https://lh3.googleusercontent.com/a/AGNmyxZPl8pd12dksAMUI6-17e4xdK-w1zfFXIpHJPG_HYM=s100
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double defaultSize = SizeConfig.defaultSize;

    return Container(
      padding: EdgeInsets.all(1.6 * defaultSize),
      width: double.infinity,
      height: 14.0 * defaultSize,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: CachedNetworkImage(
              placeholder: (context, url) => CircularProgressIndicator(),
              fit: BoxFit.cover,
              imageUrl:
                  "https://lh3.googleusercontent.com/a/AGNmyxZPl8pd12dksAMUI6-17e4xdK-w1zfFXIpHJPG_HYM=s100"),
        ),
        SizedBox(
          width: 1.6 * defaultSize,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Donnukrit Satirakul",
                style: TextStyle(
                    fontSize: 1.6 * defaultSize, fontWeight: FontWeight.w600)),
            SizedBox(
              height: 0.5 * defaultSize,
            ),
            Text("091-053-3948",
                style: TextStyle(
                    fontSize: 1.2 * defaultSize, fontWeight: FontWeight.w400)),
            SizedBox(
              height: 0.5 * defaultSize,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: 0.5 * defaultSize, horizontal: 1.5 * defaultSize),
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: isAdmin ? Colors.amber[200]! : Colors.green[400]!,
                  ),
                  color: isAdmin ? Colors.yellow[50]! : Colors.green[50]!,
                  borderRadius: BorderRadius.circular(0.4 * defaultSize)),
              child: isAdmin
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Image.asset('assets/icons/king.png',
                            width: 1.4 * defaultSize),
                        SizedBox(
                          width: 0.5 * defaultSize,
                        ),
                        Text(
                          "Master",
                          style: TextStyle(
                              fontSize: 1.0 * defaultSize,
                              color: Colors.amber,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  : Text(
                      "Member",
                      style: TextStyle(
                          fontSize: 1.0 * defaultSize,
                          color: Colors.green[400]!,
                          fontWeight: FontWeight.bold),
                    ),
            )
          ],
        )
      ]),
    );
  }
}
