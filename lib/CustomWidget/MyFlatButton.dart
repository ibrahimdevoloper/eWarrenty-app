import 'package:flutter/material.dart';

class MyFlatButton extends StatelessWidget {
  final Function function;
  final String title;
  final Widget child;

  MyFlatButton({this.function, this.title, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: 150,
      decoration: BoxDecoration(),
      child: OutlineButton(
        borderSide: BorderSide(color: Theme.of(context).primaryColor,width: 4),
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
        // clipBehavior: Clip.antiAlias,
        onPressed: function,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // SizedBox(
            //   height: 16,
            // ),
            Container(
              height: 56,
                child: child),
            SizedBox(height: 8,),
            Text(
              title,
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.button.fontSize,color: Theme.of(context).primaryColor),
            ),
          ],
        ),
        // height: 125,
      ),
    );
  }
}