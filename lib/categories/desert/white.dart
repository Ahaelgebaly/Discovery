import 'package:flutter/material.dart';
import 'desert.dart';
class white extends StatefulWidget {
  const white({Key? key}) : super(key: key);

  @override
  State<white> createState() => _whiteState();
}

class _whiteState extends State<white> {
  bool _isExpanded = true;
  bool favourite = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:
      SingleChildScrollView(
        child: Container(
          color: Colors.grey.shade200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(35),
                          image: DecorationImage(
                              image: new AssetImage('images/white.jpg'),
                              fit: BoxFit.fill)),
                    )  ,
                    Container(
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.only(
                        left: 39.0, bottom: 48,),
                      child:
                      Text('White Desert',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                    Container(
                        alignment: Alignment.topRight,
                        padding: EdgeInsets.only(
                          right: 39.0,
                          top: 60,
                        ),

                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                favourite =
                                !favourite;
                              });
                            },
                            icon: CircleAvatar(
                              radius: 15.0,
                              backgroundColor: favourite
                                  ? Colors.white24
                                  : Colors.white24,
                              child: favourite
                                  ? Icon(Icons.favorite_border, color: Colors.red)
                                  : Icon(Icons.favorite , color: Colors.red,),
                            ))),
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(
                          left: 39.0,
                          top: 60,
                        ),

                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(
                                  context,
                                  MaterialPageRoute(builder: (context)=> desert())
                              );
                            },
                            icon: CircleAvatar(
                              radius: 15.0,
                              backgroundColor: favourite
                                  ? Colors.white24
                                  : Colors.white24,
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Color(0xff3e97bd),
                              ),
                            ))),
                    Container(
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.only(
                        left: 39.0, bottom: 27,),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color:  Color(0xff3e97bd),
                            size: 15,
                          ),
                          Text('Farafra Oasis',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color:  Color(0xff3e97bd),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto',

                              )
                          )
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      padding: EdgeInsets.only(
                        left: 320.0, bottom: 48,),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 18,
                          ),
                          Text(
                            '(3.8)',
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              /* new Container(
                color: Colors.grey.shade200,
                child: new Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 28, left: 18),
                      child:
                      new Stack(fit: StackFit.loose, children: <Widget>[
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new Container(
                                width: 40.0,
                                height: 40.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    image: new ExactAssetImage(
                                        'images/avatar.png'),
                                    fit: BoxFit.cover,
                                  ),
                                )),
                          ],
                        ),
                      ]),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Padding(
                      padding:EdgeInsets.only(top: 28, ),
                      child: Column(
                        children: [
                          Text(
                            'Monika luka',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Roboto',
                              color: Color(0xff205065),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 38),
                            child: Text(' @moni.loc',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto',
                                color: Color(0xFF9593a8),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 60,
                          ),

                        ],
                      ),
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 28, left: 18),
                      child: Container(
                        width: 110,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child:   Container(
                          width: 120,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white, borderRadius: BorderRadius.circular(7) ,),
                          child: FollowButton2(),

                        ),
                      ),
                    ),

                  ],
                ),

              ),*/
              SizedBox(height: 15,),
              Padding(
                padding:EdgeInsets.only(left: 32,right: 32 ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto',
                        color: Color(0xff205065),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ExpandableText(
                      text:"Sahara el Beyda, the White Desert Protected Area, is a national park in Egypt, "
                          "first established as a protected area in 2002. It is located in the Farafra depression, 45 km (28 mi) north of the town of Qsar El Farafra. Part of the park is in the Farafra Oasis (New Valley Governorate).[1]"
                          "The park is the site of large white chalk rock formations, created through erosion by wind and sand. It is also the site of cliffs (at the northern end of the Farafra Depression), sand dunes (part of the Great Sand Sea), as well as Wadi Hennis and oases at Ain El Maqfi and Ain El Wadi."
                          "White Desert National Park covers an area of 3,010 km2 (1,160 sq mi). The highest point in the park is at El Qess Abu Said at 353 m (1,158 ft) above sea level, and the lowest is at Wadi Hennis at 32 m (105 ft).[2]",
                      maxLines:  20,
                      minLines: 5,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto',
                        color: Color(0xFF9593a8),
                      ),
                      expandText: 'Read less',
                      collapseText: 'Read more',
                      linkColor: Color(0xff3e97bd),
                      onExpand: () {
                        setState(() {
                          _isExpanded = true;
                        });
                      },
                      onCollapse: () {
                        setState(() {
                          _isExpanded = false;
                        });
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(color: Colors.black45,),
                    Text(
                      'How To Get There',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto',
                        color: Color(0xff205065),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ExpandableText(
                      text:"The White Desert is only about 4-5 hours away from Cairo. You can arrange transportation with a driver, or use a local bus. Typically, you will be picked up in the morning from your hotel, spend the night in the oasis (not as charming as it sounds), and depart early the next morning for the desert.",
                      maxLines:  20,
                      minLines: 5,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto',
                        color: Color(0xFF9593a8),
                      ),
                      expandText: 'Read less',
                      collapseText: 'Read more',
                      linkColor: Color(0xff3e97bd),
                      onExpand: () {
                        setState(() {
                          _isExpanded = true;
                        });
                      },
                      onCollapse: () {
                        setState(() {
                          _isExpanded = false;
                        });
                      },
                    ),
                    Divider(color: Colors.black45,),
                    SizedBox(
                      height: 18,
                    ),
                    /*Text(
                      'Comments',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto',
                        color: Color(0xff205065),
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                image: new ExactAssetImage(
                                    'images/Rema.png'),
                                fit: BoxFit.cover,
                              ),
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        Padding(
                          padding:EdgeInsets.only(top: 2, ),
                          child: Column(
                            children: [
                              Text(
                                'Remaa',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Roboto',
                                  color: Color(0xff205065),
                                ),
                              ),
                              Text(
                                '2 days ago',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Roboto',
                                  color: Color(0xFF9593a8),
                                ),
                              ),
                              SizedBox(
                                width: 60,
                              ),


                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Center(
                      child: Container(
                        width: 329,
                        height: 210,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Color.fromARGB(255, 255, 202, 0),
                                    size: 18,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color.fromARGB(255, 255, 202, 0),
                                    size: 18,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color.fromARGB(255, 255, 202, 0),
                                    size: 18,
                                  ),
                                  Icon(
                                    Icons.star_border_outlined,
                                    color: Color.fromARGB(255, 255, 202, 0),
                                    size: 18,
                                  ),
                                  Icon(
                                    Icons.star_border_outlined,
                                    color: Color.fromARGB(255, 255, 202, 0),
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'We took the camels up and then walked the 750 steps up for the last part. it was spiritual and historic.We chose to go in the morning not the overnight where you climb in darkness. At sunrise there is hundreds of people on top when '
                                  'we climbed during the day there was only our tiny group, plus we were had to leave Sharm at 7 in the morning not 2am',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto',
                                color: Color(0xFF9593a8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                image: new ExactAssetImage(
                                    'images/tamara.png'),
                                fit: BoxFit.cover,
                              ),
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        Padding(
                          padding:EdgeInsets.only(top: 2, ),
                          child: Column(
                            children: [
                              Text(
                                'Tamara',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Roboto',
                                  color: Color(0xff205065),
                                ),
                              ),
                              Text(
                                'oct2022',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Roboto',
                                  color: Color(0xFF9593a8),
                                ),
                              ),
                              SizedBox(
                                width: 60,
                              ),


                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Center(
                      child: Container(
                        width: 329,
                        height: 190,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Color.fromARGB(255, 255, 202, 0),
                                    size: 18,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color.fromARGB(255, 255, 202, 0),
                                    size: 18,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color.fromARGB(255, 255, 202, 0),
                                    size: 18,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color.fromARGB(255, 255, 202, 0),
                                    size: 18,
                                  ),
                                  Icon(
                                    Icons.star_border_outlined,
                                    color: Color.fromARGB(255, 255, 202, 0),
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'I loved this night camping at St. Catherine\'s and taking time to meditate.'
                                  ' You can feel the energy vibrating throughout this place and the scenery is stunning. '
                                  'The hike can be challenging if you are sensitive to altitudes but it is definitely doable and without a doubt worth it.'
                                  ' Just take plenty of breaks and bring plenty of water.',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto',
                                color: Color(0xFF9593a8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 18,),*/
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;
  final int minLines;
  final TextStyle style;
  final String expandText;
  final String collapseText;
  final Color linkColor;
  final VoidCallback? onExpand;
  final VoidCallback? onCollapse;

  ExpandableText({
    required this.text,
    required this.maxLines,
    required this.minLines,
    required this.style,
    required this.expandText,
    required this.collapseText,
    required this.linkColor,
    this.onExpand,
    this.onCollapse,
  });

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          maxLines: _isExpanded ? null : widget.maxLines,
          overflow: TextOverflow.ellipsis,
          style: widget.style,
        ),
        InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
            if (_isExpanded) {
              widget.onExpand?.call();
            } else {
              widget.onCollapse?.call();
            }
          },
          child: Text(
            _isExpanded ? widget.collapseText : widget.expandText,
            style: TextStyle(
              color: widget.linkColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}