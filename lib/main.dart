import 'package:flutter/material.dart';
import 'package:userdetails/myUsersPage1.dart';

import 'myUsersPage2.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomeScreen(),
    );
  }
}

class MyHomeScreen extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Container(child: Stack(children: [Column(mainAxisAlignment: MainAxisAlignment.center,children: [
      Container(width: MediaQuery.of(context).size.width,
        child: FlatButton(onPressed: (){
           Navigator.of(context).push(
                   
                    MaterialPageRoute(
                      builder: (context) =>
                          MyUsers1()
                    ),
                  );
        }, child: Text("Go to First Page"),color: Colors.amber,),
      ),
      SizedBox(height: 150,),
       Container(width: MediaQuery.of(context).size.width,
         child: FlatButton(onPressed: (){
            Navigator.of(context).push(
                   MaterialPageRoute(
                      builder: (context) =>
                         MyUsers()
                    ),
                  );
         }, child: Text("Go to Second Page"),color: Colors.blueAccent,),
       )
    ],)],),
      
    );
  }
}