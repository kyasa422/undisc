import 'package:flutter/material.dart';
import 'package:undisc/themes/themes.dart';

class PhotoZoom extends StatelessWidget {
  final String urlPhoto;
  const PhotoZoom({super.key, required this.urlPhoto});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Themes().dark,
      appBar: AppBar(backgroundColor: Themes().transparent, foregroundColor: Themes().white,),
      body: Center(
        child: Hero(
          tag: "Profile",
          child: AspectRatio(
            aspectRatio: size.aspectRatio,
            child: Image.network(urlPhoto),
          ),
        ),
      ),
    );
  }
}