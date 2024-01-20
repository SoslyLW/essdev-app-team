import 'package:flutter/material.dart';
import 'package:namer_app/main.dart';
import 'package:namer_app/registerpage.dart';
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
                  children: <Widget>[
                    Text('Forgot Password or Username',
                    style: TextStyle(
                      fontSize:18,
                      color: Colors.red
                    )
                    )
                  ],
                )
                ),
             
                  Column(
                    children: <Widget>[
                      MaterialButton(
                        minWidth: 100,
                        height:30,
                        onPressed:(){
                          Navigator.push(context,MaterialPageRoute(builder:(context)=>MyHomePage()));
                        },
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color:Color(0xFFf5ab00)
                             ),
                             borderRadius:BorderRadius.circular(50)
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Color(0xff241d0f),
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                          )
                        )
                      ),
                    ]
                  ),
                  SizedBox(
                    height:30,
                  ),
                  MaterialButton(
                    minWidth: 100,
                        height:30,
                        onPressed:(){
                           Navigator.push(context,MaterialPageRoute(builder:(context)=>RegisterPage()));
                        },
                        color:Color(0xFFf5ab00),
                        shape:RoundedRectangleBorder(
                          borderRadius:BorderRadius.circular(50)
                          ),
                        child: Text('Sign Up',
                        style:TextStyle(
                           color: Color(0xff241d0f),
                           fontWeight: FontWeight.bold,
                          fontSize: 20
                        ))
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