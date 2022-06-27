import 'package:flutter/material.dart';
import 'package:thinknlocal_app/res/res.dart';

Widget handleEmptyState(BuildContext context, String title, {Widget? widget}){
  return  SizedBox(
    height: getHeight()*0.1,
    width: MediaQuery.of(context).size.width,
    child: widget ??  Center(child: Text(title)),
  );
}