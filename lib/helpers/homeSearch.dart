// import 'package:awael_bmi/Modals/CartItem.dart';
// import 'package:awael_bmi/Modals/product.dart';
// import 'package:awael_bmi/Providers/LoginProvider.dart';
// import 'package:awael_bmi/Providers/shoppingCartProvider.dart';
// import 'package:awael_bmi/dialogs/addPurchaseDialog.dart';
// import 'package:awael_bmi/functions/addDetail.dart';
// import 'package:awael_bmi/functions/addLike.dart';
// import 'package:awael_bmi/functions/cachedFilesShare.dart';
// import 'package:awael_bmi/pages/productDetailPage.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:like_button/like_button.dart';
// import 'package:provider/provider.dart';
// import 'package:awael_bmi/helpers/roles.dart' as roles;
//
//
// import '../app_localizations.dart';
//
// class HomeSearch extends SearchDelegate {
//
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = "";
//         },
//       )
//     ];
//   }
//
//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, "null");
//       },
//     );
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     print ("buildResults : rebuild");
//     return Material(
//       child: DefaultTabController(
//         initialIndex: 0,
//         length: 4,
//         child: Scaffold(
//           appBar: TabBar(
//             labelColor: Colors.black,
//             labelStyle: TextStyle(
//                 fontSize: Theme.of(context).textTheme.caption.fontSize,
//                 fontWeight: FontWeight.bold),
//             tabs: [
//               // Tab(icon: Icon(Icons.directions_car,color: Colors.blue,)),
//               // Tab(icon: Icon(Icons.directions_transit,color: Colors.blue,)),
//               // Tab(icon: Icon(Icons.directions_bike,color: Colors.blue,)),
//               Tab(
//                 text: "search by name",
//               ),
//               Tab(
//                 text: "search by number",
//               ),
//               Tab(
//                 text: "search by color",
//               ),
//               Tab(
//                 text: "search by color",
//               ),
//             ],
//           ),
//           body: TabBarView(
//             children: [
//               ListView.builder(
//                   itemCount: 10,
//                   itemBuilder: (context, i) {
//                     return ListTile(
//                       title: Text("$query name $i"),
//                     );
//                   }),
//               ListView.builder(
//                   itemCount: 10,
//                   itemBuilder: (context, i) {
//                     return ListTile(
//                       title: Text("$query number $i"),
//                     );
//                   }),
//               ListView.builder(
//                   itemCount: 10,
//                   itemBuilder: (context, i) {
//                     return ListTile(
//                       title: Text("$query color $i"),
//                     );
//                   }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return Center(
//       child: Text("send search term"),
//     );
//   }
// }
//
// class ResultsTab extends StatelessWidget {
//   final List<Product> products;
//   final String baseURL;
//   final GlobalKey<ScaffoldState> _scaffoldKey;
//
//
//   ResultsTab(this.products, this.baseURL, this._scaffoldKey);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: products.isNotEmpty?OrientationBuilder(
//         builder:(context, orientation)=> Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: GridView.builder(
//             itemCount: products.length,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               childAspectRatio: MediaQuery.of(context).orientation == Orientation.portrait ? 0.6:0.9,
//               crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 2:3,
//             ),
//             itemBuilder: (context, i) {
//               var myURL = "${baseURL}/${products[i].image}";
//               myURL =
//                   myURL.replaceAll(RegExp(r'localhost'), '10.0.2.2:80');
//               // print(myURL);
//               return ProductItem(
//                   Localizations.localeOf(context)
//                       .languageCode
//                       .contains("ar")
//                       ? products[i].productNameAr
//                       : products[i].productNameEn,
//                   myURL,
//                   products[i],
//                   //todo: modifey the like if true or not
//                   false,
//                   // _controller,
//                   _scaffoldKey);
//             },
//           ),
//         ),
//       ):Center(
//         child: Text(AppLocalizations.of(context).translate("noProducts")),
//       ),
//     );
//   }
// }
//
// class ProductItem extends StatefulWidget {
//   final String _title;
//   final String _image;
//   final Product product;
//   final bool like;
//   // final AnimationController _controller;
//   final GlobalKey _key;
//
//
//   ProductItem(this._title, this._image, this.product, this.like,
//       // this._controller,
//       this._key);
//
//   @override
//   _ProductItemState createState() => _ProductItemState();
// }
//
// class _ProductItemState extends State<ProductItem> {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: InkWell(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) =>
//                   ProductDetailPage(widget._title, int.parse(widget.product.id)),
//             ),
//           );
//         },
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             CachedNetworkImage(
//               fit: BoxFit.cover,
//               height: 150,
//               imageUrl: widget._image,
//               progressIndicatorBuilder: (context, url, downloadProgress) =>
//                   Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
//               errorWidget: (context, url, error) => Icon(Icons.error),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Row(
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   Text(
//                     widget._title,
//                     textAlign: TextAlign.start,
//                   ),
//                 ],
//               ),
//             ),
//             // SizedBox(
//             //   height: 8,
//             // ),
//             Row(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Consumer<LoginProvider>(
//                   builder:(_,provider,__)=> LikeButton(
//                     onTap: (isLiked) async {
//
//                       //todo: like Button
//                       return await addLike(
//                           isLiked,
//                           provider.token,
//                           int.parse(widget.product.id),
//                           provider.userId,
//                           context,
//                           widget._key
//                       );
//                     },
//                     circleColor: CircleColor(
//                         start: Colors.blueAccent, end: Colors.deepOrange),
//                     //todo: parse the Like
//                     isLiked: widget.like,
//                     likeBuilder: (bool isLiked) {
//                       return Icon(
//                         FontAwesomeIcons.solidHeart,
//                         color: isLiked ? Colors.deepOrange : Colors.black54,
//                       );
//                     },
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(
//                     FontAwesomeIcons.shareAlt,
//                     color: Colors.black54,
//                   ),
//                   onPressed: () {
//                     cachedFileShare(widget._image,addDetail(context, widget.product,false));
//                   },
//                 ),
//                 Consumer<ShoppingCartProvider>(builder: (_, provider, __) {
//                   LoginProvider loginProvider =Provider.of<LoginProvider>(context);
//                   return IconButton(
//                     icon: Icon(
//                       FontAwesomeIcons.shoppingCart,
//                       color: Colors.black54,
//                     ),
//                     onPressed: () {
//                       showDialog(
//                         context: context,
//                         builder: (context) => addPurchaseAlertDialog(
//                           //todo: test with user roles
//                             CartItem(
//                                 product: widget.product,
//                                 productId:int.parse (widget.product.id),
//                                 nameAr:widget.product.productNameAr,
//                                 nameEn:widget.product.productNameEn,
//                                 productNumber:widget.product.productNumber,
//                                 quantity:double.parse( widget.product.quantity),
//                                 productPrice:double.parse(
//                                   loginProvider.userRole.contains(roles.customerWholesale)?
//                                     widget.product.priceWholesale:
//                                   loginProvider.userRole.contains(roles.retail)?
//                                   widget.product.priceRetail:
//                                   loginProvider.userRole.contains(roles.halfWholesale)?
//                                   widget.product.priceHalfWholesale:
//                                   loginProvider.userRole.contains(roles.customerVip)?
//                                   widget.product.priceVip:"0"),
//                                 totalPrice:double.parse(widget.product.quantity) *
//                                     double.parse(
//                                         loginProvider.userRole.contains(roles.customerWholesale)?
//                                         widget.product.priceWholesale:
//                                         loginProvider.userRole.contains(roles.retail)?
//                                         widget.product.priceRetail:
//                                         loginProvider.userRole.contains(roles.halfWholesale)?
//                                         widget.product.priceHalfWholesale:
//                                         loginProvider.userRole.contains(roles.customerVip)?
//                                         widget.product.priceVip:"0"
//                                     ),
//                                 image:widget._image),
//                             widget.product,
//                             context,
//                             provider,
//                             null,
//                             widget._key),
//                       );
//                     },
//                   );
//                 }),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
