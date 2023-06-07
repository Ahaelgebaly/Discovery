import 'package:flutter/material.dart';
class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _favouriteState();
}

class _favouriteState extends State<FavouriteScreen> {

  final List<String> names4 = <String>[
    'White Desert',
    'Giza',
    'Almasa Hotel Naser City',
  ];

  final List<bool> favourite2 = <bool>[
    true,
    true,
    true,
  ];
  final List<String> images3 = <String>[
    'images/overnight.jpeg',
    'images/pyramids.jpg',
    'images/villa.jpg',


  ];

  final List<String> names3 = <String>[
    'Overnight Tour        ',
    'Pyramids     ',
    'Villa Beirut Restaurant'
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

              SizedBox(
                width: 12,
              ),

              Row(
                children: [
                  Center(
                    child: Text("Favourite",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(31, 80, 100, 1),
                          fontFamily: 'Roboto',
                          height: 1,
                        )
                    ),
                  ),

                ],
              ),
              SizedBox(
                width: 190,
              ),

            ],
          )),

      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey.shade200,
          padding: EdgeInsets.only(top: 30, left: 32, right: 32),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: 10000,
                      child: ListView.separated(
                        itemCount: names3.length,
                        itemBuilder: (context, index) {
                          return Container(
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
                                      images3[index],
                                      width: 350,
                                      height: 135,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 20.0, bottom: 25.0),
                                    child:
                                    Text(
                                      names3[index],
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
                                              favourite2[index] =
                                              !favourite2[index];
                                            });
                                          },
                                          icon: CircleAvatar(
                                            radius: 15.0,
                                            backgroundColor: favourite2[index]
                                                ? Colors.white24
                                                : Colors.white24,
                                            child: Icon(
                                              Icons.favorite,
                                              color: favourite2[index]
                                                  ? Colors.red
                                                  : Colors.red,
                                            ),
                                          ))),
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
                                        Text(names4[index],
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Roboto',

                                        )
                                        )
                                      ],
                                    ),
                                  )
                                ],
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


