import 'package:fork_mate/models/customer/items_model.dart';

List<ItemModel> allItems = [];

void getAllItems(Map<int, Map<int, List<ItemModel>?>> storedItem) {
  allItems.clear();
  for (final outerEntry in storedItem.values) {
    for (final innerList in outerEntry.values) {
      if (innerList != null) {
        allItems.addAll(innerList);
      }
    }
  }
}

List<ItemModel> localSearch(String query) {
  final lowerQuery = query.toLowerCase();
  final foundItem = allItems
      .where((item) => item.name.toLowerCase().contains(lowerQuery))
      .toList();
  return foundItem;
}
