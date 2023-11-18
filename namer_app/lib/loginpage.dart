import 'package:flutter/material.dart';
import 'package:namer_app/main.dart';
import 'package:provider/provider.dart';
import'package:flutter/src/painting/gradient.dart';

class LoginPage extends StatefulWidget {
 @override
 State<LoginPage> createState() => _LoginPageState();
}
  class _LoginPageState extends State<LoginPage> {
    @override
  Widget build(BuildContext context) {
  return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.center,
          mainAxisAlignment:MainAxisAlignment.center,
          children:[
          SizedBox(height:100,),
          Text('Login',
          style: TextStyle(
            color:  Color(0xff241d0f),
            fontSize: 30,
            fontWeight: FontWeight.bold
                    )
              ),
          SizedBox(
            height:580,
            width: 400,
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.center,
              mainAxisAlignment:MainAxisAlignment.center,
              children:[
                SizedBox(height:20,),
                Container(
                  width: 250,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText:'Email Address/Username',
                    suffixIcon: Icon(Icons.person,
                      size:17,),
                    )
                  )
                ),
              Container(
                  width: 250,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText:'Password',
                      suffixIcon: Icon(Icons.lock_open_rounded,
                      size: 17,),
                    )
                  )
                ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 40, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Forget Password or Username',
                    style: TextStyle(
                      color: Colors.red
                    )
                    )
                  ],
                )
                ),
              SizedBox(height: 20,),
              GestureDetector(
                child:Container(
                  alignment:Alignment.center ,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: 
                        Color(0xFFf5ab00),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Login',
                    style:TextStyle(
                      color: Color(0xff241d0f),
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    )
                    )
                    )
                  )
                  ),
                  SizedBox(
                    height:30,
                  ),
                  Text('Sign up',
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  )
                  )
              ]
            )
          )
         ] 
         )
        )
  );
      
      }
  }   