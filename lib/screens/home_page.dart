import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:property_app/auth/main_page.dart';
import 'package:property_app/constants/colors.dart';
import 'package:property_app/screens/item_insert_page.dart';
import 'package:property_app/screens/item_list_page.dart';
import 'package:property_app/screens/user_register_page.dart';
import 'package:property_app/screens/item_list_page.dart' show ItemListPage;

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: CustomColor.customBlue,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const MainPage();
                }),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Logado como: ${currentUser.email}'),
            SizedBox(height: 16),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserRegisterPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: CustomColor.customBlue,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Usuário', style: TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ItemRegisterPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: CustomColor.customBlue,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Item', style: TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ItemListPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: CustomColor.customBlue,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Lista de Itens',
                    style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
