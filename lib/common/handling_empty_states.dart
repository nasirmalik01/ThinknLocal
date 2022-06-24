import 'package:flutter/material.dart';
import 'package:thinknlocal_app/res/res.dart';

Widget handleEmptyState(BuildContext context, String title, {Widget? widget}){
  return  Container(
    height: getHeight()*0.1,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(5)
    ),
    child: widget ??  Center(child: Text(title)),
  );
}