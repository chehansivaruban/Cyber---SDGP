
// ignore: unused_import
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:solarex/screens/Homepage.dart';
import 'package:solarex/screens/Start.dart';


/*class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final  _formKey = GlobalKey<FormState>();
  
  late String _email;
  late String _password ;

  late bool _loading;


  checkAuthentification() async{

    _auth.authStateChanges().listen((User user) {
      if (user != null){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Start()));
      }
       });


  }
 
  initState(){
   checkAuthentification();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        child: Column(
          children: <Widget>[
            SizedBox(height: 130.0),
            Container(
              child: Form(
                key: _formKey,
                child: Column(


                  children: <Widget>[

                    SizedBox(height: 30.0),

                    Container(
                      child: TextFormField(
                        validator: (value)
                        {
                          if(value!.isEmpty){
                            return 'Enter Email';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email)
                        ),
                        onSaved: (value) => _email = value!

                      ),
                    ),
                    SizedBox(height: 40.0),

                    Container(
                      child: TextFormField(
                        validator: (input)
                        {
                          if(input != null && input.length < 6){
                            return 'Provide Minimum 6 Character';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock)
                        ),
                        obscureText: true,
                        onSaved: (input) => _password = input!

                      ),
                    ),
                    SizedBox(height: 30.0),

                    Container(
                        margin: const EdgeInsets.fromLTRB(40, 0, 10, 0),

                        child: ElevatedButton(


                          onPressed: () {
                            initState();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                          },

                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                            child: Text('LOGIN', style:TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),

                          ),

                          style: ElevatedButton.styleFrom( shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),),


                        )
                    ),

                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
*/