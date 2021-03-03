import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class LaunchAnimation extends StatelessWidget {
  const LaunchAnimation({this.onFinished});

  final Function? onFinished;

  @override
  Widget build(BuildContext context) => Container(
    color: Colors.white,
    child: FlareActor(
      'assets/RocketLaunch.flr', 
      animation: 'launch',
      fit: BoxFit.cover,
      callback: (animation) => onFinished!(),
    ),
  );
}