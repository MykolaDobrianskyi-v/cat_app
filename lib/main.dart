import 'package:cat_app/firebase_options.dart';
import 'package:cat_app/repositories/login_repository.dart';
import 'package:cat_app/screens/home/home_page.dart';
import 'package:cat_app/screens/login/bloc/login_bloc.dart';
import 'package:cat_app/screens/login/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LoginBloc(
            auth: FirebaseAuth.instance,
            loginRepository: LoginRepository(
              googleSignIn: GoogleSignIn(),
              facebookAuth: FacebookAuth.instance,
            ),
          ),
        ),
      ],
      child: MaterialApp(
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return const HomePage();
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            return const LoginPage();
          },
        ),
      ),
    );
  }
}
