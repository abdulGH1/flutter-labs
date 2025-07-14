import 'package:flutter/material.dart';

void main() => runApp(RecipeCategoriesApp());

class RecipeCategoriesApp extends StatelessWidget {
  const RecipeCategoriesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(child: Text("BROWSE CATEGORIES", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Not sure about exactly which recipe you're looking for? Do a search, or dive into our most popular categories.",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Center(child: Text("BY MEAT", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildStack("beef.jpg", "BEEF"),
                  buildStack("chicken.jpg", "CHICKEN"),
                  buildStack("pork.jpg", "PORK"),
                  buildStack("seaFood.jpg", "SEAFOOD"),
                ],
              ),
              Center(child: Text("BY COURSE", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildStack("mainDish.jpg", "Main Dishes", alignBottom: true),
                  buildStack("salad.jpg", "Salad Recipes", alignBottom: true),
                  buildStack("sideDish.jpg", "Side Dishes", alignBottom: true),
                  buildStack("pot.jpg", "Crockpot", alignBottom: true),
                ],
              ),
              Center(child: Text("BY DESSERT", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildStack("icecream.jpg", "Ice Cream", alignBottom: true),
                  buildStack("brownies.jpg", "Brownies", alignBottom: true),
                  buildStack("pie.jpg", "Pies", alignBottom: true),
                  buildStack("cookies.jpg", "Cookies", alignBottom: true),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStack(String imagePath, String label, {bool alignBottom = false}) {
    return Stack(
      alignment: alignBottom ? Alignment.bottomCenter : Alignment.center,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage('images/$imagePath'),
          radius: 45,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          color: Colors.black54,
          child: Text(
            label,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
