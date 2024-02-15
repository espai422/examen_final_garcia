import 'package:examen_final_garcia/provider/provider.dart';
import 'package:examen_final_garcia/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Screen to login or register the user, it recieves the authProvider as a
/// constructor parameter to handle the authentication logic, by doing this,
/// we can change the authentication method without changing the login screen
/// logic
///
/// Also, it uses the [CurrentUserProvider] to store the current user
///
/// Extra logic when login in or registering can be added in the login and
/// is going to be placed here in the login or register methods after calling
/// the authProvider methods, by doing this, we can keep the auth systems
/// with a single responsibility and the login screen with a single responsibility
/// of handling the UI and the logic of the login screen, keeping the code
/// clean and easy to maintain.
///
/// A Stateful widget is used to handle the state of the inputs and the flags
/// to handle the login and register mode and the keep loged in and remember
/// credentials flags, it think is better to use a stateful widget than a
/// provider because this logic is only going to be used in this screen and
/// is not going to be shared with other screens, so it is better to keep
/// the state in the screen and not in the provider, maybie this file is not
/// really code redeable, but i think it still redeable and easy to maintain.
class LoginScreen extends StatefulWidget {
  final BaseAuth authProvider;
  const LoginScreen({super.key, required BaseAuth authProvider})
      : authProvider = authProvider;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

/// State of the login screen
class _LoginScreenState extends State<LoginScreen> {
  // Controllers for the inputs
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  // Flags to handle the login and register mode
  bool _isLogin = true;
  bool _keepLoged = false;
  bool _remeberCredentials = Preferences.getLastCredentials() != null;

  @override
  void initState() {
    super.initState();
    updateLoginFields();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserProvider =
        Provider.of<CurrentUserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // username input
            !_isLogin
                ? UserNameInput(controller: _userNameController)
                : Container(),
            Gap(),
            // email input
            EmailInput(emailController: _emailController),
            Gap(),
            // password input
            PasswordInput(controller: _passController),
            Gap(),

            authenticateButton(currentUserProvider),

            // toggle login/register
            swhitchAuthMode(),

            // keep loged in
            keepLogedIn(),

            // remember credentials
            rememberCredentials(),
          ],
        ),
      ),
    );
  }

  /// Button to authenticate the user
  ElevatedButton authenticateButton(CurrentUserProvider currentUserProvider) {
    return ElevatedButton(
      onPressed: () async {
        try {
          if (_isLogin) {
            await login(currentUserProvider);
          } else {
            await register(currentUserProvider);
          }
        } catch (e) {
          showInvalidCredentials();
          // throw Exception(e);
        }
      },
      child: Text(_isLogin ? 'Login' : 'Register'),
    );
  }

  /// Dialog to show invalid credentials when there is an error logging in
  Future<dynamic> showInvalidCredentials() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Invalid credentials'),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// Button to switch between login and register
  TextButton swhitchAuthMode() {
    return TextButton(
      onPressed: () {
        setState(() {
          _isLogin = !_isLogin;
          updateLoginFields();
        });
      },
      child: Text(_isLogin
          ? 'Don\'t have an account? Register'
          : 'Already have an account? Login'),
    );
  }

  // Method to update the login fields when switching between login and register
  // or when initializing the screen to show the last credentials used and hide
  // the last credetials when we are in the register mode
  void updateLoginFields() {
    if (!_isLogin) {
      _emailController.text = '';
      _passController.text = '';
    } else {
      final lastLogin = Preferences.getLastCredentials();
      if (lastLogin != null) {
        _emailController.text = lastLogin.email;
        _passController.text = lastLogin.password;
      }
    }
  }

  /// Method to login the user
  Future<void> login(CurrentUserProvider currentUserProvider) async {
    final email = _emailController.text;
    final password = _passController.text;

    final user =
        await widget.authProvider.loginWithEmailAndPassword(email, password);
    currentUserProvider.currentUser = user;

    // Add extra logic when login in here
    if (_keepLoged) {
      Preferences.setLastLogin(user);
    }

    if (_remeberCredentials) {
      Preferences.setLastCredentials(user);
    } else {
      Preferences.removeKeppCredentials();
    }
  }

  /// Method to register the user
  Future<void> register(CurrentUserProvider currentUserProvider) async {
    final email = _emailController.text;
    final password = _passController.text;
    final username = _userNameController.text;

    final user = await widget.authProvider
        .registerWithEmailAndPassowrd(email, password, username);
    currentUserProvider.currentUser = user;

    // add extra logic when registering here
    if (_keepLoged) {
      Preferences.setLastLogin(user);
    }

    if (_remeberCredentials) {
      Preferences.setLastCredentials(user);
    } else {
      Preferences.removeKeppCredentials();
    }
  }

  /// Widget to keep the user loged in
  Widget keepLogedIn() {
    return Row(
      children: [
        Text('Keep me loged in'),
        Checkbox(
          value: _keepLoged,
          onChanged: (bool? value) {
            setState(() {
              _keepLoged = value!;
            });
          },
        ),
      ],
    );
  }

  /// Widget to remember the credentials
  Widget rememberCredentials() {
    return Row(
      children: [
        Text('Remember my credentials'),
        Checkbox(
          value: _remeberCredentials,
          onChanged: (bool? value) {
            setState(() {
              _remeberCredentials = value!;
            });
          },
        ),
      ],
    );
  }
}
