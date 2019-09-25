import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:topcinema/constants.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(child: Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            SizedBox(height: 60),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CachedNetworkImage(
                imageUrl:
                'https://cdn4.iconfinder.com/data/icons/avatars-xmas-giveaway/128/batman_hero_avatar_comics-512.png',
                width: 100,
                height: 100,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Darwin Morocho",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            TextButton(
              leftText: "Email",
              textColor: Color(0xffECEFF1),
              text: "darwin.morocho@icloud.com",
              onPressed: () {},
            ),
            TextButton(
              leftText: "Cedula/Pasaporte",
              textColor: Color(0xffECEFF1),
              text: "17245678907",
              onPressed: () {},
            ),
            TextButton(
              leftText: "Celular",
              textColor: Color(0xffECEFF1),
              text: "+593984354547",
              onPressed: () {},
            ),
            TextButton(
              leftText: "Salir",
              textColor: Constants.acentColor,
              text: "Cerrar Sesión",
              onPressed: () {},
            )
          ],
        ),
      )),
    );
  }
}

class TextButton extends StatelessWidget {
  final String leftText;
  final String text;
  final Color textColor;
  final VoidCallback onPressed;

  const TextButton(
      {Key key,
      this.leftText = '',
      this.text = '',
      this.textColor = Colors.black26,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 1),
        child: CupertinoButton(
            color: Color(0xff263238),
            borderRadius: BorderRadius.circular(0),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    leftText != null ? leftText : '',
                    style: TextStyle(color: Colors.white,fontFamily: 'Anton',letterSpacing: 1,fontWeight: FontWeight.w300),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                            child: Text(
                              text != null ? text : '',
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: textColor, fontWeight: FontWeight.w100),
                            )),
                        SizedBox(width: 5),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: textColor,
                          size: 20,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            onPressed: onPressed));
  }
}
