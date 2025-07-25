import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/common/widgets/custom_asset_image_widget.dart';
import 'package:sixam_mart/common/widgets/custom_ink_well.dart';
import 'package:sixam_mart/common/widgets/hover/text_hover.dart';
import 'package:sixam_mart/features/cart/controllers/cart_controller.dart';
import 'package:sixam_mart/features/item/controllers/item_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/add_favourite_view.dart';
import 'package:sixam_mart/common/widgets/cart_count_view.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/discount_tag.dart';
import 'package:sixam_mart/common/widgets/hover/on_hover.dart';
import 'package:sixam_mart/common/widgets/not_available_widget.dart';
import 'package:sixam_mart/common/widgets/organic_tag.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final bool isPopularItem;
  final bool isFood;
  final bool isShop;
  final bool isPopularItemCart;
  final int? index;
  const ItemCard(
      {super.key,
      required this.item,
      this.isPopularItem = false,
      required this.isFood,
      required this.isShop,
      this.isPopularItemCart = false,
      this.index});

  @override
  Widget build(BuildContext context) {
    double? discount =
        item.storeDiscount == 0 ? item.discount : item.storeDiscount;
    String? discountType =
        item.storeDiscount == 0 ? item.discountType : 'percent';

    return Builder(builder: (context) {
      return StreamBuilder<Object>(
          stream: null,
          builder: (context, snapshot) {
            return OnHover(
              isItem: true,
              child: Stack(children: [
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                    color: Theme.of(context).cardColor,
                  ),
                  child: CustomInkWell(
                    onTap: () => Get.find<ItemController>()
                        .navigateToItemPage(item, context),
                    radius: Dimensions.radiusLarge,
                    child: TextHover(builder: (isHovered) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Stack(children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: isPopularItem
                                          ? Dimensions.paddingSizeExtraSmall
                                          : 0,
                                      left: isPopularItem
                                          ? Dimensions.paddingSizeExtraSmall
                                          : 0,
                                      right: isPopularItem
                                          ? Dimensions.paddingSizeExtraSmall
                                          : 0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(
                                          Dimensions.radiusLarge),
                                      topRight: const Radius.circular(
                                          Dimensions.radiusLarge),
                                      bottomLeft: Radius.circular(isPopularItem
                                          ? Dimensions.radiusLarge
                                          : 0),
                                      bottomRight: Radius.circular(isPopularItem
                                          ? Dimensions.radiusLarge
                                          : 0),
                                    ),
                                    child: CustomImage(
                                      isHovered: isHovered,
                                      placeholder: Images.placeholder,
                                      image: '${item.imageFullUrl}',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                                ),
                                AddFavouriteView(
                                  item: item,
                                ),
                                item.isStoreHalalActive! && item.isHalalItem!
                                    ? const Positioned(
                                        top: 40,
                                        right: 15,
                                        child: CustomAssetImageWidget(
                                          Images.halalTag,
                                          height: 20,
                                          width: 20,
                                        ),
                                      )
                                    : const SizedBox(),
                                DiscountTag(
                                  discount: discount,
                                  discountType: discountType,
                                  freeDelivery: false,
                                ),
                                OrganicTag(item: item, placeInImage: false),
                                (item.stock != null && item.stock! < 0)
                                    ? Positioned(
                                        bottom: 10,
                                        left: 0,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal:
                                                  Dimensions.paddingSizeSmall,
                                              vertical: Dimensions
                                                  .paddingSizeExtraSmall),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .primaryColor
                                                .withValues(alpha: 0.5),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topRight: Radius.circular(
                                                  Dimensions.radiusLarge),
                                              bottomRight: Radius.circular(
                                                  Dimensions.radiusLarge),
                                            ),
                                          ),
                                          child: Text('out_of_stock'.tr,
                                              style: robotoRegular.copyWith(
                                                  color: Theme.of(context)
                                                      .cardColor,
                                                  fontSize: Dimensions
                                                      .fontSizeSmall)),
                                        ),
                                      )
                                    : const SizedBox(),
                                isShop
                                    ? const SizedBox()
                                    : Positioned(
                                        bottom: 10,
                                        right: 20,
                                        child: CartCountView(
                                          item: item,
                                          index: index,
                                        ),
                                      ),
                                Get.find<ItemController>().isAvailable(item)
                                    ? const SizedBox()
                                    : NotAvailableWidget(
                                        radius: Dimensions.radiusLarge,
                                        isAllSideRound: isPopularItem),
                              ]),
                            ),
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: Dimensions.paddingSizeSmall,
                                    right: isShop
                                        ? 0
                                        : Dimensions.paddingSizeSmall,
                                    top: Dimensions.paddingSizeSmall,
                                    bottom: isShop
                                        ? 0
                                        : Dimensions.paddingSizeSmall),
                                child:
                                    Stack(clipBehavior: Clip.none, children: [
                                  Align(
                                    alignment: isPopularItem
                                        ? Alignment.center
                                        : Alignment.centerLeft,
                                    child: Column(
                                        crossAxisAlignment: isPopularItem
                                            ? CrossAxisAlignment.center
                                            : CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          (isFood || isShop)
                                              ? Text(item.storeName ?? '',
                                                  style: robotoRegular.copyWith(
                                                      color: Theme.of(context)
                                                          .disabledColor))
                                              : Text(item.name ?? '',
                                                  style: robotoBold,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis),

                                          (isFood || isShop)
                                              ? Flexible(
                                                  child: Text(
                                                    item.name ?? '',
                                                    style: robotoBold,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                )
                                              : item.ratingCount! > 0
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          isPopularItem
                                                              ? MainAxisAlignment
                                                                  .center
                                                              : MainAxisAlignment
                                                                  .start,
                                                      children: [
                                                          Icon(Icons.star,
                                                              size: 14,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                          const SizedBox(
                                                              width: Dimensions
                                                                  .paddingSizeExtraSmall),
                                                          Text(
                                                              item.avgRating!
                                                                  .toStringAsFixed(
                                                                      1),
                                                              style: robotoRegular
                                                                  .copyWith(
                                                                      fontSize:
                                                                          Dimensions
                                                                              .fontSizeSmall)),
                                                          const SizedBox(
                                                              width: Dimensions
                                                                  .paddingSizeExtraSmall),
                                                          Text(
                                                              "(${item.ratingCount})",
                                                              style: robotoRegular.copyWith(
                                                                  fontSize:
                                                                      Dimensions
                                                                          .fontSizeSmall,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .disabledColor)),
                                                        ])
                                                  : const SizedBox(),

                                          // showUnitOrRattings(context);
                                          (isFood || isShop)
                                              ? item.ratingCount! > 0
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          isPopularItem
                                                              ? MainAxisAlignment
                                                                  .center
                                                              : MainAxisAlignment
                                                                  .start,
                                                      children: [
                                                          Icon(Icons.star,
                                                              size: 14,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                          const SizedBox(
                                                              width: Dimensions
                                                                  .paddingSizeExtraSmall),
                                                          Text(
                                                              item.avgRating!
                                                                  .toStringAsFixed(
                                                                      1),
                                                              style: robotoRegular
                                                                  .copyWith(
                                                                      fontSize:
                                                                          Dimensions
                                                                              .fontSizeSmall)),
                                                          const SizedBox(
                                                              width: Dimensions
                                                                  .paddingSizeExtraSmall),
                                                          Text(
                                                              "(${item.ratingCount})",
                                                              style: robotoRegular.copyWith(
                                                                  fontSize:
                                                                      Dimensions
                                                                          .fontSizeSmall,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .disabledColor)),
                                                        ])
                                                  : const SizedBox()
                                              : (Get.find<SplashController>()
                                                          .configModel!
                                                          .moduleConfig!
                                                          .module!
                                                          .unit! &&
                                                      item.unitType != null)
                                                  ? Text(
                                                      '(${item.unitType ?? ''})',
                                                      style: robotoRegular.copyWith(
                                                          fontSize: Dimensions
                                                              .fontSizeExtraSmall,
                                                          color:
                                                              Theme.of(context)
                                                                  .hintColor),
                                                    )
                                                  : const SizedBox(),
                                          discount != null && discount > 0
                                              ? Text(
                                                  PriceConverter.convertPrice(
                                                      Get.find<ItemController>()
                                                          .getStartingPrice(
                                                              item)),
                                                  style: robotoMedium.copyWith(
                                                    fontSize: Dimensions
                                                        .fontSizeExtraSmall,
                                                    color: Theme.of(context)
                                                        .disabledColor,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                  ),
                                                  textDirection:
                                                      TextDirection.ltr,
                                                )
                                              : const SizedBox(),
                                          // SizedBox(height: item.discount != null && item.discount! > 0 ? Dimensions.paddingSizeExtraSmall : 0),
                                          Text(
                                            PriceConverter.convertPrice(
                                              Get.find<ItemController>()
                                                  .getStartingPrice(item),
                                              discount: discount,
                                              discountType: discountType,
                                            ),
                                            textDirection: TextDirection.ltr,
                                            style: robotoMedium,
                                          ),
                                          const SizedBox(
                                              height: Dimensions
                                                  .paddingSizeExtraSmall),
                                        ]),
                                  ),
                                  // isShop
                                  //     ? Positioned(
                                  //         bottom: 0,
                                  //         right: 0,
                                  //         child: GetBuilder<ItemController>(
                                  //             builder: (itemController) {
                                  //           final cartIndex = itemController.cartIndex;
                                  //           final cartController =
                                  //               Get.find<CartController>();
                                  //           final int quantity = cartIndex != -1
                                  //               ? cartController
                                  //                       .cartList[cartIndex].quantity ??
                                  //                   1
                                  //               : itemController.quantity ?? 1;

                                  //           final int stock = cartIndex != -1
                                  //               ? cartController
                                  //                       .cartList[cartIndex].stock ??
                                  //                   10
                                  //               : item.stock ?? 10;

                                  //           return CartCountView(
                                  //             item: item,
                                  //             index: index,
                                  //             child: Container(
                                  //               height: 35,
                                  //               padding: const EdgeInsets.symmetric(
                                  //                   horizontal: 8),
                                  //               decoration: BoxDecoration(
                                  //                 color: Theme.of(context).primaryColor,
                                  //                 borderRadius: const BorderRadius.only(
                                  //                   topLeft: Radius.circular(
                                  //                       Dimensions.radiusLarge),
                                  //                   bottomRight: Radius.circular(
                                  //                       Dimensions.radiusLarge),
                                  //                 ),
                                  //               ),
                                  //               child: Center(
                                  //                 child: DropdownButtonHideUnderline(
                                  //                   child: DropdownButton<int>(
                                  //                     dropdownColor: Theme.of(context)
                                  //                         .primaryColor,
                                  //                     value: quantity,
                                  //                     icon: const Icon(
                                  //                         Icons.keyboard_arrow_down,
                                  //                         color: Colors.white,
                                  //                         size: 18),
                                  //                     style: robotoMedium.copyWith(
                                  //                         fontSize: 14,
                                  //                         color: Colors.white),
                                  //                     onChanged: cartController
                                  //                             .isLoading
                                  //                         ? null
                                  //                         : (int? newValue) {
                                  //                             if (newValue != null) {
                                  //                               if (cartIndex != -1) {
                                  //                                 cartController
                                  //                                     .updateQuantity(
                                  //                                         cartIndex,
                                  //                                         newValue);
                                  //                               } else {
                                  //                                 itemController
                                  //                                     .updateQuantity(
                                  //                                         newValue);
                                  //                               }
                                  //                             }
                                  //                           },
                                  //                     items: List.generate(
                                  //                       stock > 10 ? 10 : stock,
                                  //                       (index) =>
                                  //                           DropdownMenuItem<int>(
                                  //                         value: index + 1,
                                  //                         child: Text(
                                  //                           '${index + 1}',
                                  //                           style: const TextStyle(
                                  //                               color: Colors.white),
                                  //                         ),
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           );
                                  //         }),
                                  //       )
                                  //     : const SizedBox(),

                                  isShop
                                      ? Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: CartCountView(
                                            item: item,
                                            index: index,
                                            child: Container(
                                              height: 35,
                                              width: 38,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(
                                                      Dimensions.radiusLarge),
                                                  bottomRight: Radius.circular(
                                                      Dimensions.radiusLarge),
                                                ),
                                              ),
                                              child: Icon(
                                                  isPopularItemCart
                                                      ? Icons.add_shopping_cart
                                                      : Icons.add,
                                                  color: Theme.of(context)
                                                      .cardColor,
                                                  size: 20),
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                  //     ? GetBuilder<ItemController>(
                                  //         builder: (itemController) {
                                  //           return Positioned(
                                  //             bottom: 0,
                                  //             right: 0,
                                  //             child: GetBuilder<CartController>(
                                  //               builder: (cartController) {
                                  //                 // int stock = itemController.stock ?? 10; // Fallback if null
                                  //                 int stock =
                                  //                     0; // Fallback if null

                                  //                 return Row(
                                  //                   children: [
                                  //                     Text(
                                  //                       'quantity'.tr,
                                  //                       style: robotoMedium
                                  //                           .copyWith(
                                  //                         fontSize: Dimensions
                                  //                             .fontSizeLarge,
                                  //                       ),
                                  //                     ),
                                  //                     const Expanded(
                                  //                         child: SizedBox()),
                                  //                     Container(
                                  //                       padding:
                                  //                           const EdgeInsets
                                  //                               .symmetric(
                                  //                               horizontal: 12),
                                  //                       decoration:
                                  //                           BoxDecoration(
                                  //                         color: Theme.of(
                                  //                                 context)
                                  //                             .disabledColor,
                                  //                         borderRadius:
                                  //                             BorderRadius
                                  //                                 .circular(5),
                                  //                       ),
                                  //                       child:
                                  //                           DropdownButtonHideUnderline(
                                  //                         child: DropdownButton<
                                  //                             int>(
                                  //                           value: itemController
                                  //                                       .cartIndex !=
                                  //                                   -1
                                  //                               ? cartController
                                  //                                   .cartList[
                                  //                                       itemController
                                  //                                           .cartIndex]
                                  //                                   .quantity
                                  //                               : itemController
                                  //                                   .quantity,
                                  //                           icon: const Icon(Icons
                                  //                               .keyboard_arrow_down),
                                  //                           style: robotoMedium
                                  //                               .copyWith(
                                  //                             fontSize: Dimensions
                                  //                                 .fontSizeExtraLarge,
                                  //                             color: Colors.red,
                                  //                           ),
                                  //                           onChanged:
                                  //                               cartController
                                  //                                       .isLoading
                                  //                                   ? null
                                  //                                   : (int?
                                  //                                       newValue) {
                                  //                                       if (newValue !=
                                  //                                           null) {
                                  //                                         if (itemController.cartIndex !=
                                  //                                             -1) {
                                  //                                           cartController.updateQuantity(
                                  //                                             itemController.cartIndex,
                                  //                                             newValue,
                                  //                                           );
                                  //                                         } else {
                                  //                                           itemController.updateQuantity(newValue);
                                  //                                         }
                                  //                                       }
                                  //                                     },
                                  //                           items:
                                  //                               List.generate(
                                  //                             stock > 10
                                  //                                 ? 10
                                  //                                 : stock,
                                  //                             (index) =>
                                  //                                 DropdownMenuItem<
                                  //                                     int>(
                                  //                               value:
                                  //                                   index + 1,
                                  //                               child: Text(
                                  //                                   '${index + 1}'),
                                  //                             ),
                                  //                           ),
                                  //                         ),
                                  //                       ),
                                  //                     ),
                                  //                   ],
                                  //                 );
                                  //               },
                                  //             ),
                                  //           );
                                  //         },
                                  //       )
                                  //     : const SizedBox(),
                                ]),
                              ),
                            ),
                          ]);
                    }),
                  ),
                ),
              ]),
            );
          });
    });
  }

  // Widget? showUnitOrRattings(BuildContext context) {
  //   if(isFood || isShop) {
  //     if(item.ratingCount! > 0) {
  //       return Row(mainAxisAlignment: isPopularItem ? MainAxisAlignment.center : MainAxisAlignment.start, children: [
  //         Icon(Icons.star, size: 14, color: Theme.of(context).primaryColor),
  //         const SizedBox(width: Dimensions.paddingSizeExtraSmall),
  //
  //         Text(item.avgRating!.toStringAsFixed(1), style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
  //         const SizedBox(width: Dimensions.paddingSizeExtraSmall),
  //
  //         Text("(${item.ratingCount})", style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor)),
  //
  //       ]);
  //     }
  //   } else if(Get.find<SplashController>().configModel!.moduleConfig!.module!.unit! && item.unitType != null) {
  //     return Text(
  //       '(${ item.unitType ?? ''})',
  //       style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).hintColor),
  //     );
  //   }
  // }
}
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ItemCard extends StatefulWidget {
//   final Item item;
//   final bool isPopularItem;
//   final bool isFood;
//   final bool isShop;
//   final bool isPopularItemCart;
//   final int? index;

//   const ItemCard({
//     super.key,
//     required this.item,
//     this.isPopularItem = false,
//     required this.isFood,
//     required this.isShop,
//     this.isPopularItemCart = false,
//     this.index,
//   });

//   @override
//   State<ItemCard> createState() => _ItemCardState();
// }

// class _ItemCardState extends State<ItemCard> {
//   String? userType;
//   double? pricePerUnit;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserType();
//   }

//   Future<void> _loadUserType() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     userType = prefs.getString("usertype");

//     setState(() {
//       if (userType == 'Single User') {
//         pricePerUnit = widget.item.singleUserPrice;
//       } else if (userType == 'Distributor') {
//         pricePerUnit = widget.item.distributorPrice;
//       } else if (userType == 'Superstockiest') {
//         pricePerUnit = widget.item.superstorePrice;
//       } else if (userType == 'Dealer') {
//         pricePerUnit = widget.item.dealerPrice;
//       } else if (userType == 'Retailer') {
//         pricePerUnit = widget.item.retailerPrice;
//       } else {
//         pricePerUnit = widget.item.price; // fallback
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double? discount = widget.item.storeDiscount == 0
//         ? widget.item.discount
//         : widget.item.storeDiscount;
//     String? discountType =
//         widget.item.storeDiscount == 0 ? widget.item.discountType : 'percent';

//     return OnHover(
//       isItem: true,
//       child: Stack(children: [
//         Container(
//           width: 200,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
//             color: Theme.of(context).cardColor,
//           ),
//           child: CustomInkWell(
//             onTap: () => Get.find<ItemController>()
//                 .navigateToItemPage(widget.item, context),
//             radius: Dimensions.radiusLarge,
//             child: TextHover(builder: (isHovered) {
//               return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Image section
//                     Expanded(
//                       flex: 5,
//                       child: Stack(children: [
//                         Padding(
//                           padding: EdgeInsets.only(
//                             top: widget.isPopularItem
//                                 ? Dimensions.paddingSizeExtraSmall
//                                 : 0,
//                             left: widget.isPopularItem
//                                 ? Dimensions.paddingSizeExtraSmall
//                                 : 0,
//                             right: widget.isPopularItem
//                                 ? Dimensions.paddingSizeExtraSmall
//                                 : 0,
//                           ),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(Dimensions.radiusLarge),
//                               topRight: Radius.circular(Dimensions.radiusLarge),
//                               bottomLeft: Radius.circular(widget.isPopularItem
//                                   ? Dimensions.radiusLarge
//                                   : 0),
//                               bottomRight: Radius.circular(widget.isPopularItem
//                                   ? Dimensions.radiusLarge
//                                   : 0),
//                             ),
//                             child: CustomImage(
//                               isHovered: isHovered,
//                               placeholder: Images.placeholder,
//                               image: widget.item.imageFullUrl ?? '',
//                               fit: BoxFit.cover,
//                               width: double.infinity,
//                               height: double.infinity,
//                             ),
//                           ),
//                         ),
//                         AddFavouriteView(item: widget.item),
//                         if (widget.item.isStoreHalalActive! &&
//                             widget.item.isHalalItem!)
//                           const Positioned(
//                             top: 40,
//                             right: 15,
//                             child: CustomAssetImageWidget(
//                               Images.halalTag,
//                               height: 20,
//                               width: 20,
//                             ),
//                           ),
//                         DiscountTag(
//                           discount: discount,
//                           discountType: discountType,
//                           freeDelivery: false,
//                         ),
//                         OrganicTag(item: widget.item, placeInImage: false),
//                         if (widget.item.stock != null && widget.item.stock! < 0)
//                           Positioned(
//                             bottom: 10,
//                             left: 0,
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: Dimensions.paddingSizeSmall,
//                                 vertical: Dimensions.paddingSizeExtraSmall,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: Theme.of(context)
//                                     .primaryColor
//                                     .withOpacity(0.5),
//                                 borderRadius: const BorderRadius.only(
//                                   topRight:
//                                       Radius.circular(Dimensions.radiusLarge),
//                                   bottomRight:
//                                       Radius.circular(Dimensions.radiusLarge),
//                                 ),
//                               ),
//                               child: Text('out_of_stock'.tr,
//                                   style: robotoRegular.copyWith(
//                                       color: Theme.of(context).cardColor,
//                                       fontSize: Dimensions.fontSizeSmall)),
//                             ),
//                           ),
//                         if (!widget.isShop)
//                           Positioned(
//                             bottom: 10,
//                             right: 20,
//                             child: CartCountView(
//                               item: widget.item,
//                               index: widget.index,
//                             ),
//                           ),
//                         if (!Get.find<ItemController>()
//                             .isAvailable(widget.item))
//                           NotAvailableWidget(
//                             radius: Dimensions.radiusLarge,
//                             isAllSideRound: widget.isPopularItem,
//                           ),
//                       ]),
//                     ),

//                     // Text Section
//                     Expanded(
//                       flex: 5,
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: Dimensions.paddingSizeSmall,
//                           vertical:
//                               widget.isShop ? 0 : Dimensions.paddingSizeSmall,
//                         ),
//                         child: Column(
//                           crossAxisAlignment: widget.isPopularItem
//                               ? CrossAxisAlignment.center
//                               : CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             if (widget.isFood || widget.isShop)
//                               Text(widget.item.storeName ?? '',
//                                   style: robotoRegular.copyWith(
//                                       color: Theme.of(context).disabledColor))
//                             else
//                               Text(widget.item.name ?? '',
//                                   style: robotoBold,
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis),

//                             // Product name for food/shop
//                             if (widget.isFood || widget.isShop)
//                               Flexible(
//                                 child: Text(
//                                   widget.item.name ?? '',
//                                   style: robotoBold,
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),

//                             // Ratings
//                             if ((widget.isFood || widget.isShop) &&
//                                 widget.item.ratingCount! > 0)
//                               Row(
//                                 mainAxisAlignment: widget.isPopularItem
//                                     ? MainAxisAlignment.center
//                                     : MainAxisAlignment.start,
//                                 children: [
//                                   Icon(Icons.star,
//                                       size: 14,
//                                       color: Theme.of(context).primaryColor),
//                                   const SizedBox(
//                                       width: Dimensions.paddingSizeExtraSmall),
//                                   Text(
//                                       widget.item.avgRating!.toStringAsFixed(1),
//                                       style: robotoRegular.copyWith(
//                                           fontSize: Dimensions.fontSizeSmall)),
//                                   const SizedBox(
//                                       width: Dimensions.paddingSizeExtraSmall),
//                                   Text("(${widget.item.ratingCount})",
//                                       style: robotoRegular.copyWith(
//                                           fontSize: Dimensions.fontSizeSmall,
//                                           color:
//                                               Theme.of(context).disabledColor)),
//                                 ],
//                               ),

//                             // Unit type
//                             if (!(widget.isFood || widget.isShop) &&
//                                 Get.find<SplashController>()
//                                     .configModel!
//                                     .moduleConfig!
//                                     .module!
//                                     .unit! &&
//                                 widget.item.unitType != null)
//                               Text('(${widget.item.unitType})',
//                                   style: robotoRegular.copyWith(
//                                       fontSize: Dimensions.fontSizeExtraSmall,
//                                       color: Theme.of(context).hintColor)),

//                             // Striked price
//                             if (discount != null && discount > 0)
//                               Text(
//                                 PriceConverter.convertPrice(
//                                   pricePerUnit ??
//                                       Get.find<ItemController>()
//                                           .getStartingPrice(widget.item),
//                                 ),
//                                 style: robotoMedium.copyWith(
//                                   fontSize: Dimensions.fontSizeExtraSmall,
//                                   color: Theme.of(context).disabledColor,
//                                   decoration: TextDecoration.lineThrough,
//                                 ),
//                                 textDirection: TextDirection.ltr,
//                               ),

//                             // Final Price (userType based)
//                             Text(
//                               PriceConverter.convertPrice(
//                                 pricePerUnit ??
//                                     Get.find<ItemController>()
//                                         .getStartingPrice(widget.item),
//                                 discount: discount,
//                                 discountType: discountType,
//                               ),
//                               textDirection: TextDirection.ltr,
//                               style: robotoMedium,
//                             ),

//                             const SizedBox(
//                                 height: Dimensions.paddingSizeExtraSmall),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ]);
//             }),
//           ),
//         ),
//       ]),
//     );
//   }
// }
