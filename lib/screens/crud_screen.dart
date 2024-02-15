import 'package:examen_final_garcia/models/models.dart';
import 'package:examen_final_garcia/provider/databases/crud_provider.dart';
import 'package:examen_final_garcia/screens/details_screen.dart';
import 'package:examen_final_garcia/screens/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirebaseCRUDScreen<T extends BaseModel> extends StatelessWidget {
  final T Function(Map<String, dynamic>) fromMap;

  FirebaseCRUDScreen({super.key, required this.fromMap});

  @override
  Widget build(BuildContext context) {
    // Get provider
    final provider = Provider.of<CRUDProvider<T>>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD Screen'),
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
        ],
      ),
      body: ListView.builder(
        itemCount: provider.items.length,
        itemBuilder: (context, index) {
          final item = provider.items[index];
          return ListTile(
            title: Text(item.toString()),
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
