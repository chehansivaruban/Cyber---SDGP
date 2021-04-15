import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:solarex/screens/Homepage.dart';
import 'package:solarex/widget/sign_up_widget.dart';
import 'package:solarex/provider/google_sign_in.dart';
import 'package:provider/provider.dart';


class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(

      body: ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder:(context, snapshot){
            final  provider = Provider.of<GoogleSignInProvider>(context, listen: false);

            if(provider.isSigningIn){

              return buildLoading();
              
            }else if(snapshot.hasData){

              return HomePage();

            }else{
           
              return SignUpWidget();
            }
            
          },

        ),
      ),
      backgroundColor: Colors.amber,

  ); 

  Widget buildLoading() => Center(child: CircularProgressIndicator());

}
