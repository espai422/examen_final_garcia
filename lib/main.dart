import 'package:examen_final_garcia/firebase_options.dart';
import 'package:examen_final_garcia/models/arbre.dart';
import 'package:examen_final_garcia/provider/provider.dart';
import 'package:examen_final_garcia/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Main function to run the app to initialize the firebase
/// and the preferences
/// Also it initializes the current user provider
/// and then runs the app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

/// Main App to run the app
/// It initializes the providers
/// and then runs the app
class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CurrentUserProvider>(
          create: (context) => CurrentUserProvider(),
        ),
        ChangeNotifierProvider<MapsMarks>(
          create: (context) => MapsMarks(),
        ),
        ChangeNotifierProvider(
            create: (_) => CRUDProvider<Arbre>(
                RTDBCRUDhttp(path: '/arbres', fromMap: Arbre.fromMap))),
      ],
      child: MaterialApp(
        routes: routes,
      ),
    );
  }
}
