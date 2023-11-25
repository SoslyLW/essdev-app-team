import 'package:flutter/material.dart';
import 'package:namer_app/main.dart';
import 'package:provider/provider.dart';
import'package:flutter/src/painting/gradient.dart';
//import'package:form_field_validator/form_field_validator.dart'; 
class RegisterPage extends StatefulWidget {
 @override
 State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
    @override
    Widget build(BuildContext context) {
 return Scaffold(
  body:SingleChildScrollView(
    child: Column(
          crossAxisAlignment:CrossAxisAlignment.center,
          mainAxisAlignment:MainAxisAlignment.center,
    children:[
      SizedBox(height:50,),
          Text('Sign Up',
          style: TextStyle(
            color:  Color(0xff241d0f),
            fontSize: 30,
            fontWeight: FontWeight.bold
                    )
              ),
               Container(
                  padding: EdgeInsets.only(
                    left: 15, right: 15, top: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                   color: Colors.white,),
                   child:Column(
               
               children:[
                
                SizedBox(height:10,width:300),
                SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText:'First Name',
                      labelStyle: TextStyle(color: Colors.black),
                    )
                  )
                ),
                SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText:'Last Name',
                       labelStyle: TextStyle(color: Colors.black),
                    )
                  )
                  ),
                  SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText:'Preferred Name',
                       labelStyle: TextStyle(color: Colors.black),
                    )
                  )
                  ),
                  SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText:'Birthdate(dd/yy/mm)',
                      labelStyle: TextStyle(color: Colors.black),
                    )
                  )
                  ),
                  SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText:'Username',
                      labelStyle: TextStyle(color: Colors.black),
                    )
                  )
                  ),
                  SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText:'Password',
                       labelStyle: TextStyle(color: Colors.black),
                    )
                  )
                  ),
                  SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText:'Password',
                       labelStyle: TextStyle(color: Colors.black),
                    )
                  )
                  ),
                  SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText:'Confirm password',
                       labelStyle: TextStyle(color: Colors.black),
                    )
                  )
                  ),
                  SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText:'Email Address',
                       labelStyle: TextStyle(color: Colors.black),
                    )
                  )
                  ),
                  SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText:'Confirm email address',
                       labelStyle: TextStyle(color: Colors.black),
                    )
                  )
                  ),
                  SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText:'Mailing Adddress',
                       labelStyle: TextStyle(color: Colors.black),
                    )
                  )
                  ),
                  SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText:'Country',
                       labelStyle: TextStyle(color: Colors.black),
                    )
                  )
                  ),
                  SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText:'Province',
                       labelStyle: TextStyle(color: Colors.black),
                    )
                  )
                  ),
                  SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText:'Postal code',
                      labelStyle: TextStyle(color: Colors.black),
                    )
                  )
                  ),
                  SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText:'City',
                       labelStyle: TextStyle(color: Colors.black),
                    )
                  )
                  ),
               ]
               )
               ),
                   SizedBox(height:100,),
          Text('Next',
          style: TextStyle(
            color:  Color(0xff241d0f),
            fontSize: 30,
            fontWeight: FontWeight.bold
                    )
              ),
    ]
                ),
    )
    );
     
    }
    }