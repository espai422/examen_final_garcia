import 'package:examen_final_garcia/models/models.dart';
import 'package:examen_final_garcia/provider/databases/crud_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// EditCRUDScreen is a screen to edit the item of a CRUD
/// This screen will show the details of the selected item in the provider
/// is a generic screen for any model that extends BaseModel
class EditCRUDScreen<T extends BaseModel> extends StatelessWidget {
  const EditCRUDScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get provider
    final provider = Provider.of<CRUDProvider<T>>(context, listen: false);
    final item = provider.selectedItem;

    /// Convert the item to a map,
    final map = item!.toMap();

    final Map<String, TextEditingController> textControllers = {
      for (var key in map.keys)
        key: TextEditingController(text: map[key].toString())
    };

    /// create a map of text controllers to edit the item using same ke
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD Detail Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final updateMap = _controllerToMap(textControllers);
              if (item.id == null) {
                provider.createFromMap(updateMap);
              } else {
                provider.updateFromMap(updateMap, item.id!);
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: textControllers.keys.length,
        itemBuilder: (context, index) {
          final key = textControllers.keys.elementAt(index);
          return ListTile(
            title: Text(key),
            subtitle: TextField(
              controller: textControllers[key],
            ),
          );
        },
      ),
    );
  }

  Map<String, dynamic> _controllerToMap(
      Map<String, TextEditingController> controllers) {
    Map<String, dynamic> map = {};
    for (var key in controllers.keys) {
      map[key] = controllers[key]!.text;
    }
    return map;
  }
}
