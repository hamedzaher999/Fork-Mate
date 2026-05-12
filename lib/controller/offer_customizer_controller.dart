import 'package:fork_mate/controller/cart_controller.dart';
import 'package:fork_mate/controller/countdown_timer_controller.dart';
import 'package:fork_mate/controller/order_details_controller.dart';
import 'package:fork_mate/functions/confirmation_dialog.dart';
import 'package:fork_mate/functions/create_snack_bar.dart';
import 'package:fork_mate/functions/format_price.dart';
import 'package:fork_mate/models/customer/offer_model.dart';
import 'package:fork_mate/view/customer/pages/order_details_page.dart';
import 'package:get/get.dart';

class OfferCustomizerController extends GetxController {
  late OfferModel offerModel;
  late String remainingTime;
  Future<OfferCustomizerController> create(
    OfferModel orderOfferModel, {
    required String remainingTime,
  }) async {
    offerModel = orderOfferModel;
    this.remainingTime = remainingTime;
    return this;
  }

  @override
  void onInit() {
    final timer = CountdownController(
      timeString: remainingTime,
      tag: offerModel.tag,
    );
    timer.callBackMap[offerModel.tag] = () {
      Get.back();
      // TODO translate
      createSnackBar(message: 'offer time end');
    };
    Get.put<CountdownController>(timer, tag: timer.tag);
    super.onInit();
  }

  void increment() {
    offerModel.increment();
    update();
  }

  void decrement() {
    offerModel.decrement();
    update();
  }

  void clear() {
    offerModel = offerModel.clone();
    update();
  }

  void addItemToOrder() async {
    bool add = await Get.find<CartController>().addOfferToTheCurrentOrder(
      offerModel,
    );
    if (add) {
      clear();
    }
  }

  void directOrder() async {
    bool confirm = await confirmationDialog(
      message: 'do you want to order  @count   @name  for  @totalPrice  S.P ?'
          .trParams({
            'count': offerModel.count.toString(),
            'name': offerModel.name,
            'totalPrice': formatPrice(offerModel.getTotalPrice()),
          }),
    );
    if (confirm) {
      //initial a new order
      CartController cart = Get.find<CartController>();
      cart.createNewOrder();
      cart.cart[cart.currentOrder]?.addOffer(offerModel);
      Get.putAsync(
        () => OrderDetailsController().create(
          cart.cart[cart.currentOrder]!,
          cart.currentOrder!,
        ),
      );
      Get.to(() => OrderDetailsPage())?.then((_) {
        //remove the initialized order if the order details are not complete
        cart.removeOrderFromCart(cart.currentOrder!);
      });
    }
  }

  @override
  void onClose() async {
    if (Get.isRegistered<CountdownController>(tag: offerModel.tag)) {
      await Get.delete<CountdownController>(tag: offerModel.tag);
    }
    super.onClose();
  }
}
