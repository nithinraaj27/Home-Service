import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:home_service/main.dart';

class googlesigninclass
{
  static final googlesignin = GoogleSignIn();

  static GoogleSignInAccount? _user;
  static Future googleLogin() async{
    final googleuser = await googlesignin.signIn();
    if(googleuser == null)
      {
        return helpertwo();
      }
    _user = googleuser;

    final googleAuth = await googleuser.authentication;

    final credintial = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    
    await FirebaseAuth.instance.signInWithCredential(credintial).whenComplete(() async=>{
      await FirebaseFirestore.instance.collection("googleusers").doc(FirebaseAuth.instance.currentUser!.uid).set(
         {
           "uid" : FirebaseAuth.instance.currentUser!.uid,
           "Name" : _user!.displayName,
           "E-Mail": _user!.email,
           "Image": _user!.photoUrl,
           "Role" : "user",
         }
        )
    });
  }

  static Future  logout() async{
    String user = FirebaseAuth.instance.currentUser!.uid;
    await googlesignin.disconnect().whenComplete(() async=>{
      await FirebaseFirestore.instance.collection("googleusers").doc(user).delete(),
    });
    FirebaseAuth.instance.signOut();
  }

}
