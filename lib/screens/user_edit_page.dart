import 'package:flutter/material.dart';
import 'package:property_app/auth/main_page.dart';
import 'package:property_app/constants/colors.dart';
import 'package:property_app/constants/custom_border_radius.dart';
import 'package:property_app/constants/custom_sizes.dart';
import 'package:property_app/constants/font_size.dart';
import 'package:property_app/constants/spacing_sizes.dart';
import 'package:property_app/controllers/item_controller.dart';
import 'package:intl/intl.dart';
import 'package:property_app/controllers/user_controller.dart';
import 'package:property_app/models/item_model.dart';
import 'package:property_app/models/user_model.dart';
import 'package:property_app/utils/category_types.dart';

class UserEditPage extends StatefulWidget {
  final String userId;
  const UserEditPage({super.key, required this.userId});

  @override
  State<UserEditPage> createState() => _UserEditPageState();
}

class _UserEditPageState extends State<UserEditPage> {
  late UserModel _user;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    UserModel user = await getUser(widget.userId);
    setState(() {
      _user = user;
    });
  }

  //Text controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _registrationController = TextEditingController();
  final _roleController = TextEditingController();
  final _departmentController = TextEditingController();
  bool _admin = true;

  bool showErrorMessage = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _registrationController.dispose();
    _departmentController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  final Map<String, List<String>> category = categoryToTypes;

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return Scaffold(
        backgroundColor: CustomColor.customBlack,
        appBar: AppBar(
          backgroundColor: CustomColor.customBlue,
          title: const Text('Registro de itens'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      _nameController.text = _user.name;
      _emailController.text = _user.email;
      _passwordController.text = _user.password;
      _registrationController.text = _user.registration;
      _roleController.text = _user.role;
      _departmentController.text = _user.department;
      return Scaffold(
        backgroundColor: CustomColor.customBlack,
        appBar: AppBar(
          backgroundColor: CustomColor.customBlue,
          title: const Text('Registro de itens'),
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: SpacingSizes.md_16),

                  const Text(
                    'Faça o cadastro do item abaixo',
                    style: TextStyle(
                      fontSize: FontSize.l,
                    ),
                  ),

                  const SizedBox(height: SpacingSizes.l_32),

                  //Name TextField
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: CustomSizes.size_45),
                    child: TextField(
                      controller: _nameController,
                      style: const TextStyle(color: CustomColor.customWhite),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: CustomColor.customLightGrey),
                          borderRadius:
                              BorderRadius.circular(CustomBorderRadius.md_12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: CustomColor.customBlue),
                          borderRadius:
                              BorderRadius.circular(CustomBorderRadius.md_12),
                        ),
                        hintStyle:
                            const TextStyle(color: CustomColor.customWhite),
                        hintText: 'Nome',
                        filled: true,
                        fillColor: CustomColor.customDarkGrey,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 12.0),
                      ),
                    ),
                  ),

                  const SizedBox(height: SpacingSizes.md_16),

                  //Email TextField
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: CustomSizes.size_45),
                    child: TextField(
                      controller: _emailController,
                      style: const TextStyle(color: CustomColor.customWhite),
                      enabled: false,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: CustomColor.customLightGrey),
                          borderRadius:
                              BorderRadius.circular(CustomBorderRadius.md_12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: CustomColor.customBlue),
                          borderRadius:
                              BorderRadius.circular(CustomBorderRadius.md_12),
                        ),
                        hintStyle:
                            const TextStyle(color: CustomColor.customWhite),
                        hintText: 'Email',
                        filled: true,
                        fillColor: CustomColor.customDarkGrey,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 12.0),
                      ),
                    ),
                  ),

                  const SizedBox(height: SpacingSizes.md_16),

                  //Registration TextField
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: CustomSizes.size_45),
                    child: TextField(
                      controller: _registrationController,
                      style: const TextStyle(color: CustomColor.customWhite),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: CustomColor.customLightGrey),
                          borderRadius:
                              BorderRadius.circular(CustomBorderRadius.md_12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: CustomColor.customBlue),
                          borderRadius:
                              BorderRadius.circular(CustomBorderRadius.md_12),
                        ),
                        hintStyle:
                            const TextStyle(color: CustomColor.customWhite),
                        hintText: 'Matricula',
                        filled: true,
                        fillColor: CustomColor.customDarkGrey,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 12.0),
                      ),
                    ),
                  ),

                  const SizedBox(height: SpacingSizes.md_16),

                  //Role TextField
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: CustomSizes.size_45),
                    child: TextField(
                      controller: _roleController,
                      style: const TextStyle(color: CustomColor.customWhite),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: CustomColor.customLightGrey),
                          borderRadius:
                              BorderRadius.circular(CustomBorderRadius.md_12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: CustomColor.customBlue),
                          borderRadius:
                              BorderRadius.circular(CustomBorderRadius.md_12),
                        ),
                        hintStyle:
                            const TextStyle(color: CustomColor.customWhite),
                        hintText: 'Role',
                        filled: true,
                        fillColor: CustomColor.customDarkGrey,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 12.0),
                      ),
                    ),
                  ),

                  const SizedBox(height: SpacingSizes.md_16),

                  //Department TextField
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: CustomSizes.size_45),
                    child: TextField(
                      controller: _departmentController,
                      style: const TextStyle(color: CustomColor.customWhite),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: CustomColor.customLightGrey),
                          borderRadius:
                              BorderRadius.circular(CustomBorderRadius.md_12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: CustomColor.customBlue),
                          borderRadius:
                              BorderRadius.circular(CustomBorderRadius.md_12),
                        ),
                        hintStyle:
                            const TextStyle(color: CustomColor.customWhite),
                        hintText: 'Department',
                        filled: true,
                        fillColor: CustomColor.customDarkGrey,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 12.0),
                      ),
                    ),
                  ),

                  const SizedBox(height: SpacingSizes.md_16),

                  //Is admin button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: _admin,
                        onChanged: (newValue) {
                          setState(() {
                            _admin = newValue!;
                          });
                        },
                      ),
                      const Text(
                        'Administrador',
                        style: TextStyle(
                          color: CustomColor.customWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: FontSize.md,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: SpacingSizes.md_16),

                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        if ((_nameController.text.trim() != "") &&
                            (_emailController.text.trim() != "") &&
                            (_passwordController.text.trim() != "") &&
                            (_registrationController.text.trim() != "") &&
                            (_roleController.text.trim() != "") &&
                            (_departmentController.text.trim() != "")) {
                          DateTime now =
                              DateTime.now(); // get current timestamp
                          String formattedDate =
                              DateFormat('yyyy-MM-dd HH:mm:ss')
                                  .format(now); // format timestamp as string
                          updateUser(
                            _user.id,
                            _nameController.text.trim(),
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                            _registrationController.text.trim(),
                            _roleController.text.trim(),
                            _departmentController.text.trim(),
                            _admin,
                          );
                          Navigator.popUntil(context, ModalRoute.withName('/'));
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  "Erro ao salvar o usuário",
                                  style: TextStyle(
                                    fontSize: FontSize.l,
                                  ),
                                ),
                                content: const Text(
                                  "Todos os campos devem ser preenchidos",
                                  style: TextStyle(
                                    fontSize: FontSize.sm,
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Ok"),
                                  )
                                ],
                              );
                            },
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: CustomColor.customBlue,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Salvar',
                        style: TextStyle(
                          color: CustomColor.customWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: FontSize.md,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: SpacingSizes.md_16),

                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const MainPage();
                          }),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: CustomColor.customRed,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(
                          color: CustomColor.customWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: FontSize.md,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: SpacingSizes.l_32),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
