import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/cart/controllers/cart_controller.dart';
import 'package:sixam_mart/features/item/controllers/item_controller.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

class CartCountView extends StatelessWidget {
  final Item item;
  final Widget? child;
  final int? index;

  const CartCountView({
    super.key,
    required this.item,
    this.child,
    this.index = -1,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartController) {
      int cartQty = cartController.cartQuantity(item.id!);
      int cartIndex = cartController.isExistInCart(
        item.id,
        cartController.cartVariant(item.id!),
        false,
        null,
      );

      return cartQty != 0
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 100,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius:
                        BorderRadius.circular(Dimensions.radiusExtraLarge),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      value: cartQty,
                      icon: Icon(Icons.arrow_drop_down,
                          color: Theme.of(context).cardColor),
                      dropdownColor: Theme.of(context).primaryColor,
                      style: robotoMedium.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: Theme.of(context).cardColor,
                      ),
                      isExpanded: true,
                      itemHeight: kMinInteractiveDimension,
                      menuMaxHeight: 200, // This makes dropdown scrollable
                      items: List.generate(
                        (cartController.cartList[cartIndex].stock! > 10
                                ? 10
                                : cartController.cartList[cartIndex].stock!)
                            .toInt(),
                        (i) => DropdownMenuItem(
                          value: i + 1,
                          child: Text((i + 1).toString()),
                        ),
                      ),
                      onChanged: (int? newQty) {
                        if (newQty != null &&
                            newQty !=
                                cartController.cartList[cartIndex].quantity) {
                          cartController.updateCartQuantity(cartIndex, newQty);
                        }
                      },
                    ),
                  ),
                ),
              ),
            )
          : InkWell(
              onTap: () {
                Get.find<ItemController>().itemDirectlyAddToCart(item, context);
              },
              child: child ??
                  Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).cardColor,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          spreadRadius: 1,
                        )
                      ],
                    ),
                    child: Icon(
                      Icons.add,
                      size: 20,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
            );
    });
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sixam_mart/features/cart/controllers/cart_controller.dart';
// import 'package:sixam_mart/features/item/controllers/item_controller.dart';
// import 'package:sixam_mart/features/item/domain/models/item_model.dart';
// import 'package:sixam_mart/util/dimensions.dart';
// import 'package:sixam_mart/util/styles.dart';

// class CartCountView extends StatelessWidget {
//   final Item item;
//   final Widget? child;
//   final int? index;
//   const CartCountView({
//     super.key,
//     required this.item,
//     this.child,
//     this.index = -1,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<CartController>(builder: (cartController) {
//       int cartQty = cartController.cartQuantity(item.id!);
//       int cartIndex = cartController.isExistInCart(
//           item.id, cartController.cartVariant(item.id!), false, null);

//       return cartQty != 0
//           ? Center(
//               child: Container(
//                 width: 100,
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).primaryColor,
//                   borderRadius:
//                       BorderRadius.circular(Dimensions.radiusExtraLarge),
//                 ),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton<int>(
//                     value: cartQty,
//                     icon: Icon(Icons.arrow_drop_down,
//                         color: Theme.of(context).cardColor),
//                     dropdownColor: Theme.of(context).primaryColor,
//                     style: robotoMedium.copyWith(
//                         fontSize: Dimensions.fontSizeSmall,
//                         color: Theme.of(context).cardColor),
//                     items: List.generate(
//                       (cartController.cartList[cartIndex].stock! > 10
//                               ? 10
//                               : cartController
//                                   .cartList[cartIndex].stock!) // min(stock, 10)
//                           .toInt(),
//                       (i) => DropdownMenuItem(
//                         value: i + 1,
//                         child: Text((i + 1).toString()),
//                       ),
//                     ),
//                     onChanged: (int? newQty) {
//                       if (newQty != null &&
//                           newQty !=
//                               cartController.cartList[cartIndex].quantity) {
//                         cartController.updateCartQuantity(cartIndex, newQty);
//                       }
//                     },
//                   ),
//                 ),
//               ),
//             )
//           : InkWell(
//               onTap: () {
//                 Get.find<ItemController>().itemDirectlyAddToCart(item, context);
//               },
//               child: child ??
//                   Container(
//                     height: 25,
//                     width: 25,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Theme.of(context).cardColor,
//                       boxShadow: const [
//                         BoxShadow(
//                             color: Colors.black12,
//                             blurRadius: 5,
//                             spreadRadius: 1)
//                       ],
//                     ),
//                     child: Icon(Icons.add,
//                         size: 20, color: Theme.of(context).primaryColor),
//                   ),
//             );
//     });
//   }
// }
