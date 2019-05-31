import 'package:flutter/material.dart';

_sliver(context){
  return CustomScrollView(
    slivers: <Widget>[
      SliverAppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        leading: Container(),
        floating: false,
        pinned: false,
        flexibleSpace: new FlexibleSpaceBar(
//          background: Image.network(
//
//            fit: BoxFit.cover
//          ),
        ),
        expandedHeight: 300,
      )
    ],
  );
}

_onclickFavoritar(context) async {

}