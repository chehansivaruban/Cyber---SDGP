import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


//import 'package:flutter_signin_button/flutter_signin_button.dart';
//import 'package:solarex/provider/google_sign_in.dart';
//import 'package:provider/provider.dart';
import 'package:solarex/widget/google_sign_up_button.dart';


class SignUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
   Scaffold(
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
            child:Column(
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

                      return 
                    
                        Column(
    children: <Widget>[
       Container(
              margin: const EdgeInsets.fromLTRB(20, 100, 20, 20),
              height: 150,
              child: Image(image: AssetImage("images/Logo.png"),
                 // height: 400,
                  width: 400,
                  fit: BoxFit.contain,),
            ),
            Text('Continue With'),

            GoogleSignUpButtonWidget(),

            Text('or'),
            Container(
              width: constraints.maxWidth*0.8,
              child: 
                    TextField(
    decoration: new InputDecoration(
      hintText: "Username",
      //labelText: "Email",
      labelStyle: new TextStyle(color: const Color(0xFF424242)),
      border: new UnderlineInputBorder(
        borderSide: new BorderSide(
          color: Colors.red
        )
      )
    ),
            ),
              
              
            ),

            Container(
              width: constraints.maxWidth*0.8,
              child: 
                    TextField(
    decoration: new InputDecoration(
      hintText: "Password",
      //labelText: "Email",
      labelStyle: new TextStyle(color: const Color(0xFF424242)),
      border: new UnderlineInputBorder(
        borderSide: new BorderSide(
          color: Colors.red
        )
      )
    ),
            ),
              
              
            ),



            Container(

              alignment: Alignment.center,
              width: constraints.maxWidth*0.8,
              child: 
                    ElevatedButton(


                      onPressed: () {
                     //   Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                      },

                      child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                      child: Text('Log In', style:TextStyle( fontWeight: FontWeight.bold),),

                      ),

                      style: ElevatedButton.styleFrom( shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),),


                    )
              
              
            ),
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
                  print('Terms of Service"');
                }),


              ],
            )
            ),

         


  

            // RichText(
            //     text: TextSpan(
            //         text: "Welcome to ",
            //         style:
            //         TextStyle(fontSize: 25.0,
            //             fontWeight: FontWeight.bold,
            //             color: Colors.black,
            //         ),

            //         children: <TextSpan>[
            //           TextSpan(
            //               text: "SolareX",
            //               style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,color: Colors.black)
            //           )
            //         ]
            //     )
            // ),
            // SizedBox(height: 30.0),


            // Row(
            //   children: <Widget>[


            //     // Container(
            //     //     margin: const EdgeInsets.fromLTRB(40, 0, 10, 0),

            //     //     child: 
            //     // ),

            //     Container(
            //         margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),

            //         child: ElevatedButton(
            //           onPressed: () { },
            //           child: Padding(
            //             padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            //             child: Text('REGISTER', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold )),),

            //           style: ElevatedButton.styleFrom( shape: const RoundedRectangleBorder(
            //             borderRadius: BorderRadius.all(Radius.circular(20.0)),
            //           ),),

            //         )
            //     ),

            //   ],
            // ),

            

             Expanded(
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Text("A Project by Team Cyber", style: TextStyle(color: Colors.black,fontSize: 15.0 ),)
          ),
        ),

           
     
    ],
     

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