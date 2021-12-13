 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 import 'package:liquid_swipe/liquid_swipe.dart';
class HomePage extends StatelessWidget{




  @override
  Widget build(BuildContext context) {
    return LiquidSwipe(pages:[
    Page(img: 'home-page1.jpg'),
      Page(img: 'home-page2.jpg'),
      Page(img: 'home-page3.jpg'),
      Page(img: 'home-page4.jpg'),
      Page(img: 'home-page5.png'),
      Page(img: 'home-page6.jpg'),
      Page(img: 'home-page7.png'),
      Page(img: 'home-page8.jpg'),
      Page(img: 'home-page9.jpg'),

    ],

    );
  }}
 
 
  class Page extends StatelessWidget{
  final String img;

  const Page( {required this.img});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      height: double.infinity,
      width: double.infinity,
      child: Image.asset('assets/images/'+img, fit: BoxFit.cover,),

    );
  }

  }