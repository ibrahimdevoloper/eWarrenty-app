// import 'package:awael_bmi/pages/PdfViewerPage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
//
// import '../app_localizations.dart';
//
// AlertDialog downloadDialog(BuildContext context, String url) {
// //   double mTotalPrice  =0;
// //   for(int i=0;i<list.length;i++)
// //     mTotalPrice+=list[i].totalPrice;
// //
// //   double mTotalItemsCount  =0;
// //   for(int i=0;i<list.length;i++)
// //     mTotalItemsCount+=list[i].quantity;
// //
// //   // double mTotalCategoryCount  =list.length as double;
// //
// //   String content =
// //   '''${AppLocalizations.of(context).translate("totalPriceOfTheOrder")}: $mTotalPrice
// // ${AppLocalizations.of(context).translate("totalItemsOfTheOrder")}: $mTotalItemsCount
// // ${AppLocalizations.of(context).translate("totalCategoryOfTheOrder")}: ${list.length}''';
//
//   // var file = await DefaultCacheManager().getSingleFile(url);
//   return AlertDialog(
//     actions: [
//
//       FlatButton(
//         onPressed: (){
//           Navigator.pop(context);
//         },
//         child: Text(AppLocalizations.of(context).translate("cancel")),
//       ),
//     ],
//     title: Text("Catalog"),
//     content: StreamBuilder<FileResponse>(
//         stream: DefaultCacheManager().getFileStream(url, withProgress: true),
//         builder: (context, snapshot) {
//           var loading = !snapshot.hasData || snapshot.data is DownloadProgress;
//
//           // print(snapshot.data);
//           if (snapshot.hasError) {
//             return ListTile(
//               title: const Text('Error'),
//               subtitle: Text(snapshot.error.toString()),
//             );
//           } else if (!snapshot.hasData) {
//             return Container(
//               height: 200,
//               child: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           } else if (snapshot.data is DownloadProgress) {
//             // var totalsize = (snapshot.data as DownloadProgress).totalSize;
//             // print("data: ${(snapshot.data as DownloadProgress).progress}");
//             return Container(
//               height: 200,
//               child: Center(
//                 child: CircularProgressIndicator(
//                     value:
//                         (snapshot.data as DownloadProgress).progress),
//               ),
//             );
//           } else {
//             var fileInfo = snapshot.data as FileInfo;
//             print(fileInfo.file.path);
//             return Container(
//               child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               RaisedButton(
//                 color: Theme.of(context).primaryColor,
//                 child: Text("Open File",
//                   style: TextStyle(color: Colors.white),
//                 ),
//                   onPressed: (){
//                     Navigator.pop(context);
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => PdfViewerPage(
//                             path:fileInfo.file.path ,
//                           )),
//                     );
//                   }),
//               SizedBox(height: 8,),
//               // RaisedButton(
//               //     child: Text("Delete File"),
//               //     onPressed: (){
//               //       Navigator.push(
//               //         context,
//               //         MaterialPageRoute(
//               //             builder: (context) => PdfViewerPage(
//               //               path:fileInfo.file.path ,
//               //             )),
//               //       );
//               //     })
//             ],
//               ),
//             );
//           }
//         }),
//     // actions: [
//     //   FlatButton(
//     //     // onPressed: yes,
//     //     onPressed: () {
//     //       DefaultCacheManager().removeFile(url);
//     //     },
//     //     child: Text(AppLocalizations.of(context).translate("yes")),
//     //   ),
//     //   FlatButton(
//     //     // onPressed: no,
//     //     child: Text(AppLocalizations.of(context).translate("no")),
//     //   ),
//     // ],
//   );
// }
