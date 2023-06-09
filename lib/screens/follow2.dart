import 'package:flutter/material.dart';
class FollowButton2 extends StatefulWidget {
  @override
  _FollowButton2State createState() => _FollowButton2State();
}

class _FollowButton2State extends State<FollowButton2> {
  bool isFollowing = false;
  void toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 120,
      child: ElevatedButton(
        onPressed: toggleFollow,
        child:Text(
          isFollowing ? 'Following' : 'Follow',
          style: TextStyle(
              color: isFollowing ? Colors.white: Color(0xff3e97bd),
              fontWeight: FontWeight.w500,fontSize: 16,fontFamily: 'Roboto'

          ),
        ),
        style: ElevatedButton.styleFrom(
            primary: isFollowing ? Color(0xff3e97bd) : Colors.white,
            shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(30),)
        ),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Container(
        child: FollowButton2()),
  );
}
