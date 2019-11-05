import 'package:flutter/material.dart';
import 'package:spacex_guide/api/models/launch.dart';
import 'package:spacex_guide/api/spacex_api.dart';
import 'package:spacex_guide/widgets/drawer.dart';

import 'arguments/launch_arguments.dart';

class AllLaunchesScreen extends StatefulWidget {
  @override
  _AllLaunchesScreenState createState() => _AllLaunchesScreenState();
}

class _AllLaunchesScreenState extends State<AllLaunchesScreen> {
  List<Launch> _launches = List();

  @override
  void initState() {
    super.initState();
    fetchLaunches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Launches'),
        backgroundColor: Colors.black,
      ),
      drawer: MyDrawer(),
      body: Container(
        color: Colors.black87,
        child: _launches.isEmpty ? Center(child: CircularProgressIndicator(),) : ListView.builder(
          itemCount: _launches.length,
          itemBuilder: (context, i) {
            return ListTile(
              title: Text(
                _launches[i].missionName,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                _launches[i].formattedLaunchDate(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              leading: CircleAvatar(
                child: Text(
                  '${_launches[i].flightNumber}',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.white24,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white30,
                size: 18,
              ),
              onTap: () {
                // TODO: Distinguish between past and upcoming

                Navigator.pushNamed(
                  context, 
                  '/past_launch',
                  arguments: LaunchScreenArguments(_launches[i]),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void fetchLaunches() async {
    final api = SpaceXAPI();
    _launches = await api.getAllLaunches();

    setState(() {
    });
  }
}