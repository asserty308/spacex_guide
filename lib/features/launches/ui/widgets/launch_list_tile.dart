import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spacex_guide/core/utility/navigation.dart';
import 'package:spacex_guide/features/launches/domain/entities/launch.dart';
import 'package:spacex_guide/features/launches/ui/pages/launch_detail_screen.dart';

class LaunchListTile extends StatelessWidget {
  const LaunchListTile({
    Key key,
    @required this.launch,
  }) : super(key: key);

  final Launch launch;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        launch.missionName,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        launch.formattedLaunchDate(),
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      leading: CircleAvatar(
        child: launch.missionPatch == null ? Text(
          '${launch.flightNumber}',
          style: TextStyle(color: Colors.white),
        ) : CachedNetworkImage(
          imageUrl: launch.missionPatch,
        ),
        backgroundColor: launch.missionPatch == null ? Colors.white24 : Colors.transparent,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Colors.white30,
        size: 18,
      ),
      onTap: () => showScreen(context, LaunchDetailScreen(launch)),
    );
  }
}