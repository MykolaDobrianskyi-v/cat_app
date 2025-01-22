import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginRepository {
  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookAuth;

  LoginRepository(
      {required GoogleSignIn googleSignIn, required FacebookAuth facebookAuth})
      : _googleSignIn = googleSignIn,
        _facebookAuth = facebookAuth;

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleUser?.authentication;

    if (googleSignInAuthentication == null) {
      print('GOOGLE IS NOT LOGGED IN');
    }

    final credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication?.accessToken,
      idToken: googleSignInAuthentication?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    final LoginResult loginResult = await _facebookAuth.login();

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}
