import 'package:examen_final_garcia/provider/databases/crud_provider.dart';
import 'package:examen_final_garcia/provider/provider.dart';
import 'package:examen_final_garcia/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser =
        Provider.of<CurrentUserProvider>(context, listen: false).currentUser;
    final mapsProvider = Provider.of<MapsMarks>(context, listen: true);

    return BaseScreen(
      title: 'Home Screen',
      child: Column(
        children: [
          Center(
            child: Text(
              '${currentUser?.username} is logged in',
              style: TextStyle(fontSize: 24),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                authMethod.signOut(context);
              },
              child: Text('Logout')),
          ScanButton(onScan: (result) {
            print(result);
          }, onCancel: () {
            print('canceled');
          }),
          Text(mapsProvider.markers.length.toString()),
        ],
      ),
    );
  }
}
