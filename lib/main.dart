import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movirent/auth/presentation/providers/profile_provider.dart';
import 'package:movirent/auth/presentation/screens/auth_screen.dart';
import 'package:movirent/shared/presentation/providers/ui_provider.dart';
import 'package:movirent/ui/theme/app_theme.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> ProfileProvider()),
        ChangeNotifierProvider(create: (_) => UiProvider())
      ],
      child: MaterialApp(
        home: AuthScreen(),
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
