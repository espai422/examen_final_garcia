import 'package:examen_final_garcia/models/models.dart';
import 'package:examen_final_garcia/provider/databases/crud_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:examen_final_garcia/utils/fields_exceptions.dart';

/// Details screen for the CRUD
/// This screen will show the details of the selected item in the provider
/// is a generic screen for any model that extends BaseModel
class DetailsScreen<T extends BaseModel> extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get provider
    final provider = Provider.of<CRUDProvider<T>>(context, listen: false);
    final item = provider.selectedItem;

    /// Convert the item to a map,
    final map = item!.toMap();

    /// create a map of text controllers to edit the item using same ke
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD Detail Screen'),
      ),
      body: ListView.builder(
        itemCount: map.keys.length,
        itemBuilder: (context, index) {
          final key = map.keys.elementAt(index);
          final exception = fieldsExceptions[T]?[key];
          Widget subtitle = Text(map[key]!);
          if (exception != null) {
            subtitle = exception(map[key]!);
          }

          return ListTile(
            title: Text(key),
            subtitle: subtitle,
          );
        },
      ),
    );
  }
}
