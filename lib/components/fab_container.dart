import 'package:animations/animations.dart';
import 'package:discovery/posts/create_post.dart';
import 'package:discovery/posts/create_reel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FabContainer extends StatelessWidget {
  final Widget? page;
  final IconData icon;
  final bool mini;

  FabContainer({this.page, required this.icon, this.mini = false});

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fade,
      openBuilder: (BuildContext context, VoidCallback _) {
        return page!;
      },
      closedElevation: 4.0,
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(56 / 2),
        ),
      ),
      closedColor: Theme.of(context).scaffoldBackgroundColor,
      closedBuilder: (BuildContext context, VoidCallback openContainer) {
        return FloatingActionButton(
          backgroundColor: Color(0xff3e97bd),
          child: Icon(
            icon,
            color: Colors.white,
          ),
          onPressed: () {
            chooseUpload(context);
          },
          mini: mini,
        );
      },
    );
  }

  chooseUpload(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: .5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Center(
                  child: Text(
                    'What Do you want share?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      color: Color(0xff205065),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  CupertinoIcons.camera_on_rectangle,
                  color:  Color(0xff205065),
                  size: 25.0,
                ),
                title: Text('Make a post', style: TextStyle(
                  fontSize: 16,
                  color:  Color(0xff205065),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto'
                ),),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (_) => CreatePost(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  CupertinoIcons.video_camera,
                  color:  Color(0xff205065),
                  size: 25.0,
                ),
                title: Text('Make a reel', style: TextStyle(
                  fontSize: 16,
                  color:  Color(0xff205065),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto'
                ),),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (_) => CreateReel(),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
