import 'package:discovery/categories/beaches/dahab.dart';
import 'package:discovery/categories/beaches/shoreOfAgiba.dart';
import 'package:discovery/categories/churche/cave.dart';
import 'package:discovery/categories/churche/saint.dart';
import 'package:discovery/categories/desert/bahariya.dart';
import 'package:discovery/categories/desert/fayoum.dart';
import 'package:discovery/categories/desert/white.dart';
import 'package:discovery/categories/mosque/alaqmar.dart';
import 'package:discovery/categories/mosque/alazhar.dart';
import 'package:discovery/categories/mosque/amr.dart';
import 'package:discovery/categories/museum/national.dart';
import 'package:discovery/categories/museum/royal.dart';
import 'package:discovery/categories/restaurant/charlies.dart';
import 'package:discovery/categories/temple/abosimbel.dart';
import 'package:discovery/categories/temple/hatshepsut.dart';
import 'package:discovery/categories/temple/karnak.dart';
import 'package:discovery/categories/temple/luxor.dart';
import 'package:discovery/screens/searchuser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../categories/beaches/AlexBeach.dart';
import '../categories/beaches/northcoast.dart';
import '../categories/churche/hanging.dart';
import '../categories/desert/siwa.dart';
import '../categories/mosque/mohamedali.dart';
import '../categories/mountains/GalalaMountain.dart';
import '../categories/mountains/SerpalMountain.dart';
import '../categories/mountains/mountmusa.dart';
import '../categories/mountains/saintcatherine.dart';
import '../categories/museum/egypt.dart';
import '../categories/museum/grand.dart';
import '../categories/restaurant/pasta.dart';
import '../categories/restaurant/thecrust.dart';
import 'mainscreen.dart';

final List<Widget> buttons1 = <Widget>[
  SearchCategory(),
  Search(),
];
final List<Color> colors = <Color>[
  Color.fromARGB(100, 241, 251, 255),
  Color.fromARGB(100, 255, 255, 255),
];
final List<String> namess = <String>[
  'Place',
  'Account',
];

class Account {
  final String name;
  final String place;
  final String image;
  final Widget button;

  Account({
    required this.name,
    required this.place,
    required this.image,
    required this.button,
  });
}
final List<Widget> buttons = <Widget>[
  saintcatherine(),
  mountmusa(),
  galala(),
  serpal()
];

final List<Account> accounts = [
  Account(
    name: '  Saint Catherine  ',
    place: 'Sinai',
    image: 'images/saint.webp',
    button: saintcatherine(),
  ),
  Account(
    name: '  Mount Musa',
    place: 'Sinai',
    image: 'images/musa.webp',
    button: mountmusa()
  ),
  Account(
    name: '   Shore Of Agiba',
    place: 'Marsa Matruh',
    image: 'images/agiba.webp',
    button: Agiba()
  ),
  Account(
    name: '   Alexandria Beach',
    place: 'ALexanadria ',
    image: 'images/alex.jpg',
    button: AlexBeach()
  ),
  Account(
    name: '  Dahab',
    place: 'South Sainai',
    image: 'images/dahab.webp',
    button: Dahab()
  ),
  Account(
    name: '  North Coast ',
    place: 'Marsa Matruh',
    image: 'images/north.webp',
    button: NorthCoast()
  ),
  Account(
    name: '  Galala Mountain',
    place: 'Suez Government',
    image: 'images/galala.jpg',
    button: galala()
  ),
  Account(
    name: '   Serpal Mountain ',
    place: 'Wadi Firan , South Sinai',
    image: 'images/serpal.jpg',
    button: serpal()
  ),
  Account(
    name: '   White Desert',
    place: 'Farafra Oasis',
    image: 'images/white.jpg',
    button: white()
  ),
  Account(
    name: '   Bahariya Oasis ',
    place: 'Al wahat Al Bahariya',
    image: 'images/baharia.webp',
    button: bahariya()
  ),
  Account(
    name: '   Mohamed Ali\n   Mosque',
    place: 'Cairo',
    image: 'images/mohamed.jpg',
    button: mohamedali()
  ),
  Account(
    name: '   Al-Aqmar Mosque',
    place: 'Al Moez Street ,Cairo ',
    image: 'images/alaqmar.JPG',
    button: alaqmar()
  ),
  Account(
    name: '   Al-Azhar Mosque ',
    place: 'Cairo',
    image: 'images/alazhar.webp',
    button: alazhar()
  ),
  Account(
    name: '   Amr Ibn Al-Aas\n   Mosque',
    place: 'Cairo',
    image: 'images/amr.JPG',
    button: amr()
  ),
  Account(
    name: '   Fayoum Desert',
    place: 'Fayoum Government',
    image: 'images/fayoum.webp',
    button: fayoum()
  ),
  Account(
    name: '   Siwa',
    place: 'Western Desert ',
    image: 'images/siwa.webp',
    button: siwa()
  ),
  Account(
    name: '   Grand Egyptian\n   Museum ',
    place: 'Giza Al-Ahram Hill',
    image: 'images/mu1.jpg',
    button: grand()
  ),
  Account(
    name: '   The Royal Museum\n   Of Jewelry',
    place: 'ALexandria',
    image: 'images/royal.webp',
    button: royal()
  ),
  Account(
    name: '   Celestial Cathedral',
    place: 'Sharm El-Shaikh',
    image: 'images/Celestial.jpg',
    button: charlies()
  ),
  Account(
    name: '  Saint Gerges Church',
    place: 'Cairo',
    image: 'images/Saint.jpg',
    button: saint()
  ),
  Account(
    name: '   Cave Church        ',
    place: 'Mokattam, Cairo',
    image: 'images/Cave.jpg',
    button: Cave()
  ),
  Account(
    name: '   The Hanging Church\n   Coptic Virgin Mary      ',
    place: 'Cairo',
    image: 'images/hang.jpg',
    button: hanging()
  ),
  Account(
    name: '   Museum Of Egypt',
    place: 'Tahrir Square, Cairo',
    image: 'images/museum.webp',
    button: egypt(),
  ),
  Account(
    name: '   National Musuem\n   Of Egypt',
    place: 'Fustat, Cairo ',
    image: 'images/mu4.jpg',
    button: national()
  ),
  Account(
    name: '    Karnak Temple        ',
    place: 'Luxor',
    image: 'images/karnak.webp',
    button: karnak()
  ),
  Account(
    name: '   Hatshepsut Temple     ',
    place: 'Luxor',
    image: 'images/Hatshepsut .webp',
    button: hatshepsut()
  ),
  Account(
    name: '   Charlie’s        ',
    place: 'El Korba,Cairo',
    image: 'images/charlies.jpg',
    button: charlies()
  ),
  Account(
    name: '   What The Crust     ',
    place: 'Maadi,Cairo',
    image: 'images/thecrust.jpg',
    button: thecrust()
  ),
  Account(
    name: '   O’s Pasta',
    place: 'Zamalek, Cairo',
    image: 'images/os.webp',
    button: pasta()
  ),
  Account(
    name: '   Luxor Temple',
    place: 'Luxor',
    image: 'images/luxor.webp',
    button: luxor()
  ),
  Account(
    name: '   Abo Simbel',
    place: 'Aswan',
    image: 'images/simbel.webp',
    button: abosimbel()
  ),
];

class SearchCategory extends StatefulWidget {
  @override
  _SearchCategoryState createState() => _SearchCategoryState();
}

class _SearchCategoryState extends State<SearchCategory> {
  String _searchText = '';
  final List<bool> favourite = <bool>[
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
  ];
  Widget _buildAccountList() {
    List<Account> filteredAccounts = accounts
        .where((account) =>
            account.name.toLowerCase().contains(_searchText.toLowerCase()) ||
            account.place.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();

    return GestureDetector(
      child: GridView.builder(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        itemCount: filteredAccounts.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 20,
          crossAxisCount: 2,
          childAspectRatio: 2 / 2.24,
        ),
        itemBuilder: (BuildContext context, int index) {
          Account account = filteredAccounts[index];
          return Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (_) => account.button));
                  },
                  child: Container(
                    width: 153,
                    height: 207,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  child: Image.asset(
                                    account.image,
                                    width: 137,
                                    height: 129,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        favourite[index] = !favourite[index];
                                      });
                                    },
                                    icon: CircleAvatar(
                                      radius: 15.0,
                                      backgroundColor: favourite[index]
                                          ? Colors.white24
                                          : Colors.white24,
                                      child: favourite[index]
                                          ? Icon(Icons.favorite_border,
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
                        Container(
                          width: 186,
                          child: Row(
                            children: [
                              Container(
                                child: Expanded(
                                  child: Text(
                                    account.name,
                                    style: TextStyle(
                                        color: Color(0xFF205065),
                                        fontSize: 14.0,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: 186,
                          padding: EdgeInsets.only(left: 7, bottom: 0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                size: 14,
                                color: Color(0xFF205065),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 0,
                                  ),
                                  child: Text(
                                    account.place,
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
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

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
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(CupertinoModalPopupRoute(
                      builder: (_) => TabScreen()));
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Color(0xff3e97bd),
                  ),
                ),
              ),
              SizedBox(
                width: 290,
              ),
            ],
          )),
      body: Container(
        color: Colors.grey.shade200,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: Container(
                width: 329,
                height: 46,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _searchText = value;
                      });
                    },
                    decoration: InputDecoration(
                        hintText: 'Search ..',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Roboto',
                          color: Color(0xFF9593a8),
                        ),
                        border: InputBorder.none),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 140),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                                    padding: const EdgeInsets.all(2.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    buttons1[index]));
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
                                )
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
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: _buildAccountList(),
            ),
          ],
        ),
      ),
    );
  }
}
