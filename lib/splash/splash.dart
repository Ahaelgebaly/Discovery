import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'items.dart';
import 'componentss.dart';
import 'package:discovery/landing/landing_page.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;
  List<String> _backgroundImages = [
    "images/splash1.png",
    'images/splash2.jpg',
    'images/splash3.jpeg',
  ];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Widget animation(
    int index,
    int delay,
    Widget child,
  ) {
    if (index == 1) {
      return FadeInDown(
        delay: Duration(milliseconds: delay),
        child: child,
      );
    }
    return FadeInUp(
      delay: Duration(milliseconds: delay),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(_backgroundImages[currentIndex]),
          fit: BoxFit.cover,
        )),
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              /// ---------------------------
              Expanded(
                flex: 3,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: listOfItems.length,
                  onPageChanged: (newIndex) {
                    setState(() {
                      currentIndex = newIndex;
                    });
                  },
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: ((context, index) {
                    return SizedBox(
                      width: size.width,
                      height: size.height,
                      child: Column(
                        children: [
                          /// IMG

                          /// TITLE TEXT
                          Padding(
                              padding: const EdgeInsets.only(
                                top: 104,
                              ),
                              child: animation(
                                index,
                                300,
                                Text(
                                  listOfItems[index].title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 46,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Roboto',
                                    color: Colors.white,
                                  ),
                                ),
                              )),

                          /// SUBTITLE TEXT
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                            ),
                            child: animation(
                              index,
                              500,
                              Text(
                                listOfItems[index].subTitle,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Roboto',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),

              /// ---------------------------
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// PAGE INDICATOR
                    SmoothPageIndicator(
                      controller: pageController,
                      count: listOfItems.length,
                      effect: const ExpandingDotsEffect(activeDotColor: Color.fromARGB(255, 62, 151, 189)

                      ),
                      onDotClicked: (newIndex) {
                        setState(() {
                          currentIndex = newIndex;
                          pageController.animateToPage(newIndex,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        });
                      },
                    ),
                    currentIndex == 2

                        /// GET STARTED BTN
                        ? GetStartBtn(
                            size: size,
                            textTheme: textTheme,
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>  Landing(),
                                  ),
                                      (route) => false);
                            },
                          )

                        /// SKIP BTN
                        : SkipBtn(
                            size: size,
                            textTheme: textTheme,
                            onTap: () {
                              setState(() {
                                pageController.animateToPage(2,
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    curve: Curves.fastOutSlowIn);
                              });
                            },
                          )
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
