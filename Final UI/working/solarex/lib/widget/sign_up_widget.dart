import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:solarex/widget/google_sign_up_button.dart';
import 'package:solarex/widget/SignUp.dart';
import 'package:solarex/provider/SignIn.dart';
import 'package:solarex/screens/Homepage.dart';



import 'package:firebase_auth/firebase_auth.dart';


class SignUpWidget extends StatefulWidget {


  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  SignIn signIn = new SignIn();
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,   //new line
    
     
     //resizeToAvoidBottomInset : false,
     // appBar: AppBar(),
      body: Material(
        type: MaterialType.transparency,
        child:
        
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color.fromARGB(255, 0, 148, 255), Color.fromARGB(255, 0, 255, 163)] //top bottom color
              )
            ),
            child:
            
            Column(
              children: <Widget>[
                Flexible(
                child:FractionallySizedBox(
                  heightFactor: 1.0,
                  widthFactor: 1.0,
                  child: Container(
                    child: LayoutBuilder(
                      builder: (context, constraints){
                      bool resultbool = false;
                      final width = constraints.maxWidth;

                      return  SingleChildScrollView(
      child: Container(
        child: 
                    
                        Column(
                           
    children: <Widget>[
       //Padding(
        // padding: const EdgeInsets.all(8.0),
        SizedBox(height: kToolbarHeight,),
         Container(
          
                margin: const EdgeInsets.fromLTRB(20, 35, 20,5),
                height: constraints.maxHeight*0.15,
                //color: Colors.red,
                child: Image(image: AssetImage("images/Logo.png"),
                   // height: 400,
                    width: 400,
                    fit: BoxFit.contain,),
              ),
      // ),
            Text('Continue With'),

            GoogleSignUpButtonWidget(),

            Text('or'),
            Container(
               height: constraints.maxHeight*0.09,
              width: constraints.maxWidth*0.8,
              child: 
                    TextField(
                      controller: _email,
                      onChanged: (value) {
                  _email = value as TextEditingController; // get value from TextField
                },
                      keyboardType: TextInputType.emailAddress,
    decoration: new InputDecoration(
      hintText: "Email",
      //labelText: "Email",
      labelStyle: new TextStyle(color: const Color(0xFF424242)),
      border: new UnderlineInputBorder(
        borderSide: new BorderSide(
          //color: Colors.red
        )
      )
    ),
            ),
              
              
            ),

            Container(
               height: constraints.maxHeight*0.09,
              width: constraints.maxWidth*0.8,
              child: 
                    TextField(
                      controller: _password,
                      onChanged: (value) {
                  _password = value as TextEditingController; //get value from textField
                },
                      obscureText: true,
    decoration: new InputDecoration(
      hintText: "Password",
      //labelText: "Email",
      labelStyle: new TextStyle(color: const Color(0xFF424242)),
      border: new UnderlineInputBorder(
        borderSide: new BorderSide(
          //color: Colors.red
        )
      )
    ),
            ),
              
              
            ),



            //Padding(
              //padding: const EdgeInsets.all(3.0),
              //child:
               Container(
                 height: constraints.maxHeight*0.09,

                alignment: Alignment.center,
                width: constraints.maxWidth*0.8,
                child: 
                    //  Padding(
                     //   padding: const EdgeInsets.all(12.0),
                     //   child: 
                     ElevatedButton(


                          onPressed: () async {


                              print(_email.text);
                               print(_password.text);


                         //   Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                             final user = await signIn.signInWithEmailPassword(_email.text, _password.text);
                             
                             //.signInWithEmailAndPassword(email: _email.value.toString(), password: _password.value.toString()); //signInWithEmailPassword(_email, _password);
                              if (user == null){
    
                              return;
                              }
                              else {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                              
                              
                              }

      
                          },

                          child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                          child: Text('Log In', style:TextStyle( fontWeight: FontWeight.bold),),

                          ),

                          style: ElevatedButton.styleFrom( shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),),


                        ),
                      ),
                
                
           //   ),
          //  ),
            SizedBox(height: 20.0),

            RichText(
                text: 

            TextSpan(
              children: <TextSpan>[
                             TextSpan(text: "Don't have an account? "),
          TextSpan(
              text: 'Sign In',
              style: TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                }),


              ],
            )
            ),

         


  
            

          //   Expanded(
         // child: 
          SizedBox(height: 200,),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Text("A Project by Team Cyber", style: TextStyle(color: Colors.black,fontSize: 15.0 ),)
          ),
        //),

           
     
    ],
                        )
      )
     

  );
                
                  }
                )
              )
            )
          )
        ]
      )
        )
      )
      );
  }
}

  // SignIn _signIn = new SignIn();
  // final _auth = FirebaseAuth.instance;
  // late String email, password;

  // @override
  // Widget build(BuildContext context) {
  //   return
  //  Scaffold(
  //     resizeToAvoidBottomInset: false,   //new line
    
     
  //    //resizeToAvoidBottomInset : false,
  //    // appBar: AppBar(),
  //     body: Material(
  //       type: MaterialType.transparency,
  //       child:
        
  //         Container(
  //           decoration: BoxDecoration(
  //             gradient: LinearGradient(
  //               begin: Alignment.topCenter,
  //               end: Alignment.bottomCenter,
  //               colors: [Color.fromARGB(255, 0, 148, 255), Color.fromARGB(255, 0, 255, 163)] //top bottom color
  //             )
  //           ),
  //           child:
            
  //           Column(
  //             children: <Widget>[
  //               Flexible(
  //               child:FractionallySizedBox(
  //                 heightFactor: 1.0,
  //                 widthFactor: 1.0,
  //                 child: Container(
  //                   child: LayoutBuilder(
  //                     builder: (context, constraints){
  //                     bool resultbool = false;
  //                     final width = constraints.maxWidth;

  //                     return 
                    
  //                       Column(
                           
  //   children: <Widget>[
  //      Container(
        
  //             margin: const EdgeInsets.fromLTRB(20, 50, 20, 20),
  //             height: constraints.maxHeight*0.2,
  //             color: Colors.red,
  //             child: Image(image: AssetImage("images/Logo.png"),
  //                // height: 400,
  //                 width: 400,
  //                 fit: BoxFit.contain,),
  //           ),
  //           Text('Continue With'),

  //           GoogleSignUpButtonWidget(),

  //           Text('or'),
  //           Container(
  //              height: constraints.maxHeight*0.09,
  //             width: constraints.maxWidth*0.8,
  //             child: 
  //                   TextField(
  //                     onChanged: (value) {
  //                 email = value; // get value from TextField
  //               },
  //                     keyboardType: TextInputType.emailAddress,
  //   decoration: new InputDecoration(
  //     hintText: "Email",
  //     //labelText: "Email",
  //     labelStyle: new TextStyle(color: const Color(0xFF424242)),
  //     border: new UnderlineInputBorder(
  //       borderSide: new BorderSide(
  //         color: Colors.red
  //       )
  //     )
  //   ),
  //           ),
              
              
  //           ),

  //           Container(
  //              height: constraints.maxHeight*0.09,
  //             width: constraints.maxWidth*0.8,
  //             child: 
  //                   TextField(
  //                     onChanged: (value) {
  //                 password = value; //get value from textField
  //               },
  //                     obscureText: true,
  //   decoration: new InputDecoration(
  //     hintText: "Password",
  //     //labelText: "Email",
  //     labelStyle: new TextStyle(color: const Color(0xFF424242)),
  //     border: new UnderlineInputBorder(
  //       borderSide: new BorderSide(
  //         color: Colors.red
  //       )
  //     )
  //   ),
  //           ),
              
              
  //           ),



  //           Container(
  //              height: constraints.maxHeight*0.09,

  //             alignment: Alignment.center,
  //             width: constraints.maxWidth*0.8,
  //             child: 
  //                   ElevatedButton(


  //                     onPressed: () {
  //                    //   Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  //                        final user = _signIn.signInWithEmailPassword(email, password);
  //                         if (user == null){
    
  //                         return;
  //                         }
  //                         else {
  //                           Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                          
                          
  //                         }

      
  //                     },

  //                     child: Padding(
  //                     padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
  //                     child: Text('Log In', style:TextStyle( fontWeight: FontWeight.bold),),

  //                     ),

  //                     style: ElevatedButton.styleFrom( shape: const RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
  //                     ),),


  //                   )
              
              
  //           ),
  //           SizedBox(height: 20.0),

  //           RichText(
  //               text: 

  //           TextSpan(
  //             children: <TextSpan>[
  //                            TextSpan(text: "Don't have an account? "),
  //         TextSpan(
  //             text: 'Sign In',
  //             style: TextStyle(color: Colors.blue),
  //             recognizer: TapGestureRecognizer()
  //               ..onTap = () {
  //                 Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  //               }),


  //             ],
  //           )
  //           ),

         


  
            

//              Expanded(
//           child: Align(
//             alignment: FractionalOffset.bottomCenter,
//             child: Text("A Project by Team Cyber", style: TextStyle(color: Colors.black,fontSize: 15.0 ),)
//           ),
//         ),

           
     
//     ],
     

//   );
                
//                   }
//                 )
//               )
//             )
//           )
//         ]
//       )
//         )
//       )
//       );


   
  
// }
// }