
import 'package:flutter/material.dart';

navPush(BuildContext context , var home){
  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>home));
}

navReplace(BuildContext context , var home){
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>home));
}


navRemove(BuildContext context , var home){
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>home) , (context)=>false);
}
