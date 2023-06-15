import 'package:flutter/material.dart';
import 'package:discovery/auth/login/login.dart';

import '../auth/register/register.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                'images/cover.png',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 146,
                    height: 46,
                    decoration: BoxDecoration(
                        color: Color(0x66ffffff), borderRadius: BorderRadius.circular(18),border: Border.all(color: Colors.white)),
                    child: MaterialButton(
                      onPressed: ()
                      {

                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register()));
                        });

                      },
                      child: Text('Sign Up',style:TextStyle(color:  Color(
                          0xffffffff)),),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Container(
                    width: 146,
                    height: 46,
                    decoration: BoxDecoration(
                      color: Color(0xff3e97bd), borderRadius: BorderRadius.circular(18),),
                    child: MaterialButton(
                      onPressed: ()
                      {

                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Login()));
                        });

                      },
                      child: Text('Login',style:TextStyle(color:  Color(
                          0xffffffff)),),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),

      ),
    );
  }
}
