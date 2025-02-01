import 'dart:async';

import 'package:cat_app/models/user_model.dart';
import 'package:cat_app/providers/profile_database_provider.dart';

class UserRepository {
  final ProfileDatabaseProvider _databaseProvider;

  UserRepository({required ProfileDatabaseProvider databaseProvider})
      : _databaseProvider = databaseProvider;

  Future<UserModel?> fetchUserProfile() async {
    return _databaseProvider.fetchUserProfile();
  }

  Future<void> insertProfile(UserModel user) async {
    _databaseProvider.insertProfile(user);
  }
}
