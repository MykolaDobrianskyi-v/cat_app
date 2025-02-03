import 'package:cat_app/client/dio_client.dart';
import 'package:cat_app/firebase_options.dart';
import 'package:cat_app/helper/database_helper.dart';
import 'package:cat_app/helper/network_helper.dart';
import 'package:cat_app/providers/cat_api_provider.dart';
import 'package:cat_app/providers/cat_database_provider.dart';
import 'package:cat_app/providers/cat_facts_provider.dart';
import 'package:cat_app/providers/profile_database_provider.dart';
import 'package:cat_app/repositories/cat_repository.dart';
import 'package:cat_app/repositories/login_repository.dart';
import 'package:cat_app/repositories/user_repository.dart';
import 'package:cat_app/screens/cat_list/bloc/cat_list_bloc.dart';
import 'package:cat_app/screens/favorite/bloc/favorite_cats_bloc.dart';
import 'package:cat_app/screens/home/home_page.dart';
import 'package:cat_app/screens/login/bloc/login_bloc.dart';
import 'package:cat_app/screens/login/login_page.dart';
import 'package:cat_app/screens/profile/bloc/profile_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final Database database = await DatabaseHelper.initDatabase();
  runApp(MainApp(
    database: database,
  ));
}

class MainApp extends StatelessWidget {
  final Database database;
  const MainApp({
    super.key,
    required this.database,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => UserRepository(
            databaseProvider: ProfileDatabaseProvider(database: database),
          ),
        ),
        RepositoryProvider(create: (context) => FirebaseAuth.instance),
        RepositoryProvider(create: (context) => database),
        RepositoryProvider(create: (context) => CatApiClient(dio: Dio())),
        RepositoryProvider(create: (context) => CatFactsClient(dio: Dio())),
        RepositoryProvider(
            create: (context) => CatFactsProvider(client: context.read())),
        RepositoryProvider(
          create: (context) => CatDatabaseProvider(
            database: context.read(),
          ),
        ),
        RepositoryProvider(create: (context) => NetworkHelper()),
        RepositoryProvider(
          create: (context) => CatApiProvider(
            dio: context.read(),
          ),
        ),
        RepositoryProvider(
          create: (context) => CatRepository(
            userRepository: context.read(),
            networkHelper: context.read(),
            catFactsProvider: context.read(),
            auth: context.read(),
            catApiProvider: context.read(),
            catDatabaseProvider: context.read(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => LoginBloc(
              auth: FirebaseAuth.instance,
              loginRepository: LoginRepository(
                userRepository: UserRepository(
                    databaseProvider:
                        ProfileDatabaseProvider(database: database)),
                googleSignIn: GoogleSignIn(),
                facebookAuth: FacebookAuth.instance,
              ),
            ),
          ),
          BlocProvider(
            create: (context) => CatListBloc(
              networkHelper: context.read(),
              catRepository: context.read(),
            ),
          ),
          BlocProvider(
            create: (context) => FavoriteCatsBloc(
              catRepository: context.read(),
            ),
          ),
          BlocProvider(
              create: (context) => ProfileBloc(userRepository: context.read()))
        ],
        child: MaterialApp(
          home: StreamBuilder(
            stream: Connectivity().onConnectivityChanged,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              if (snapshot.data?.contains(ConnectivityResult.wifi) == false &&
                  snapshot.data?.contains(ConnectivityResult.mobile) == false) {
                return const HomePage();
              }

              return StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, AsyncSnapshot<User?> snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return const HomePage();
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  return const LoginPage();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
