import 'package:flutter/material.dart';


class GetStartBtn extends StatelessWidget {
  const GetStartBtn({
    Key? key,
    required this.size,
    required this.textTheme,
    required this.onPressed,
  }) : super(key: key);

  final Size size;
  final TextTheme textTheme;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(top: 60),
        width: 329,
        height: 46,

        decoration: BoxDecoration(
            color: Color.fromARGB(255, 62, 151, 189), borderRadius: BorderRadius.circular(18)),
          child: InkWell(
          borderRadius: BorderRadius.circular(18.0),
          onTap: onPressed,
        child: Center(
          child: Text("Get Started now", style: TextStyle(
            fontFamily: 'Roboto',
            fontStyle: FontStyle.normal,
            fontWeight:FontWeight.w500,
            fontSize: 16,
            color: Colors.white,
          ),)
        ),
      ),
      ),
    );
  }
}
class SkipBtn extends StatelessWidget {
  const SkipBtn({
    Key? key,
    required this.size,
    required this.textTheme,
    required this.onTap,
  }) : super(key: key);

  final Size size;
  final TextTheme textTheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 60),
      width: 329,
      height: 46,

      decoration: BoxDecoration(
          color: Color.fromARGB(255, 62, 151, 189), borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        borderRadius: BorderRadius.circular(18.0),
        onTap: onTap,
        child: Center(
          child: Text("Skip", style: TextStyle(
              fontFamily: 'Roboto',
            fontStyle: FontStyle.normal,
            fontWeight:FontWeight.w500,
            fontSize: 16,
            color: Colors.white,
          ),),
        ),
      ),
    );
  }
}