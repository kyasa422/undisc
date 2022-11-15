import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../themes/themes.dart';

Container cardDiscussionsLoad(Size size) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20.0),
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: Themes().grey100,
      boxShadow: [
        BoxShadow(
            offset: const Offset(5, 8),
            spreadRadius: 1,
            blurRadius: 10,
            color: Themes().grey300
        )
      ]
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Flex(
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.all(0.0),
                  leading: CircleAvatar(backgroundColor: Themes().grey300,),
                  title: Container(height: 10, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Themes().grey300),), 
                  subtitle: Container(height: 10, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Themes().grey300),)
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 5.0,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 10, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Themes().grey300),),
              const SizedBox(height: 5.0,),
              Container(height: 10, width: 50.0, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Themes().grey300),),
              const SizedBox(height: 20.0,),
              Container(height: 10, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Themes().grey300),),
              const SizedBox(height: 5.0,),
              Container(height: 10, width: size.width / 2, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Themes().grey300),),
              const SizedBox(height: 5.0),
              Container(height: 10, width: size.width / 5, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Themes().grey300),),
            ],
          )
        ),
        const SizedBox(height: 13.0,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              direction: Axis.horizontal,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 7.0),
                  child: FaIcon(FontAwesomeIcons.solidStar, color: Themes().grey300,),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 7.0),
                  child: FaIcon(FontAwesomeIcons.solidComments, color: Themes().grey300,),
                ),
              ],
            ),

            Container(
              margin: const EdgeInsets.only(right: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(height: 10, width: 20.0, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Themes().grey300),),
                  const SizedBox(height: 3.0,),
                  Container(height: 10, width: 40.0, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Themes().grey300),)
                ],
              ),
            )
          ],
        )
      ],
    )
  );
}