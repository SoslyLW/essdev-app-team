import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/painting/gradient.dart';
import 'package:dob_input_field/dob_input_field.dart';
import 'package:email_validator/email_validator.dart' as emailValidator;
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:country_picker/country_picker.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:password_field_validator/password_field_validator.dart';

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
final _emailAddressController = TextEditingController();
final _countryController = TextEditingController();
final _provinceController = TextEditingController();
final _cityController = TextEditingController();
final FirebaseAuth _auth = FirebaseAuth.instance;

class _RegisterPageState extends State<RegisterPage> {
  String _email = "";
  String _password = "";
  String _preferredName = "";
  //Country _selectedCountry = Country.worldWide;
  //Country _selectedState = CSCPickerState(Country.AU);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text('Sign Up',
                    style: TextStyle(
                        color: Color(0xff241d0f),
                        fontSize: 30,
                        fontWeight: FontWeight.bold)),
                Container(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Column(children: [
                      SizedBox(height: 10, width: 300),
                      SizedBox(
                          child: TextFormField(
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          labelText: 'First Name',
                          labelStyle: TextStyle(color: Colors.black),
                          hintText: 'Only Alphabets',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          } else if (value.substring(0, 1) !=
                                  value.substring(0, 1).toUpperCase() ||
                              value.length == 1 ||
                              value != String) {
                            return 'Please enter a valid name';
                          } else {
                            return null;
                          }
                        },
                      )),
                      SizedBox(
                          child: TextFormField(
                        controller: _lastNameController,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                          labelStyle: TextStyle(color: Colors.black),
                          hintText: 'Only Alphabets',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          } else if (value.substring(0, 1) !=
                                  value.substring(0, 1).toUpperCase() ||
                              value.length == 1 ||
                              value != String) {
                            return 'Please enter a valid name';
                          } else {
                            return null;
                          }
                        },
                      )),
                      SizedBox(
                          child: TextFormField(
                        controller: _preferredNameController,
                        decoration: InputDecoration(
                          labelText: 'Preferred Name',
                          labelStyle: TextStyle(color: Colors.black),
                          hintText: 'Eg. Joan',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your preferred name';
                          } else if (value.substring(0, 1) !=
                                  value.substring(0, 1).toUpperCase() ||
                              value.length == 1 ||
                              value != String) {
                            return 'Please enter a valid name';
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            _preferredName = value;
                          });
                        },
                      )),
                      SizedBox(
                          child: TextFormField(
                        controller: _birthdateController,
                        decoration: InputDecoration(
                          labelText: 'Birthdate',
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        onTap: () async {
                          DateTime date = DateTime(1900);
                          // Below line stops keyboard from appearing
                          FocusScope.of(context).requestFocus(new FocusNode());
                          await showDatePicker(
                            context: context,
                            initialDatePickerMode: DatePickerMode.year,
                            initialDate: DateTime
                                .now(), // Add the required initialDate argument
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                        },
                      )),
                      SizedBox(
                          child: TextFormField(
                              controller: _userNameController,
                              decoration: InputDecoration(
                                labelText: 'Username',
                                labelStyle: TextStyle(color: Colors.black),
                                hintText: 'Only Alphabets and Numbers',
                              ))),
                      
                      SizedBox(
                        child: TextFormField(
                      controller: _emailAddressController,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                         } else if (!emailValidator.EmailValidator.validate(value)) {
                           return 'Please enter a valid email address';
                         } 
                       },
                    )),

                      SizedBox(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              obscuringCharacter: "*",
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              child: FlutterPwValidator(
                                controller: _passwordController,
                                minLength: 6,
                                uppercaseCharCount: 2,
                                lowercaseCharCount: 2,
                                numericCharCount: 3,
                                specialCharCount: 1,
                                height: 150,
                                width: 300,
                                onSuccess: () =>
                                    "Your password is strong enough",
                                onFail: () => "Please enter a valid password",
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height:
                                  16), // Add some spacing between the TextFormField and CountryStateCityPicker
                          SizedBox(
                            // Wrap the CountryStateCityPicker with a Container
                            height:
                                300, // Set a fixed height for the CountryStateCityPicker
                            child: CountryStateCityPicker(
                              country: _countryController,
                              state: _provinceController,
                              city: _cityController,
                              dialogColor: Colors.black,
                              textFieldDecoration: InputDecoration(),
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ])),
                SizedBox(
                  height: 100,
                ),
                MaterialButton(
                    minWidth: 100,
                    height: 30,
                    onPressed: () {
                      if (_formkey.currentState!.validate())
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()));
                    },
                    color: Color(0xFFf5ab00),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: Text('Next',
                        style: TextStyle(
                            color: Color(0xff241d0f),
                            fontWeight: FontWeight.bold,
                            fontSize: 20)))
              ]),
        ),
      ),
    );
  }
}
