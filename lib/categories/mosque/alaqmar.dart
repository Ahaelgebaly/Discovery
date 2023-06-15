import 'package:flutter/material.dart';
import 'mosque.dart';
class alaqmar extends StatefulWidget {
  const alaqmar({Key? key}) : super(key: key);

  @override
  State<alaqmar> createState() => _alaqmarState();
}

class _alaqmarState extends State<alaqmar> {
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
                              image: new AssetImage("images/alaqmar.JPG"),
                              fit: BoxFit.fill)),
                    )  ,
                    Container(
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.only(
                        left: 39.0, bottom: 48,),
                      child:
                      Text('Al-Aqmar Mosque',
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
                                  MaterialPageRoute(builder: (context)=> mosque())
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
                          Text('Al Moez Street, Cairo',
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
                      text:'Al-Aqmar mosque is located on al-Muizz Street, and was commissioned by the Fatimid Caliph al-Amir bi-Ahkam Allah in 519 AH/ 1125 AD. The mosque’s construction was supervised by the Vizier al-Ma’mun al-Bata’ihi, and it was renewed during the reign of Sultan Barquq in 799 AH/ 1397 AD under the supervision of Prince Yalbugha al-Salmi'
                          'The main façade of the mosque is presently one of the oldest surviving stone façades in Egypt. Its architecture is characterized by its intricate stone carvings and the repetition of the phrase “Muhammad and Ali”, in addition to Qur’anic verses written in the Kufic script. The engineer’s ingenuity is most manifest'
                          'in his ability to orient the façade to the direction of the street and maintain the direction of prayer inside the mosque.',
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
                      text:"Aqmar after 10 minutes walking escorted by some of the most interesting Islamic monuments in Egypt",
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