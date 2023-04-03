import 'package:flutter/material.dart';

class dashBoard extends StatefulWidget {
  const dashBoard({super.key});

  @override
  State<dashBoard> createState() => _dashBoardState();
}

class _dashBoardState extends State<dashBoard> {
  @override
  Widget build(BuildContext context) {
    
  const iconSize = 50;
  return Scaffold(
    appBar: AppBar(title: Text('Stack with LayoutBuilder')),
    body: LayoutBuilder(
      builder: (context, constraints) =>
        Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Material(color: Colors.yellowAccent),
            Positioned(
              top: 0,
              child: Icon(Icons.star, size: 50),
            ),
            Positioned(
              top: constraints.maxHeight - iconSize,
              left: constraints.maxWidth - iconSize,
              child: Icon(Icons.call, size: 50),
            ),
          ],
        ),
    ),
  );
}
  
}
