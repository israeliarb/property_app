import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:property_app/auth/main_page.dart';
import 'package:property_app/constants/colors.dart';
import 'package:property_app/screens/item_register_page.dart';
import 'package:property_app/screens/item_list_page.dart';
import 'package:property_app/screens/user_register_page.dart';
import 'package:property_app/screens/item_list_page.dart' show ItemListPage;

//User currentUser = FirebaseAuth.instance.currentUser!;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Logado como: ${currentUser.email}'),
          MaterialButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (contex) {
                  return const MainPage();
                }),
              );
            },
            color: CustomColor.customBlue,
            child: const Text('Sair'),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserRegisterPage()),
              );
            },
            color: CustomColor.customBlue,
            child: const Text('User'),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ItemRegisterPage()),
              );
            },
            color: CustomColor.customBlue,
            child: const Text('Item'),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ItemListPage()),
              );
            },
            color: CustomColor.customBlue,
            child: const Text('Lista Itens'),
          ),
        ],
      )),
    );
  }
}
