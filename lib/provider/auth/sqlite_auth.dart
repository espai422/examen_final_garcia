import 'package:examen_final_garcia/models/profile_user.dart';
import 'package:examen_final_garcia/provider/auth/auth.dart';
import 'package:examen_final_garcia/provider/databases/db_provider.dart';

class SqliteAuth extends BaseAuth {
  @override
  Future<ProfileUser> loginWithEmailAndPassword(
      String email, String password) async {
    final user = await DBProvider.db.getUserByEmail(email);

    if (user == null || user.password != password) {
      throw Exception('Invalid credentials');
    }

    return user;
  }

  @override
  Future<ProfileUser> registerWithEmailAndPassowrd(
      String email, String password, String userName) async {
    final user = ProfileUser(
      email: email,
      password: password,
      username: userName,
    );

    await DBProvider.db.registerUser(user);

    return user;
  }
}
