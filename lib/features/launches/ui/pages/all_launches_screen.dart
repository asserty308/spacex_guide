import 'package:flutter/material.dart';
import 'package:spacex_guide/core/ui/widgets/drawer.dart';
import 'package:spacex_guide/features/launches/domain/entities/launch.dart';
import 'package:spacex_guide/features/launches/ui/bloc/all_launches_bloc.dart';
import 'package:spacex_guide/features/launches/ui/pages/delegates/launch_search_delegate.dart';
import 'package:spacex_guide/features/launches/ui/widgets/launch_animation.dart';
import 'package:spacex_guide/features/launches/ui/widgets/launch_list.dart';

class AllLaunchesScreen extends StatefulWidget {
  @override
  _AllLaunchesScreenState createState() => _AllLaunchesScreenState();
}

class _AllLaunchesScreenState extends State<AllLaunchesScreen> {
  final _bloc = AllLaunchesBloc();
  var _launchData = List<Launch>();
  var _showSplash = true;

  @override
  void initState() {
    super.initState();
    _bloc.fetchAllLaunches();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text('All Launches'),
            backgroundColor: Colors.black,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () => showLaunchSearch(context),
              ),
            ],
          ),
          drawer: MyDrawer(),
          body: buildList(),
        ),
        _showSplash ? LaunchAnimation(
          onFinished: () {
            setState(() {
              _showSplash = false;
            });
          },
        ) : Container()
      ],
    );
  }

  Widget buildList() {
    return StreamBuilder(
      stream: _bloc.allLaunches,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _launchData = snapshot.data;
          return LaunchList(
            launches: _launchData,
            showNextLaunch: true,
          );
        }

        return Center(child: CircularProgressIndicator(),);
      },
    );
  }

  void showLaunchSearch(BuildContext context) {
    showSearch<Launch>(
      context: context,
      delegate: LaunchSearchDelegate(
        launchData: _launchData,
      ),
    );
  }
}