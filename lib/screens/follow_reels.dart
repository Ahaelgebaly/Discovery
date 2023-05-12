import 'package:flutter/material.dart';
class Followreels extends StatefulWidget {
  @override
  _FollowreelsState createState() => _FollowreelsState();
}

class _FollowreelsState extends State<Followreels> {
  bool isFollowing = false;
  void toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: toggleFollow,
        child:Text(
          isFollowing ? 'Following' : 'Follow',
          style: TextStyle(
              color:Colors.white,
              fontWeight: FontWeight.w500,fontSize: 10,fontFamily: 'Roboto'

          ),
        ),
        style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(22),side: BorderSide(color: Colors.white))
        ),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Container(
        child: Followreels()),
  );
}
