import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:property_app/main.dart';
import 'package:property_app/models/user_model.dart';

Future signUp(
  String id,
  String name,
  String email,
  String password,
  String registration,
  String role,
  String department,
  bool admin,
) async {
  UserModel newUser = UserModel(
    id: id,
    name: name,
    email: email,
    password: password,
    registration: registration,
    role: role,
    department: department,
    admin: admin,
  );

  try {
    //Create user
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    //Add user details
    addUserDetails(
      newUser,
    );
  } catch (e) {
    print(e);
  }
}

void addUserDetails(UserModel user) async {
  await db.collection('users').add({
    'name': user.name,
    'email': user.email,
    'password': user.password,
    'registration': user.registration,
    'role': user.role,
    'department': user.department,
    'admin': user.admin,
  });
}

//Get list of users
Future<List<UserModel>> getUsers() async {
  final QuerySnapshot snapshot = await db.collection('users').get();

  final List<UserModel> users = [];

  for (var doc in snapshot.docs) {
    users.add(UserModel(
      id: doc.id,
      name: doc['name'],
      email: doc['email'],
      password: doc['password'],
      registration: doc['registration'],
      role: doc['role'],
      department: doc['department'],
      admin: doc['admin'],
    ));
  }

  return users;
}

Future<UserModel> getUser(String userId) async {
  final DocumentSnapshot snapshot =
      await db.collection('users').doc(userId).get();

  if (snapshot.exists) {
    final user = UserModel(
      id: snapshot.id,
      name: snapshot['name'],
      email: snapshot['email'],
      password: snapshot['password'],
      registration: snapshot['registration'],
      role: snapshot['role'],
      department: snapshot['department'],
      admin: snapshot['admin'],
    );

    return user;
  } else {
    throw Exception('Usuário não encontrado');
  }
}
