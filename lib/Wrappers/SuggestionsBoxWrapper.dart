import 'package:flutter/material.dart';

class SuggestionsBoxWrapper extends StatelessWidget {
  final String title;
  final Widget child;


  SuggestionsBoxWrapper(this.title, this.child);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
             [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                child: Text(title,
                  style: Theme.of(context).textTheme.caption,),
              ),
              child,
            ],
          ),
        ),
      ],
    );
  }
}
