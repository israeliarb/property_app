import 'package:flutter/material.dart';
import 'package:property_app/constants/colors.dart';
import 'package:property_app/controllers/user_controller.dart';
import 'package:property_app/models/user_model.dart';

class UsersReport extends StatefulWidget {
  @override
  _UsersReportState createState() => _UsersReportState();
}

class _UsersReportState extends State<UsersReport> {
  late Future<List<UserModel>> _usersListFuture;

  @override
  void initState() {
    super.initState();
    _usersListFuture = getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.customBlue,
        title: Text('Users'),
        actions: [],
      ),
      body: Center(
        child: FutureBuilder<List<UserModel>>(
          future: _usersListFuture,
          builder:
              (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
            if (snapshot.hasData) {
              final List<UserModel>? users = snapshot.data;
              return ListView.builder(
                itemCount: users?.length,
                itemBuilder: (BuildContext context, int index) {
                  final UserModel? user = users?[index];
                  return InkWell(
                    onTap: () {
                      _showUserDetails(context, user);
                    },
                    child: ListTile(
                      title: Text(user!.name),
                      subtitle: Text(user.role),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  void _showUserDetails(BuildContext context, UserModel user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(user.name),
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nome: ${user.name}'),
                  Text('Email: ${user.email}'),
                  Text('Matrícula: ${user.registration}'),
                  Text('Cargo: ${user.role}'),
                  Text('Setor: ${user.department}'),
                  Text('Administrador: ${user.admin}'),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
