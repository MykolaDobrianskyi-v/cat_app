import 'package:cat_app/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

class ProfileDatabaseProvider {
  final Database _database;

  ProfileDatabaseProvider({required Database database}) : _database = database;

  Future<void> insertProfile(UserModel user) async {
    await _database.insert(
      'profile',
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<UserModel?> fetchUserProfile() async {
    List<Map<String, dynamic>> maps = await _database.query('profile');
    if (maps.isNotEmpty) {
      return UserModel.fromJson(maps.first);
    }
    return null;
  }
}
