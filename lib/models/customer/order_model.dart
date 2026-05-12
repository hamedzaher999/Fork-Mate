import 'package:fork_mate/functions/confirmation_dialog.dart';
import 'package:fork_mate/functions/create_snack_bar.dart';
import 'package:fork_mate/functions/get_available_key.dart';
import 'package:fork_mate/models/customer/customer_gift_model.dart';
import 'package:fork_mate/models/customer/items_model.dart';
import 'package:fork_mate/models/customer/offer_model.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class OrderModel {
  Map<int, Map<int, ItemModel>> items = {};
  Map<int, OfferModel> offers = {};
  Map<int, CustomerGiftModel> gifts = {};

  bool isGiftsOnly() {
    return offers.isEmpty && items.isEmpty;
  }

  Map orderDTO() {
    Map<String, List<Map<String, dynamic>>> order = {
      'items': [],
      'offers': [],
      'gifts': [],
    };
    for (Map<int, ItemModel> itemsMap in items.values) {
      for (ItemModel item in itemsMap.values) {
        order['items']?.add(item.itemDto());
      }
    }
    for (OfferModel offerMap in offers.values) {
      order['offers']?.add(offerMap.offerDTO());
    }
    for (CustomerGiftModel gift in gifts.values) {
      order['gifts']?.add({'id': gift.id, 'giftNumber': gift.giftNumber});
    }
    return order;
  }

  Future<bool> addItem(ItemModel orderItemModel) async {
    items.putIfAbsent(orderItemModel.id, () => {});
    for (var item in items[orderItemModel.id]!.values) {
      if (item.toJson() == orderItemModel.toJson()) {
        bool confirm = await confirmationDialog(
          message:
              'this item is already in your order, do you want to add @count more ?'
                  .trParams({'count': orderItemModel.count.toString()}),
        );
        if (confirm) {
          createSnackBar(
            message: '@count item have been added to the previous order'
                .trParams({'count': orderItemModel.count.toString()}),
          );
          item.count += orderItemModel.count;

          return true;
        } else {
          return false;
        }
      }
    }
    int key = getNextAvailableKey(items[orderItemModel.id]!.keys.toList());
    items[orderItemModel.id]![key] = orderItemModel;
    createSnackBar(message: 'the item has been added to the order');
    return true;
  }

  Future<bool> addOffer(OfferModel offerModel) async {
    if (offers.keys.contains(offerModel.id)) {
      bool confirm = await confirmationDialog(
        message:
            'this offer is already in your order, do you want to add @count more ?'
                .trParams({'count': offerModel.count.toString()}),
      );
      if (confirm) {
        bool increment = offers[offerModel.id]!.increment(
          quantity: offerModel.count,
        );
        if (increment) {
          createSnackBar(
            message: '@count offer have been added to the previous order'
                .trParams({'count': offerModel.count.toString()}),
          );
          return true;
        }
        {
          return false;
        }
      } else {
        return false;
      }
    } else {
      offers.putIfAbsent(offerModel.id, () => offerModel);

      createSnackBar(message: 'the offer has been added to the order');
      return true;
    }
  }

  void addGift(CustomerGiftModel giftModel) {
    gifts.putIfAbsent(giftModel.id, () => giftModel);
    createSnackBar(message: 'the gift has been added to the order');
  }

  void removeGift(int giftId) {
    gifts.remove(giftId);
  }

  bool removeItem({required int itemId, required int itemKey}) {
    if (items[itemId] != null) {
      items[itemId]!.remove(itemKey);
      if (items[itemId]!.isEmpty) {
        items.remove(itemId);
      }
    }
    return items.isEmpty;
  }

  void removeOffer(int id) {
    offers.remove(id);
  }

  double offersPrice() {
    double total = 0;
    for (OfferModel offer in offers.values) {
      total += offer.totalPrice();
    }
    return total;
  }

  double itemsPrice() {
    double total = 0;
    for (Map<int, ItemModel> subOrder in items.values) {
      for (ItemModel item in subOrder.values) {
        total += item.getTotalPrice();
      }
    }
    return total;
  }

  double orderPrice() {
    return itemsPrice() + offersPrice();
  }

  int itemCount() {
    int itemCount = 0;
    for (var items in items.values) {
      for (var item in items.values) {
        itemCount += item.count;
      }
    }
    for (var offer in offers.values) {
      itemCount += offer.count;
    }
    itemCount += gifts.length;
    return itemCount;
  }

  // Fix duplicate orders
  bool fixOrder() {
    for (var items in items.values) {
      final Map<String, List<int>> duplicates = {};
      items.forEach((key, value) {
        final jsonString = value.toJson().toString();
        duplicates.putIfAbsent(jsonString, () => []).add(key);
      });

      for (var keys in duplicates.values) {
        if (keys.length > 1) {
          for (int i = 1; i < keys.length; i++) {
            items[keys.first]!.count += items[keys[i]]!.count;
            items.remove(keys[i]);
          }
        }
      }
    }
    return items.isEmpty && offers.isEmpty && gifts.isEmpty;
  }
}
