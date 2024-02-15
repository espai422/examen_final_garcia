import 'package:examen_final_garcia/models/arbre.dart';
import 'package:examen_final_garcia/models/models.dart';
import 'package:examen_final_garcia/provider/auth/auth.dart';
import 'package:examen_final_garcia/provider/auth/current_user_provider.dart';
import 'package:examen_final_garcia/provider/databases/crud_provider.dart';
import 'package:examen_final_garcia/screens/details_screen.dart';
import 'package:examen_final_garcia/screens/edit_screen.dart';
import 'package:examen_final_garcia/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// In this case this screen is now the home screen but it is a generic screen
/// that can be used for any model

/// Firebase CRUD screen to show the list of items and the CRUD operations
/// It uses the provider to get the items and the selected item
/// It also uses the provider to delete the item
/// It also uses the provider to reload the items
/// It also uses the provider to set the selected item

class FirebaseCRUDScreen<T extends BaseModel> extends StatelessWidget {
  final T Function(Map<String, dynamic>) fromMap;

  FirebaseCRUDScreen({super.key, required this.fromMap});

  @override
  Widget build(BuildContext context) {
    // Get provider
    final provider = Provider.of<CRUDProvider<T>>(context, listen: true);
    final currentUser =
        Provider.of<CurrentUserProvider>(context, listen: false).currentUser;

    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              provider.reloadItems();
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              provider.selectedItem = fromMap({});
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditCRUDScreen<T>()),
              );
            },
          ),
          ElevatedButton(
              onPressed: () {
                authMethod.signOut(context);
              },
              child: Text('Logout')),
        ],
      ),
      body: ListView.builder(
        itemCount: provider.items.length,
        itemBuilder: (context, index) {
          final item = provider.items[index];
          var title = item.toString();
          var subtitle = '';
          if (T == Arbre) {
            title = (item as Arbre).nom!;
            subtitle = (item as Arbre).varietat!;
          }
          return ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
            onTap: () {
              provider.selectedItem = item;

              // Go to corresponding detail screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailsScreen<T>()),
              );
            },
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    provider.selectedItem = item;

                    // Go to corresponding edit screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditCRUDScreen<T>()),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    provider.deleteItem(item);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
