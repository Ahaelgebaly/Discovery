import 'package:discovery/models/wishlist_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      appBar: AppBar(title: Text('My Wishlist')),
      body: Consumer<WishlistProvider>(
        builder: (context, wishlist, child) {
          if (wishlist.items.isEmpty) {
            return Center(child: Text('Your wishlist is empty'));
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
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [

                              Container(
                                width: double.infinity,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: Image.asset(
                                  item.image,
                                  width: 189,
                                  height: 146,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              IconButton(
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

                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 186,
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: Expanded(
                                child: Text(
                                  item.name,
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
                                  '(4.9)',
                                  maxLines: 2,
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
                        margin: EdgeInsets.symmetric(horizontal: 25),
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
                                  item.locationName,
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
              },
            );
          }
        },
      ),
    );
  }
}
