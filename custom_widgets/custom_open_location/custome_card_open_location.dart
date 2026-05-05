import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../../shared/resourses/colors_manager.dart';

class CustomeCardOpenLocation extends StatelessWidget {
  final double latt, longg;

  CustomeCardOpenLocation({
    super.key,
    required this.latt,
    required this.longg,
  });

  Future<void> openMap() async {
    // اطلب إذن الموقع
    var status = await Permission.location.request();

    if (status.isDenied || status.isPermanentlyDenied) {
      print("Location permission denied");
      return;
    }

    // رابط Google Maps باستخدام الإحداثيات الممررة
    final Uri googleUrl = Uri.parse("geo:0,0?q=$latt,$longg");

    if (await canLaunchUrl(googleUrl)) {
      await launchUrl(
        googleUrl,
        mode: LaunchMode.externalApplication,
      );
    } else {
      print("geo intent didn't work — using fallback URL");

      // رابط بديل:
      final Uri fallbackUrl = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=$latt,$longg",
      );

      if (await canLaunchUrl(fallbackUrl)) {
        await launchUrl(
          fallbackUrl,
          mode: LaunchMode.externalApplication,
        );
      } else {
        print("Could not launch map at all");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return InkWell(
      onTap: () => openMap(),
      child: Card(
        margin: EdgeInsets.only(
          top: screenSize.height * 0.02,
          bottom: screenSize.height * 0.04,
        ),
        color: ColorsManager.coffeColors,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: ColorsManager.primeColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on_sharp,
                color: ColorsManager.primeColor,
                size: screenSize.width * 0.06,
              ),
              SizedBox(width: screenSize.width * 0.02),
              Text(
                tr("open_in_map"),
                style: TextStyle(fontSize: screenSize.width * 0.045),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
