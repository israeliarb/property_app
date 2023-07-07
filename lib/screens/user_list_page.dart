import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:property_app/constants/colors.dart';
import 'package:property_app/constants/custom_border_radius.dart';
import 'package:property_app/constants/custom_sizes.dart';
import 'package:property_app/constants/font_size.dart';
import 'package:property_app/constants/spacing_sizes.dart';
import 'package:property_app/screens/user_edit_page.dart';
import 'package:property_app/screens/user_items_screen.dart';
import 'package:property_app/screens/user_register_page.dart';
import 'package:property_app/screens/users_report.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  String? selectedUser;
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Usuários cadastrados no sistema',
          style: TextStyle(
            fontSize: FontSize.l,
          ),
        ),
        backgroundColor: CustomColor.customBlue,
      ),
      body: Column(
        children: [
          const SizedBox(height: SpacingSizes.l_32),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SpacingSizes.l_32,
            ),
            child: Container(
              height: CustomSizes.size_250,
              decoration: BoxDecoration(
                border: Border.all(
                  color: CustomColor.customWhite,
                ),
                borderRadius: BorderRadius.circular(CustomBorderRadius.md_12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchText = value.toLowerCase();
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Pesquisar',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Text('Nenhum item cadastrado.'),
                        );
                      } else {
                        final filteredItems = snapshot.data!.docs
                            .where((document) => document['name']
                                .toLowerCase()
                                .contains(searchText))
                            .toList();

                        return Expanded(
                          child: ListView.builder(
                            itemCount: filteredItems.length,
                            itemBuilder: (context, index) {
                              final document = filteredItems[index];
                              final name = document['name'] as String;
                              final userId = document.id;

                              return SizedBox(
                                height: CustomSizes.size_50,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: SpacingSizes.sm_10,
                                  ),
                                  child: RadioListTile(
                                    title: Text(
                                      document['name'],
                                    ),
                                    value: document.id,
                                    groupValue: selectedUser,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedUser = value.toString();
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: SpacingSizes.l_32),
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
              child: const Text('Adicionar novo usuário',
                  style: TextStyle(fontSize: 18)),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                if (selectedUser == null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Item não selecionado'),
                        content: const Text(
                            'Por favor, selecione um item antes de prosseguir.'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserEditPage(userId: selectedUser!),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                primary: CustomColor.customBlue,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child:
                  const Text('Editar usuário', style: TextStyle(fontSize: 18)),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UsersReport()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: CustomColor.customBlue,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Relatório de usuários',
                  style: TextStyle(fontSize: 18)),
            ),
          ),
          const SizedBox(height: 16),
          /*SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                if (selectedUser == null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Item não selecionado'),
                        content: const Text(
                            'Por favor, selecione um item antes de prosseguir.'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UserItemsScreen(userId: selectedUser!),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                primary: CustomColor.customBlue,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Itens do usuário',
                  style: TextStyle(fontSize: 18)),
            ),
          ),*/
        ],
      ),
    );
  }
}
