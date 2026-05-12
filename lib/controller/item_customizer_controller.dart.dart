import 'package:fork_mate/controller/countdown_timer_controller.dart';
import 'package:fork_mate/controller/order_details_controller.dart';
import 'package:fork_mate/functions/format_price.dart';
import 'package:fork_mate/view/customer/pages/order_details_page.dart';
import 'package:get/get.dart';
import 'package:fork_mate/controller/cart_controller.dart';
import 'package:fork_mate/functions/confirmation_dialog.dart';
import 'package:fork_mate/models/customer/items_model.dart';
import 'package:fork_mate/services/customer/customer_home_page_services.dart';

class ItemCustomizerController extends GetxController {
  late ItemModel itemModel;

  Future<ItemCustomizerController> create(
    ItemModel orderItemModel, {
    String? remainingTime,
  }) async {
    itemModel = orderItemModel;
    if (remainingTime != null) {
      CountdownController timer = CountdownController(
        timeString: remainingTime,
        tag: itemModel.tag,
      );
      timer.callBackMap[itemModel.tag] = () {
        itemModel.discount = null;
        itemModel.count = 1;
        update(['updated']);
      };
      Get.put<CountdownController>(timer, tag: itemModel.tag);
    }
    //updated
    return this;
  }

  Future<void> rate(int itemId, int rate) async {
    try {
      ItemModel updatedItem = await CustomerHomePageServices.rateItem(
        itemId,
        rate,
      );
      itemModel = updatedItem.clone();
      update(['updated']);
    } catch (e) {
      return;
    }
  }

  void addPreference({
    required int id,
    required String preference,
    required double changes,
    required String type,
  }) {
    itemModel.addPreference(id, type, preference, changes);
    update();
  }

  void removePreference({required int id, required String preference}) {
    itemModel.removePreference(id, preference);
    update();
  }

  void addItemToOrder() async {
    bool add = await Get.find<CartController>().addItemToTheCurrentOrder(
      itemModel,
    );
    if (add) {
      clear();
    }
  }

  void increment() {
    itemModel.increment();
    update();
  }

  void decrement() {
    itemModel.decrement();
    update();
  }

  bool checkFirst() {
    if (itemModel.count > 0) {
      return true;
    }
    return false;
  }

  void clear() {
    itemModel = itemModel.clone();
    update();
  }

  void directOrder() async {
    bool confirm = await confirmationDialog(
      message: 'do you want to order  @count   @name  for  @totalPrice ?'
          .trParams({
            'count': itemModel.count.toString(),
            'name': itemModel.name,
            'totalPrice': formatPrice(itemModel.getTotalPrice()),
          }),
    );
    if (confirm) {
      //initial a new order
      CartController cart = Get.find<CartController>();
      cart.createNewOrder();
      cart.cart[cart.currentOrder]?.addItem(itemModel);
      Get.putAsync(
        () => OrderDetailsController().create(
          cart.cart[cart.currentOrder]!,
          cart.currentOrder!,
        ),
      );
      Get.to(() => OrderDetailsPage())?.then((_) {
        //remove the initialized order if the order details are not complete
        cart.removeOrderFromCart(cart.currentOrder);
      });
    }
  }

  @override
  void onClose() {
    Get.delete<CountdownController>(tag: itemModel.tag);
    super.onClose();
  }
}
