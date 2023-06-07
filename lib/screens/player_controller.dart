
import 'feed_item.dart';
import 'package:flutter/material.dart';

import 'follow_reels.dart';

class PlayerController extends StatefulWidget {
  const PlayerController({Key? key}) : super(key: key);
  @override
  State<PlayerController> createState() => _PlayerControllerState();
}

class _PlayerControllerState extends State<PlayerController> {
  int currentIndex = 0;
  final List<bool> favourite = <bool>[
    true,
    true,
    true,
    true,
    true,
    true,
  ];
  final List<String> images = <String>[
    'images/avatar.png',
    'images/avatar2.png',
    'images/avatar3.png',
    'images/avatar4.png',
    'images/Rema.png',
    'images/tamara.png'
  ];
  final List<String> name = <String>[
    'emma.atson',
    'debra.holt',
    'reema.atson',
    'tamara.frank',
    'monica.hueston',
    'anna.anka'
  ];
  final List<String> likes = <String>[
    '601',
    '234',
    '150',
    '543',
    '286',
    '654',
  ];
  final List<String> comments = <String>[
    '213',
    '180',
    '800',
    '945',
    '247',
    '765',
  ];

  //static content
  final List<String> urls = const [
    'https://assets.mixkit.co/videos/preview/mixkit-the-great-city-of-cairo-in-egypt-45410-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-paddleboarder-1166-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-sun-setting-or-rising-over-palm-trees-1170-large.mp4',
    'https://player.vimeo.com/external/484734621.sd.mp4?s=f08548c4325394a271ff133c1ffb88f3eea8a1f1&profile_id=165&oauth2_token_id=57447761',
    'https://player.vimeo.com/external/483097316.sd.mp4?s=24fafe5a4deebc042826a93a6b1d7dc4a7fb4f71&profile_id=165&oauth2_token_id=57447761',
    'https://player.vimeo.com/progressive_redirect/playback/680936112/rendition/540p?loc=external&oauth2_token_id=57447761&signature=b95427f0d5610c5a5b9ec4984896421f858499c54de1a88e047b0f3f529d7ef3',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: urls.length,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemBuilder: (ctx, index) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 50),
                            Padding(
                              padding: const EdgeInsets.only(right: 70),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    child: Container(
                                        width: 40.0,
                                        height: 40.0,
                                        decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: new DecorationImage(
                                            image: new ExactAssetImage(
                                              images[index],
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                    radius: 16,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    name[index],
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.verified,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    width: 80,
                                    height: 30,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
                                    child: Followreels(),

                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '   If the world really looks like that I will paint no more!',
                              style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  Icons.music_note,
                                  size: 15,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Original Audio - some music track--',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            children: [
                              IconButton(
                              onPressed: () {
                        setState(() {
                        favourite[index] =
                        !favourite[index];
                        });
                        },
                            icon: favourite[index]
                                ? Icon(Icons.favorite_border, color: Colors.white)
                                : Icon(Icons.favorite , color: Colors.red,)),
                              Text(
                                likes[index],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11),
                              ),
                              SizedBox(height: 20),
                              Icon(
                                Icons.comment_rounded,
                                color: Colors.white,
                              ),
                              Text(
                                comments[index],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11),
                              ),
                              SizedBox(height: 20),
                              Transform(
                                transform: Matrix4.rotationZ(5.8),
                                child: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
