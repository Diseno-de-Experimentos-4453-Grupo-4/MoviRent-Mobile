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
      if (user != null) {
        final idToken = await user.getIdToken();
        return idToken;
      } else {
        throw Exception("Cannot find access token");
      }
    } catch (e) {
      return null;
    }

  }


  Future<void> signUp(SignUpDTO request) async{
    await instance.createUserWithEmailAndPassword(
        email: request.email!,
        password:request.password!
    );
  }
}