import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import '../posts/create_post.dart';

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
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=> CreatePost())
            );
          },
          mini: mini,
        );
      },
    );
  }

}
