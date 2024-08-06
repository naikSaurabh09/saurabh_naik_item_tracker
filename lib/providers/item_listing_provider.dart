import 'package:flutter/material.dart';
import 'package:saurabh_naik_item_tracker/model/item_details_model.dart';

class ItemsListingProvider extends ChangeNotifier {
  final List<ItemDetails> _itemsList = [];

  List get itemsList => _itemsList;

  void addItem (ItemDetails newItem) {
    _itemsList.insert(0, newItem);
    notifyListeners();
  }

  void deleteItem (int itemIndex) {
    _itemsList.removeAt(itemIndex);
    notifyListeners();
  }

  void editItem (int itemIndex, ItemDetails newItem) {
    _itemsList.removeAt(itemIndex);
    _itemsList.insert(itemIndex, newItem);
    notifyListeners();
  }

}