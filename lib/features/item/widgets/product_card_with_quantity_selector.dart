// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../domain/models/item_model.dart';

// class ProductCardWithQuantitySelector extends StatefulWidget {
//   final Item item;
//   const ProductCardWithQuantitySelector({super.key, required this.item});

//   @override
//   State<ProductCardWithQuantitySelector> createState() =>
//       _ProductCardWithQuantitySelectorState();
// }

// class _ProductCardWithQuantitySelectorState
//     extends State<ProductCardWithQuantitySelector> {
//   late String userType;
//   List<int> quantityOptions = [];
//   double? unitPrice;
//   int selectedQuantity = 0;

//   @override
//   void initState() {
//     super.initState();
//     userType =
//         Get.find<AuthController>().userModel?.userType ?? 'single_user';
//     _initializeForUserType();
//   }

//   void _initializeForUserType() {
//     switch (userType) {
//       case 'distributor':
//         quantityOptions = widget.item.distributorQuantityTiers ?? [];
//         unitPrice = widget.item.distributorPrice ?? 0;
//         break;
//       case 'superstore':
//         quantityOptions = widget.item.superstoreQuantityTiers ?? [];
//         unitPrice = widget.item.superstorePrice ?? 0;
//         break;
//       case 'dealer':
//         quantityOptions = widget.item.dealerQuantityTiers ?? [];
//         unitPrice = widget.item.dealerPrice ?? 0;
//         break;
//       case 'retailer':
//         quantityOptions = widget.item.retailerQuantityTiers ?? [];
//         unitPrice = widget.item.retailerPrice ?? 0;
//         break;
//       default:
//         quantityOptions = widget.item.singleUserQuantityTiers ?? [];
//         unitPrice = widget.item.singleUserPrice ?? 0;
//     }

//     if (quantityOptions.isNotEmpty) {
//       selectedQuantity = quantityOptions.first;
//     }
//   }

//   double get totalPrice => selectedQuantity * (unitPrice ?? 0);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.all(12),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ITEM IMAGE
//             ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Image.network(
//                 widget.item.image ?? '', // make sure image exists
//                 height: 160,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(height: 12),

//             // ITEM TITLE
//             Text(
//               widget.item.name ?? 'No Name',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//             ),
//             const SizedBox(height: 8),

//             // QUANTITY DROPDOWN
//             Text("Select Quantity:", style: TextStyle(fontWeight: FontWeight.bold)),
//             DropdownButton<int>(
//               value: selectedQuantity,
//               isExpanded: true,
//               items: quantityOptions.map((qty) {
//                 return DropdownMenuItem<int>(
//                   value: qty,
//                   child: Text('$qty units'),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedQuantity = value!;
//                 });
//               },
//             ),

//             // PRICE DETAILS
//             const SizedBox(height: 6),
//             Text('Unit Price: ₹${unitPrice?.toStringAsFixed(2) ?? "0.00"}'),
//             Text(
//               'Total: ₹${totalPrice.toStringAsFixed(2)}',
//               style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
//             ),
//             const SizedBox(height: 12),

//             // ADD TO CART
//             ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 minimumSize: Size(double.infinity, 45),
//                 backgroundColor: Colors.blueAccent,
//               ),
//               onPressed: () {
//                 // TODO: You can connect this with CartController
//                 Get.snackbar("Added", "${selectedQuantity} item(s) added to cart!",
//                     snackPosition: SnackPosition.BOTTOM);
//               },
//               icon: Icon(Icons.shopping_cart),
//               label: Text('Add to Cart'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
