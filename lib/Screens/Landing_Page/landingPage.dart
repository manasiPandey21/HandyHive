import 'package:flutter/material.dart';

class landing extends StatefulWidget {
  const landing({super.key});

  @override
  State<landing> createState() => _landingState();
}

class _landingState extends State<landing> {
  @override
  Widget build(BuildContext context) {
     return Container(
  decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage("assets/554.jpg"),
      fit: BoxFit.cover,
    ),
  ),
  child: Scaffold(
    
    backgroundColor: Colors.transparent,
    
    body:Column(
      
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children:<Widget> [
        SizedBox(height:80,),
         SizedBox(height:80,),
          SizedBox(height:80,),
           SizedBox(height:80,),
            ElevatedButton(
              
              child: Text("Enter as Service Provider"),onPressed: (){},style: ElevatedButton.styleFrom(
               primary:Colors.white,
               backgroundColor: Colors.black, 
               //minimumSize: Size(120,60)
               
           ),),
         
       
       SizedBox(
        height: 30,
       ),
    
         
           ElevatedButton(child: Text("Enter as user"),onPressed: (){},style: ElevatedButton.styleFrom(
               primary:Colors.white,
                backgroundColor: Colors.black, 
               // minimumSize: Size(120,60)
               
           ),),
         
    ],)
),);
  }
}
