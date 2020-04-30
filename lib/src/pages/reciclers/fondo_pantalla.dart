import 'dart:math';

import 'package:flutter/material.dart';

Widget fondoPantalla(){

  final gradiente = Container(
    width: double.infinity,
    height: double.infinity,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin:  FractionalOffset(0.0, 0.6),
        end:    FractionalOffset(0.0, 1.0),
        colors: [
          Color.fromRGBO(52, 54, 101, 1.0),
          Color.fromRGBO(35, 37, 57, 1.0)
        ]
      )
    ),
  );
    
  final cajaRosada = Transform.rotate(
    angle: -pi / 5.0,
    child: Container(
      height: 360.0,
      width: 360.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(70.0),
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(236, 98, 188, 1.0),
            Color.fromRGBO(241, 142, 172, 1.0)
          ]
        ),
      ),
    ),
  );
    
  return Stack(
    children: <Widget>[
      gradiente,
      Positioned(
        top: -100,
        child: cajaRosada,
      )
    ],
  );

}