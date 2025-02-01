import 'package:cat_app/models/user_model.dart';
import 'package:cat_app/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginRepository {
  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookAuth;
  final UserRepository _userRepository;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginRepository(
      {required GoogleSignIn googleSignIn,
      required FacebookAuth facebookAuth,
      required UserRepository userRepository})
      : _googleSignIn = googleSignIn,
        _facebookAuth = facebookAuth,
        _userRepository = userRepository;

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
    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    final User? firebaseAuth = userCredential.user;
    if (firebaseAuth != null) {
      final user = UserModel(
        id: firebaseAuth.uid.hashCode.toString(),
        image: firebaseAuth.photoURL,
        username: firebaseAuth.displayName ?? 'Unknown',
        email: firebaseAuth.email ?? '',
      );
      _userRepository.insertProfile(user);
    }
    return userCredential;
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      print('SIGNOUT ERROR: ${e}');
    }
  }

  Future<UserCredential> signInWithFacebook() async {
    final LoginResult loginResult = await _facebookAuth.login();

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}
