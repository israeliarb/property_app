import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:property_app/auth/main_page.dart';
import 'package:property_app/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final db = FirebaseFirestore.instance;
final fb = FirebaseStorage.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
    options: const FirebaseOptions(
      apiKey: "AIzaSyBAEearXiaoAI5n5NYBcHSZgPrgjRdicOc",
      appId: "1:58059103944:web:ce11e00b123b86d0958ffd",
      messagingSenderId: "58059103944",
      projectId: "tempo-property-app",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
      theme: _buildTheme(Brightness.dark),
    );
  }

  ThemeData _buildTheme(brightness) {
    var baseTheme = ThemeData(
      brightness: brightness,
      useMaterial3: true,
      scaffoldBackgroundColor: CustomColor.customBlack,
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.latoTextTheme(baseTheme.textTheme),
    );
  }
}
