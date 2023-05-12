import 'package:discovery/main.dart';


class Items {
  final String title;
  final String subTitle;

  ///
  Items({

    required this.title,
    required this.subTitle,
  });
}

List<Items> listOfItems = [
  Items(

    title: "Discovery",
    subTitle:
    "Looking For New Places To Visit? \n We\'ve Got Your Coverd",
  ),
  Items(

    title: "Discovery",
    subTitle:
    "Plan Your Trip And Explore The Beauty \n Of Egypt With Us",
  ),
  Items(

    title: "Discovery",
    subTitle: "Promote Your Favourite Places With Us..",
  ),
];