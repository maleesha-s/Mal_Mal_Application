import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Body extends StatelessWidget {
  const Body({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top:0,
            left: 0,
            child: Image.asset(
              "assets/images/main_top.png",
              width: size.width * 0.3,
            )
          ), 
          Positioned(
            top: size.height * 0.3,
            left: 0,
            child: Image.asset(
              "assets/images/undraw_different_love_a3rg.png",
              width: size.width * 1,
            )
          ),
          Positioned(
            top: size.height * 0.3,
            left: size.width * 0.2,
            child: Text(
              "Mal Mal App ",
              style: GoogleFonts.lato(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 48,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
              ),
            )
          ),
          Positioned(
            bottom:0,
            left: 0,
            child: Image.asset(
              "assets/images/main_bottom.png",
              width: size.width * 0.3,
            )
          )
        ],
      ),
    );
  }
}