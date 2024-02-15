import 'package:examen_final_garcia/models/models.dart';
import 'package:examen_final_garcia/provider/databases/rtdb.dart';
import 'package:flutter/material.dart';

/// A provider for Firebase operations.
///
/// This class provides methods for creating, reading, updating, and deleting
/// items in Firebase. It also notifies its listeners when changes occur.
class CRUDProvider<T extends BaseModel> extends ChangeNotifier {
  final BaseCRUD<T> provider;

  List<T> _items = [];

  T? _selectedItem;

  /// Gets the currently selected item.
  T? get selectedItem => _selectedItem;

  /// Sets the currently selected item and notifies listeners.
  set selectedItem(T? value) {
    _selectedItem = value;
    notifyListeners();
  }

  /// Gets the list of items.
  List<T> get items => _items;

  /// Creates a new FirebaseProvider and loads the initial list of items.
  CRUDProvider(this.provider) {
    reloadItems();
  }

  /// Reloads the list of items from Firebase and notifies listeners.
  Future<void> reloadItems() async {
    _items = await provider.read();
    notifyListeners();
  }

  /// Adds an item to Firebase and reloads the list of items.
  Future<void> addItem(T item) async {
    await provider.create(item);
    await reloadItems();
  }

  /// Updates an item in Firebase and reloads the list of items.
  Future<void> updateItem(T item) async {
    await provider.update(item);
    await reloadItems();
  }

  /// Deletes an item from Firebase and reloads the list of items.
  Future<void> deleteItem(T item) async {
    await provider.delete(item);
    await reloadItems();
  }

  /// Creates an item from a map and adds it to Firebase.
  Future<void> createFromMap(Map<String, dynamic> map) async {
    await provider.createFromMap(map);
    await reloadItems();
  }

  /// Updates an item from a map in Firebase.
  Future<void> updateFromMap(Map<String, dynamic> map, String id) async {
    await provider.updateFromMap(map, id);
    await reloadItems();
  }
}
