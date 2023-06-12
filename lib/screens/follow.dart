import 'package:flutter/material.dart';
class FollowButton extends StatefulWidget {
  @override
  _FollowButtonState createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  bool isFollowing = false;
  void toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43,
      width: 117,
      child: ElevatedButton(
        onPressed: toggleFollow,
        child:Text(
          isFollowing ? 'Unfollow' : 'Follow',
          style: TextStyle(
              color: isFollowing ? Color(0xff3e97bd): Colors.white,
              fontWeight: FontWeight.w500,fontSize: 16,fontFamily: 'Roboto'

          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: isFollowing ? Colors.white : Color(0xff3e97bd),
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
        child: FollowButton()),
  );
}

