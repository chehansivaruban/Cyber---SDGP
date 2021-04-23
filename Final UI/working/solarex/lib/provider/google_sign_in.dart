import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class GoogleSignInProvider extends ChangeNotifier {

  final googleSignIn = GoogleSignIn();
  late bool _isSignIngIn;

  GoogleSignInProvider() {
    _isSignIngIn = false;
  }

  bool get isSigningIn => _isSignIngIn;

  set isSigningIn(bool isSigningIn){

    _isSignIngIn = isSigningIn;
    notifyListeners();

  }

  // GET UID
  String? getCurrentUEmail() {
    return FirebaseAuth.instance.currentUser!.email;
  }

  String? getCurrentUName() {
    return FirebaseAuth.instance.currentUser!.displayName;
  }

   getProfileImage(){
     
    if(FirebaseAuth.instance.currentUser != null) {
      final user = FirebaseAuth.instance.currentUser;
      return  Container(
                
                decoration: BoxDecoration(
	                shape: BoxShape.circle,
	                image: DecorationImage(
	                  image: NetworkImage(user!.photoURL.toString()),
	                  fit: BoxFit.contain
	                ),
                ),
              );
    } else {
      return 
      Container(
                
                decoration: BoxDecoration(
	                shape: BoxShape.circle,
                  
	              
                ),
                child: Icon(Icons.account_circle, size: 150,
              
                ),
              );
      
      
      
      
    }
  }


  Future login() async {
    isSigningIn = true;

    final user = await googleSignIn.signIn();
    // ignore: unnecessary_null_comparison
    if (user == null){
      isSigningIn = false;
      return;
    }
    else {
      final googleAuth = await user.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      isSigningIn = false;
    }
  }


  void logOut() async{

    bool isSignIn =await googleSignIn.isSignedIn();
    
    FirebaseAuth.instance.signOut();
    if(isSignIn){
      await googleSignIn.disconnect();
    }
    
  }

}
