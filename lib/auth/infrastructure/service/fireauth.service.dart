import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:movirent/auth/domain/dto/sign_in.dto.dart';
import 'package:movirent/auth/domain/dto/sign_up.dto.dart';

class FireAuthService{
  final instance = FirebaseAuth.instance;

  Future<String?> signIn(SignInDTO request) async {
    try {
      final response = await instance.signInWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );
      final user = response.user;
      if (user != null && !user.emailVerified){
        await user.sendEmailVerification();
        return "Pending";
      }
      final idToken = await user?.getIdToken();
      return idToken;
    } catch (e) {
      return null;
    }

  }


  Future<void> resetPassword(String email) async{
    try{
       await instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      return;
    }
  }



  Future<void> signUp(SignUpDTO request) async{
    try{
      await instance.createUserWithEmailAndPassword(
          email: request.email!,
          password:request.password!
      );
    } catch (e){
      throw new Exception("Error while trying to create a user ${e}");
    }

  }
}