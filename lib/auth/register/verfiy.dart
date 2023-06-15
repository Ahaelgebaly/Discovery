import 'dart:async';
import 'package:discovery/auth/register/profile_pic.dart';
import 'package:discovery/splash/splash.dart';
import 'package:discovery/utils/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool isEmailVerified = false;
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.currentUser?.sendEmailVerification();
    timer =
        Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
  }

  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      Navigator.of(context).pushReplacement(
        CupertinoPageRoute(
          builder: (_) => ProfilePicture(),
        ),
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
            onPressed: () async {
              await firebaseAuth.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => Splash(),
                ),(route) => false,
              );
            },
            icon: CircleAvatar(
              radius: 15.0,
              backgroundColor:Colors.white24,
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color(0xff3e97bd),
              ),
            )),
        toolbarHeight: 50,
        backgroundColor: Colors.grey.shade200,
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.grey.shade200,
        padding: const EdgeInsets.only(
          top: 10.0,
          left: 50.0,
          right: 50.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            SizedBox(
              height: 30,
            ),
            Title(
                color: Color(0xff205065),
                child: Text(
                  'Authorization',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff205065),
                      fontSize: 24),
                )),
            SizedBox(
              height: 64,
            ),


            Center(
              child: Text(
                'We sent an Email verification to  ${auth.currentUser?.email}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Color(0xff205065),
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(
              height: 56,
            ),
            SizedBox(height: 16),
            Center(child: CircularProgressIndicator()),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets
                  .symmetric(horizontal: 32.0),
              child: Center(
                child: Text(
                  'Verifying email....',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 57),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 62, 151, 189),
                borderRadius: BorderRadius.circular(18),
              ),
              child: MaterialButton(
                onPressed: () {
                  try {
                    FirebaseAuth.instance.currentUser
                        ?.sendEmailVerification();
                  } catch (e) {
                    debugPrint('$e');
                  }
                },
                child: Text(
                  'Resend ',
                  style: TextStyle(color: Color(0xffffffff)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}