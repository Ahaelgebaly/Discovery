import 'package:discovery/categories/beaches/Beaches.dart';
import 'package:discovery/categories/mountains/GalalaMountain.dart';
import 'package:discovery/categories/mountains/SerpalMountain.dart';
import 'package:discovery/categories/churche/churches.dart';
import 'package:discovery/categories/desert/desert.dart';
import 'package:discovery/screens/mainscreen.dart';
import 'package:discovery/categories/mosque/mosque.dart';
import 'package:discovery/categories/mountains/mountmusa.dart';
import 'package:discovery/categories/museum/museum.dart';
import 'package:discovery/categories/restaurant/restaurants.dart';
import 'package:discovery/categories/mountains/saintcatherine.dart';
import 'package:discovery/categories/temple/temples.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class mountains extends StatefulWidget {
  const mountains({Key? key}) : super(key: key);

  @override
  State<mountains> createState() => _mountainsState();
}

class _mountainsState extends State<mountains> {
  final List<Widget> buttons = <Widget>[
    saintcatherine(),
    mountmusa(),
    galala(),
    serpal()
  ];
  final List<Widget> buttons1 = <Widget>[
    mountains(),
    beaches(),
    desert(),
    mosque(),
    churches(),
    museum(),
    temples(),
    restaurants(),
  ];
  final List<Color> colors = <Color>[
    Color.fromARGB(100, 241, 251, 255),
    Color.fromARGB(100, 255, 255, 255),
    Color.fromARGB(100, 255, 255, 255),
    Color.fromARGB(100, 255, 255, 255),
    Color.fromARGB(100, 255, 255, 255),
    Color.fromARGB(100, 255, 255, 255),
    Color.fromARGB(100, 255, 255, 255),
    Color.fromARGB(100, 255, 255, 255),
  ];
  final List<String> namess = <String>[
    'Mountains',
    'Beaches',
    'Desert',
    'Mosques',
    'Churches',
    'Museums',
    'Temple',
    'Restaurants',
  ];
  final List<String> imagess = <String>[
    'images/mountain.png',
    'images/beach_icon.png',
    'images/desert_icon.png',
    'images/mosque_icon.png',
    'images/churches.png',
    'images/museum.png',
    'images/temple.png',
    'images/resturant.png',
  ];
  final List<String> names = <String>[
    'Sinai',
    'Sinai',
    'Suez Government',
    'Wadi Firan, South Sinai',
  ];

  final List<bool> favourite = <bool>[
    true,
    true,
    true,
    true,
  ];
  final List<String> images = <String>[
    'images/saint.webp',
    'images/musa.webp',
    'images/galala.jpg',
    'images/serrpal.jpg',
  ];

  final List<String> names2 = <String>[
    'Saint Catherine        ',
    'Mount Musa     ',
    'Galala Mountain',
    'Serpal Mountain'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey.shade200,
          toolbarHeight: 80,
          elevation: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,

                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(
                        builder: (_) => TabScreen()),(route) => false,
                    );
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Color(0xff3e97bd),
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),

              SizedBox(
                width: 275,
              ),

            ],
          )),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey.shade200,
          padding: EdgeInsets.only(top: 5, left: 32, right: 32),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: 40.5,
                      child: new ListView.separated(
                        itemCount: namess.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: colors[index],
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context)=> buttons1[index])
                                          );
                                        },
                                        child: Image.asset(imagess[index])),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context)=> buttons1[index])
                                      );
                                    },
                                    child: Text(
                                      namess[index],
                                      style: TextStyle(
                                        color: Color(0xFF205065),
                                        fontSize: 11.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          width: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: 10000,
                      child: ListView.separated(
                        itemCount: names.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => buttons[index]));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    Container(
                                      child: Image.asset(
                                        images[index],
                                        width: 380,
                                        height: 135,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 20.0, bottom: 25.0),
                                      child: Text(
                                        names2[index],
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ),
                                    Container(
                                        alignment: Alignment.topRight,
                                        padding: EdgeInsets.only(
                                          left: 200.0,
                                          bottom: 80,
                                        ),
                                        child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                favourite[index] =
                                                !favourite[index];
                                              });
                                            },
                                            icon: CircleAvatar(
                                              radius: 15.0,
                                              backgroundColor: favourite[index]
                                                  ? Colors.white24
                                                  : Colors.white24,
                                              child: favourite[index]
                                                  ? Icon(Icons.favorite_border, color: Colors.red)
                                                  : Icon(Icons.favorite , color: Colors.red,),
                                              ),
                                            )
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 20.0, bottom: 10.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                          Text(names[index],
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 11.0,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Roboto',
                                              ))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
