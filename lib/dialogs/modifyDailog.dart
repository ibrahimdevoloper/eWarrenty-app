// import 'package:awael_bmi/Modals/CartItem.dart';
// import 'package:awael_bmi/Providers/shoppingCartProvider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import '../app_localizations.dart';
//
// AlertDialog modifyDialog(
//     int index,
//     // CartItem item,
//     BuildContext context,
//     ShoppingCartProvider provider,
//     GlobalKey<ScaffoldState> key) {
//   CartItem item = provider.cartList[index];
//   return AlertDialog(
//     title: Text(
//         '${AppLocalizations.of(context).translate("modifying")} ${Localizations.localeOf(context)
//             .languageCode
//             .contains("ar")
//             ? item.nameAr:item.nameEn} '),
//     content: Row(
//       mainAxisSize: MainAxisSize.max,
//       children: [
//         Text('${AppLocalizations.of(context).translate("quantity")}:'),
//         Expanded(
//           child: TextFormField(
//             onChanged: (value) {
//               provider.quantity = value;
//             },
//             keyboardType: TextInputType.number,
//             inputFormatters: <TextInputFormatter>[
//               FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
//             ],
//           ),
//         ),
//       ],
//     ),
//     actions: [
//       FlatButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: Text(AppLocalizations.of(context).translate("cancel"))),
//       FlatButton(
//           onPressed: () {
//             double no;
//             // todo: check If the ordered quantity is larger
//             if (provider.quantity.isNotEmpty) {
//               no = double.parse(provider.quantity);
//             } else {
//               Navigator.pop(context);
//               SnackBar snackbar = SnackBar(
//                   content: Text(AppLocalizations.of(context)
//                       .translate("youDidntModifyQuantity")));
//               key.currentState.showSnackBar(snackbar);
//             }
//             CartItem temp = CartItem(
//               product: item.product,
//                 productId: item.productId,
//                 nameAr: item.nameAr,
//                 nameEn: item.nameEn,
//                 productNumber: item.productNumber,
//                 quantity: item.quantity,
//                 productPrice: item.productPrice,
//                 totalPrice: item.quantity * item.productPrice,
//                 image: item.image);
//             provider.updateList(index, temp);
//             print(provider.quantity);
//             provider.quantity = '';
//             Navigator.pop(context);
//             // controller.forward().then((value) {
//             //   controller.reverse();
//             // });
//           },
//           child: Text(AppLocalizations.of(context).translate("modify"))),
//     ],
//   );
// }
