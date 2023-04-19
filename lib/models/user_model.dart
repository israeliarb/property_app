class UserModel {
  final String id;
  final String name;
  final String email;
  final String password;
  final String registration;
  final String role;
  final String department;
  final bool admin;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.registration,
    required this.role,
    required this.department,
    required this.admin,
  });
}
