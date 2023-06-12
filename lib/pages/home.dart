import 'package:discovery/activites/camping/camping.dart';
import 'package:discovery/activites/diving/diving.dart';
import 'package:discovery/activites/safari/safari.dart';
import 'package:discovery/categories/beaches/Beaches.dart';
import 'package:discovery/categories/churche/churches.dart';
import 'package:discovery/categories/desert/desert.dart';
import 'package:discovery/categories/museum/egypt.dart';
import 'package:discovery/recommended/beachlife.dart';
import 'package:discovery/recommended/khanelkhalili.dart';
import 'package:discovery/screens/menu.dart';
import 'package:discovery/categories/mosque/mosque.dart';
import 'package:discovery/categories/mountains/mountains.dart';
import 'package:discovery/categories/museum/museum.dart';
import 'package:discovery/screens/notification.dart';
import 'package:discovery/categories/restaurant/restaurants.dart';
import 'package:discovery/categories/temple/temples.dart';
import 'package:discovery/utils/firebase.dart';
import 'package:file/file.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../categories/museum/royal.dart';
import '../models/wishlist_item.dart';
import '../screens/searchcategory.dart';
import '../view_models/wishlist/wishlist_view_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = false;
  String? username;
  File? mediaUrl;
  final picker = ImagePicker();
  String? location;
  Position? position;
  Placemark? placemark;
  String? bio;
  String? description;
  String? email;
  String? commentData;
  String? ownerId;
  String? userId;
  String? type;
  File? userDp;
  String? imgLink;
  bool edit = false;
  String? id;
  TextEditingController locationTEC = TextEditingController();
  bool fav = false;

  final List<String> names = <String>[
    'Mountains',
    'Beaches',
    'Desert',
    'Mosques',
    'Churches',
    'Museums',
    'Temple',
    'Restaurants',
  ];

  final List<String> images = <String>[
    'images/mountain.png',
    'images/beach_icon.png',
    'images/desert_icon.png',
    'images/mosque_icon.png',
    'images/churches.png',
    'images/museum.png',
    'images/temple.png',
    'images/resturant.png',
  ];

  final List<String> names2 = <String>[
    'Khan El Khalili ',
    'Museum Of Egypt',
    'Beach Life',
    'The Royal Museum',
  ];
  final List<Widget> buttons = <Widget>[
    mountains(),
    beaches(),
    desert(),
    mosque(),
    churches(),
    museum(),
    temples(),
    restaurants(),
  ];

  final List<Widget> recomenddwdbuttons = <Widget>[
    khanelkalili(),
    egypt(),
    beachlife(),
    royal()
  ];
  final List<Widget> activitybuttons = <Widget>[
   camping(),
    safari(),
    diving()
  ];
  final List<String> names4 = <String>[
    'White Desert',
    'Siwa',
    'Dahab',
    'Luxor',
  ];
  final List<String> names5 = <String>[
    'Cairo',
    'Tahrir Square, Cairo',
    'South Sinai',
    'Cairo',
  ];
  final List<String> recommend = <String>[
    '4.9',
    '4.8',
    '4,8',
    '4,7'
];
  final List<String> images2 = <String>[
    'images/khan.jpg',
    'images/museum.webp',
    'images/beach1.jpg',
    'images/royal.webp',
  ];
  final List<bool> favourite = <bool>[
    true,
    true,
    true,
    true,
  ];
  final List<bool> favourite2 = <bool>[
    true,
    true,
    true,
    true,
  ];
  final List<String> images3 = <String>[
    'images/overnight.jpeg',
    'images/safari.jpg',
    'images/bluehole.webp',
  ];

  final List<String> names3 = <String>[
    'Camping        ',
    '  Safari       ',
    ' Diving         ',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              menu(profileId: firebaseAuth.currentUser!.uid),
            ],
          ),
        ),
      ),
      appBar: AppBar(
          leading: Builder(builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: Icon(Icons.menu_outlined),
                  color: Color(0xff3e97bd),
                ),
              ),
            );
          }),
          backgroundColor: Colors.grey.shade200,
          toolbarHeight: 80,
          elevation: 0.0,
          title: Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Current Location",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade500)),
                        InkWell(
                          onTap: () => getLocation(),
                          child: Container(
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 260,
                                      height: 30,
                                      child: Container(
                                        padding: EdgeInsets.only(top: 15),
                                        child: TextFormField(
                                          controller: locationTEC,
                                          decoration: InputDecoration(
                                            hintText: 'tap here!'.toUpperCase(),
                                            hintStyle: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff205065)),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(0),
                                                borderSide: BorderSide.none),
                                          ),
                                          readOnly: true,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff205065)),
                                          onChanged: (val) => setLocation(val),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                  Container(
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Activities()));
                          },
                          icon: CircleAvatar(
                            backgroundColor: Colors.white24,
                            child: Icon(
                              Icons.notifications_none_outlined,
                              color: Color(0xff3e97bd),
                            ),
                          ))),
                ]),
          )),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey.shade200,
          padding: EdgeInsets.only(top: 52, left: 32, right: 32),
          child: Column(
            children: [
              Container(
                height: 46,
                width: 329,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Container(
                  child: TextFormField(
                    readOnly: true,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchCategory()));
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    'Categorios',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20.0,
                        color: Color(0xFF205065),
                        fontFamily: 'Roboto'),
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
                      height: 40.5,
                      child: new ListView.separated(
                        itemCount: names.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white,
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
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      buttons[index]));
                                        },
                                        child: Image.asset(images[index])),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  buttons[index]));
                                    },
                                    child: Text(
                                      names[index],
                                      style: TextStyle(
                                          color: Color(0xFF205065),
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Roboto'),
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
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    'Recommended',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20.0,
                        color: Color(0xFF205065),
                        fontFamily: 'Roboto'),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: 220,
                      width: 210,
                      // ignore: unnecessary_new
                      child: new ListView.separated(
                        itemCount: names2.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Consumer<WishlistProvider>(
                              builder: (context, wishlist, child) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              recomenddwdbuttons[index]));
                                    },
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.white,
                                              ),
                                              clipBehavior: Clip.hardEdge,
                                              child: Image.asset(
                                                images2[index],
                                                width: 189,
                                                height: 146,
                                                fit: BoxFit.fill,
                                              ),
                                            ),

                                            IconButton(
                                                onPressed: () {
                                                  WishlistItem item =
                                                      WishlistItem(
                                                    name: names2[index],
                                                    locationName: names5[index],
                                                    image: images2[index],
                                                  );

                                                  setState(() {
                                                    favourite[index] =
                                                        !favourite[index];
                                                  });

                                                  if (!favourite[index]) {
                                                    wishlist.addItem(item);
                                                  } else {
                                                    wishlist.deleteItem(item);
                                                  }
                                                  ;
                                                },
                                                icon: CircleAvatar(
                                                  radius: 15.0,
                                                  backgroundColor: Colors.white24,
                                                  child: favourite[index]
                                                      ? Icon(
                                                          Icons.favorite_border,
                                                          color: Colors.red)
                                                      : Icon(
                                                          Icons.favorite,
                                                          color: Colors.red,
                                                        ),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 186,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Expanded(
                                            child: Text(
                                              names2[index],
                                              textAlign: TextAlign.start,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  color: Color(0xFF205065),
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Roboto'),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                              size: 16,
                                            ),
                                            Text(
                                              recommend[index],
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: Color(0xFF205065),
                                                fontSize: 11.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    width: 186,
                                    child: Row(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        const Icon(
                                          Icons.location_on_outlined,
                                          size: 14,
                                          color: Colors.grey,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 0,
                                            ),
                                            child: Text(
                                              names5[index],
                                              style: const TextStyle(
                                                  overflow: TextOverflow.clip,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                              maxLines: 1,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          width: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    'Activities',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20.0,
                        color: Color(0xFF205065),
                        fontFamily: 'Roboto'),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: 110,
                      width: 250,
                      child: new ListView.separated(
                        itemCount: names3.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Consumer<WishlistProvider>(
                              builder: (context, wishlist, child) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        activitybuttons[index]));
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
                                          images3[index],
                                          width: 250,
                                          height: 110,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Container(
                                        width: 250,
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 50,left: 84, right: 77),
                                          child: Text(
                                            names3[index],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Roboto',
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                          alignment: Alignment.topRight,
                                          padding: EdgeInsets.only(
                                            left: 200.0,
                                          ),
                                          child: IconButton(
                                              onPressed: () {
                                                WishlistItem item = WishlistItem(
                                                  name: names3[index],
                                                  locationName: names4[index],
                                                  image: images3[index],
                                                );

                                                setState(() {
                                                  favourite2[index] =
                                                      !favourite2[index];
                                                });
                                                if (!favourite2[index]) {
                                                  wishlist.addItem(item);
                                                } else {
                                                  wishlist.deleteItem(item);
                                                }
                                              },
                                              icon: CircleAvatar(
                                                radius: 15.0,
                                                backgroundColor: favourite2[index]
                                                    ? Colors.white24
                                                    : Colors.white24,
                                                child: favourite2[index]
                                                    ? Icon(Icons.favorite_border,
                                                        color: Colors.red)
                                                    : Icon(
                                                        Icons.favorite,
                                                        color: Colors.red,
                                                      ),
                                              ))),

                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          width: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container();
  }

  getLocation() async {
    loading = true;
    LocationPermission permission = await Geolocator.checkPermission();
    print(permission);
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      LocationPermission rPermission = await Geolocator.requestPermission();
      print(rPermission);
      await getLocation();
    } else {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position!.latitude, position!.longitude);
      placemark = placemarks[0];
      location = " ${placemarks[0].locality}, ${placemarks[0].country}";
      locationTEC.text = location!;
      print(location);
    }
    loading = false;
  }

  setLocation(String val) {
    print('SetCountry $val');
    location = val;
  }
}
