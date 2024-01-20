import 'package:flutter/material.dart';
import 'package:namer_app/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/painting/gradient.dart';
import 'package:dob_input_field/dob_input_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:country_picker/country_picker.dart';

//import'package:form_field_validator/form_field_validator.dart'; 
class RegisterPage extends StatefulWidget {
 @override
 State<RegisterPage> createState() => _RegisterPageState();
}
//Global key that identifies form widget and allows validation of form
final _formkey = GlobalKey<FormState>();
//Create text controller to retrieve the current value of textfield
final _firstNameController = TextEditingController();
final _lastNameController = TextEditingController();
final _preferredNameController = TextEditingController();
final _birthdateController = TextEditingController();
final _userNameController = TextEditingController();
final _passwordController = TextEditingController();
final _confirmPasswordController = TextEditingController();
final _emailAddressController = TextEditingController();
final _confirmEmailController = TextEditingController();
final _countryController = TextEditingController();
final _provinceController = TextEditingController();
final _postalCodeController = TextEditingController();
final _cityController = TextEditingController();


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
                  child: TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      labelText:'First Name',
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: 'Only Alphabets',
                    ),
                    validator: (value) {
                      if(value == null || value.isEmpty ){
                      return 'Please enter your first name';
                      }
                      else if (value.substring(0,1)!= value.substring(0,1).toUpperCase()|| value.length==1 || value != String){
                        return 'Please enter a valid name';
                      }
                      else{
                        return null;
                      }
                    },
                  )
                ),
                SizedBox(
                  child: TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      labelText:'Last Name',
                       labelStyle: TextStyle(color: Colors.black),
                       hintText: 'Only Alphabets',
                    ),
                    validator: (value) {
                      if(value == null || value.isEmpty ){
                      return 'Please enter your last name';
                      }
                      else if (value.substring(0,1)!= value.substring(0,1).toUpperCase()|| value.length==1 || value != String){
                        return 'Please enter a valid name';
                      }
                      else{
                        return null;
                      }
                    },
                  )
                  ),
                  SizedBox(
                  child: TextFormField(
                    controller: _preferredNameController,
                    decoration: InputDecoration(
                      labelText:'Preferred Name',
                       labelStyle: TextStyle(color: Colors.black),
                       hintText: 'Eg. Joan',
                    ),
                    validator: (value) {
                      if(value == null || value.isEmpty ){
                      return 'Please enter your preferred name';
                      }
                      else if (value.substring(0,1)!= value.substring(0,1).toUpperCase()|| value.length==1 || value != String){
                        return 'Please enter a valid name';
                      }
                      else{
                        return null;
                      }
                    },
                  )
                  ),
                  SizedBox(
                  child: TextFormField(
                    controller: _birthdateController,
                    //firstDate:DateTime(1900),

                    decoration: InputDecoration(
                      labelText:'Birthdate(dd/mm/yyyy)',
                      labelStyle: TextStyle(color: Colors.black),
                    )
                  )
                  ),
                  SizedBox(
                  child: TextFormField(
                    controller:_userNameController,
                    decoration: InputDecoration(
                      labelText:'Username',
                      labelStyle: TextStyle(color: Colors.black),
                    )
                  )
                  ),
                  SizedBox(
                  child: TextFormField(
                    controller:_passwordController,
                    obscureText: true,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      labelText:'Password',
                       labelStyle: TextStyle(color: Colors.black),
                       
                    )
                  )
                  ),
                  SizedBox(
                  child: TextFormField(
                    controller:_confirmPasswordController,
                    obscureText: true,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      labelText:'Confirm Password',
                       labelStyle: TextStyle(color: Colors.black),
                    )
                  )
                  ),
                  SizedBox(
                  child: TextFormField(
                    controller: _emailAddressController,
                    decoration: InputDecoration(
                      labelText:'Email Address',
                       labelStyle: TextStyle(color: Colors.black),
                    ),
                    validator:(value) {
                      if (value == null || value.isEmpty){
                        return'Please enter your email address';
                      }
                      else if (EmailValidator.validate(value)==false){
                        return'Please enter a valid email';
                    }
                    },
                  )
                  ),
                  SizedBox(
                  child: TextFormField(
                    controller:_confirmEmailController,
                    decoration: InputDecoration(
                      labelText:'Confirm email address',
                       labelStyle: TextStyle(color: Colors.black),
                    ),
                    validator:(value){
                      if (value !=_emailAddressController.text){
                        return'Email does not match';
                      }
                      }
                  )
                  ),
                  SizedBox(
                  child: TextFormField(
                    controller:_countryController,
                    decoration: InputDecoration(
                      labelText:'Country',
                       labelStyle: TextStyle(color: Colors.black),
                    )
                  )
                  ),
                  SizedBox(
                  child: TextFormField(
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
           MaterialButton(
                    minWidth: 100,
                        height:30,
                        onPressed:(){
                          if (_formkey.currentState!.validate())
                           Navigator.push(context,MaterialPageRoute(builder:(context)=>MyHomePage()));
                        },
                        color:Color(0xFFf5ab00),
                        shape:RoundedRectangleBorder(
                          borderRadius:BorderRadius.circular(50)
                          ),
                        child: Text('Next',
                        style:TextStyle(
                           color: Color(0xff241d0f),
                           fontWeight: FontWeight.bold,
                          fontSize: 20
                        ))
                  )
              ] 
              ),
    
                ),
 
    );
     
    }
    }

