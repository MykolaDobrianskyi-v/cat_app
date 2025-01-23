import 'package:cat_app/repositories/login_repository.dart';
import 'package:cat_app/screens/login/bloc/login_bloc.dart';
import 'package:cat_app/widgets/login_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(
          auth: FirebaseAuth.instance,
          loginRepository: LoginRepository(
            googleSignIn: GoogleSignIn(),
            facebookAuth: FacebookAuth.instance,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoginButton(
                    onPressed: () {
                      context.read<LoginBloc>().add(
                            const OnLoginWithGoogle(),
                          );
                    },
                    icon: Icons.g_mobiledata,
                    label: 'Google',
                    backgroundColor: Colors.redAccent,
                  ),
                  const SizedBox(width: 15),
                  const LoginButton(
                    onPressed: null,
                    icon: Icons.facebook,
                    label: 'Facebook',
                    backgroundColor: Colors.blue,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
