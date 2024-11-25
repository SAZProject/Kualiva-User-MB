import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_it/common/app_export.dart';
import 'package:map_launcher/map_launcher.dart';

customMapBottomSheet(BuildContext context, double latitude, double longitude,
    String placename) async {
  try {
    final coords = Coords(latitude, longitude);
    final availableMaps = await MapLauncher.installedMaps;

    if (!context.mounted) return;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Wrap(
              children: <Widget>[
                for (var map in availableMaps)
                  ListTile(
                    onTap: () => map.showMarker(
                      coords: coords,
                      title: placename,
                    ),
                    title: Text(map.mapName),
                    leading: SvgPicture.asset(
                      map.icon,
                      height: 30.h,
                      width: 30.h,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  } catch (e) {
    if (!context.mounted) return;
  }
}
