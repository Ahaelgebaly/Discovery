import 'package:discovery/models/wishlist_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/menu.dart';
import '../view_models/wishlist/wishlist_view_model.dart';

class WishlistScreen extends StatefulWidget {
  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final List<bool> favourite = <bool>[
    true,
    true,
    true,
    true,
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
                    Navigator.pop(context,
                        MaterialPageRoute(builder: (context) => menu()));
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
                  Text("My Favourite",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(31, 80, 100, 1),
                        fontFamily: 'Roboto',
                        height: 1,
                      )),
                ],
              ),
            ],
          )),
      body: Consumer<WishlistProvider>(
        builder: (context, wishlist, child) {
          if (wishlist.items.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    width: 300,
                    height: 40,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),
                    child: Center(
                        child: Text(
                      'Your Favourite List Is Empty',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(31, 80, 100, 1),
                      ),
                    )),
                  ),
                ),
              ],
            );
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 20,
                );
              },
              itemCount: wishlist.items.length,
              itemBuilder: (context, index) {
                final item = wishlist.items[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 32,right: 32),
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
                            width: 390,
                            height: 135,
                            child: Image.asset(
                              item.image,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 20.0, bottom: 25.0),
                            child:
                            Text(
                              item.name,
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

                                    wishlist.deleteItem(item);
                                  },
                                  icon: CircleAvatar(
                                    radius: 15.0,
                                    backgroundColor: Colors.white24,
                                    child: favourite[index]
                                        ? Icon(
                                        Icons.favorite,
                                        color: Colors.red)
                                        : Icon(
                                      Icons.favorite_border,
                                      color: Colors.red,
                                    ),
                                  )),
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
                                Text(item.locationName,
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
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
