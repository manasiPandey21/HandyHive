import 'package:flutter/material.dart';

import 'screen1ob.dart';
import 'screen2ob.dart';
import 'screen3ob.dart';




class Welcomepage extends StatefulWidget {
  Welcomepage({key}) : super(key: key);

  @override
  _WelcomepageState createState() => _WelcomepageState();
}

class _WelcomepageState extends State<Welcomepage> {


  PageController controller = PageController();
  int currentPageValue = 0;


final List<Widget> introWidgetsList = <Widget>[
  OnboardingFirst(),
  onBoardingSecond(),
  onBoardingThird(),
  
];

void getChangedPageAndMoveBar(int page) {
  currentPageValue = page;
  setState(() {});
}

  @override
  Widget build(BuildContext context) {
    // final PageController controller = PageController(initialPage: 0);
    return Stack(
  alignment: AlignmentDirectional.bottomCenter,
  children: <Widget>[
    // ignore: missing_required_param
            PageView.builder(
              physics: ClampingScrollPhysics(),
              itemCount: introWidgetsList.length,
              onPageChanged: (int page) {
                getChangedPageAndMoveBar(page);
              },
              controller: controller,
              itemBuilder: (context, index) {
                return introWidgetsList[index];
              },
            ),
    
            Stack(
              alignment: AlignmentDirectional.topStart,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 35),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (int i = 0; i < introWidgetsList.length; i++)
                        if (i == currentPageValue) ...[circleBar(true)] else
                          circleBar(false),
                    ],
                  ),
                ),
              ],
            ),
            
  ],
);
  }
  Widget circleBar(bool isActive) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 150),
    margin: EdgeInsets.symmetric(horizontal: 8),
    height: isActive ? 12 : 8,
    width: isActive ? 12 : 8,
    decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(12))),
  );
}
}
