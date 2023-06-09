import 'package:discovery/screens/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class mytrip extends StatefulWidget {
  const mytrip({Key? key}) : super(key: key);

  @override
  State<mytrip> createState() => _mytripState();
}

class _mytripState extends State<mytrip> {
  final List<String> names3 = <String>[
    'Dahab Beach',
    'Blue Hole Beach',
  ];
  final List<String> names1 = <String>[
    'The beach is one of Dahab’s ',
    'The Blue Hole is a diving location on the southeast',
  ];
  final List<String> names2 = <String>[
    '(4.9)',
    '(5)',
  ];
  final List<String> images3= <String>[
    'images/dahab.webp',
    'images/bluehole.webp',
  ];
  final List<bool> favourite = <bool>[
    true,
    true,
  ];
  final List<String> names4 = <String>[
    'South Sinai',
    'Dahab, South Sinai',
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
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,

                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(
                        context,
                        MaterialPageRoute(builder: (context)=> menu())
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
              Row(
                children: [
                  Text("My Trip",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(31, 80, 100, 1),
                        fontFamily: 'Roboto',
                        height: 1,
                      )
                  ),

                ],
              ),
            ],
          )),
      body: SingleChildScrollView(
        child: Container(
          height: 780,
          width: 500,
          color: Colors.grey.shade200,
          padding: EdgeInsets.only(top: 30, left: 32, right: 32),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: 750,
                      child: ListView.separated(
                        itemCount: names3.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0) ,color: Colors.white
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Container(
                                  child: Image.asset(
                                    images3[index],
                                    width: 175,
                                    height: 124,
                                    fit: BoxFit.fitWidth,
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 190, bottom: 80),
                                  child:
                                  Text(
                                    names3[index],
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Color(0xff205065),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ),
                                Container(
                                    alignment: Alignment.topCenter,
                                    padding: EdgeInsets.only(
                                      right: 35.0,
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
                                          backgroundColor: Colors.white24,
                                          child: favourite[index]
                                              ? Icon(Icons.favorite_border, color: Colors.red)
                                              : Icon(Icons.favorite , color: Colors.red,),
                                        ))),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 190.0, bottom: 40.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: Color(0xff205065),
                                        size: 15,
                                      ),
                                      Text(names4[index],
                                          style: TextStyle(
                                            color: Color(0xff205065),
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Roboto',
                                          )

                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 190, top: 20),
                                  child:
                                  Text(
                                    names1[index],
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Color(0xFF9593a8),
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 290, top: 90),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 18,
                                      ),
                                      Text(
                                        names2[index],
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Color(0xFF205065),
                                          fontSize: 11.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
