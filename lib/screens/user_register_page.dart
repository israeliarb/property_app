import 'package:flutter/material.dart';
import 'package:property_app/auth/main_page.dart';
import 'package:property_app/constants/colors.dart';
import 'package:property_app/constants/custom_border_radius.dart';
import 'package:property_app/constants/custom_sizes.dart';
import 'package:property_app/constants/font_size.dart';
import 'package:property_app/constants/spacing_sizes.dart';
import 'package:property_app/controllers/user_controller.dart';

class UserRegisterPage extends StatefulWidget {
  //final VoidCallback showLoginPage;
  const UserRegisterPage({
    super.key,
    //required this.showLoginPage,
  });

  @override
  State<UserRegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<UserRegisterPage> {
  //Text controllers
  final String _userId = ' ';
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final String _passwordController = 'mudar@123';
  final _registrationController = TextEditingController();
  final _roleController = TextEditingController();
  final _departmentController = TextEditingController();
  bool _isAdmin = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _registrationController.dispose();
    _roleController.dispose();
    _departmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.customBlack,
      appBar: AppBar(
        title: const Text('Cadastro de usuários'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(height: SpacingSizes.md_16),

              const Text(
                'Faça o cadastro do colaborador abaixo',
                style: TextStyle(
                  fontSize: FontSize.l,
                ),
              ),

              const SizedBox(height: SpacingSizes.l_32),

              //Name TextField
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: CustomSizes.size_45),
                child: TextField(
                  controller: _nameController,
                  style: const TextStyle(color: CustomColor.customWhite),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: CustomColor.customLightGrey),
                      borderRadius:
                          BorderRadius.circular(CustomBorderRadius.md_12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: CustomColor.customBlue),
                      borderRadius:
                          BorderRadius.circular(CustomBorderRadius.md_12),
                    ),
                    hintStyle: const TextStyle(color: CustomColor.customWhite),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: CustomSizes.size_45),
                child: TextField(
                  controller: _emailController,
                  style: const TextStyle(color: CustomColor.customWhite),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: CustomColor.customLightGrey),
                      borderRadius:
                          BorderRadius.circular(CustomBorderRadius.md_12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: CustomColor.customBlue),
                      borderRadius:
                          BorderRadius.circular(CustomBorderRadius.md_12),
                    ),
                    hintStyle: const TextStyle(color: CustomColor.customWhite),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: CustomSizes.size_45),
                child: TextField(
                  controller: _registrationController,
                  style: const TextStyle(color: CustomColor.customWhite),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: CustomColor.customLightGrey),
                      borderRadius:
                          BorderRadius.circular(CustomBorderRadius.md_12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: CustomColor.customBlue),
                      borderRadius:
                          BorderRadius.circular(CustomBorderRadius.md_12),
                    ),
                    hintStyle: const TextStyle(color: CustomColor.customWhite),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: CustomSizes.size_45),
                child: TextField(
                  controller: _roleController,
                  style: const TextStyle(color: CustomColor.customWhite),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: CustomColor.customLightGrey),
                      borderRadius:
                          BorderRadius.circular(CustomBorderRadius.md_12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: CustomColor.customBlue),
                      borderRadius:
                          BorderRadius.circular(CustomBorderRadius.md_12),
                    ),
                    hintStyle: const TextStyle(color: CustomColor.customWhite),
                    hintText: 'Cargo',
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
                padding:
                    const EdgeInsets.symmetric(horizontal: CustomSizes.size_45),
                child: TextField(
                  controller: _departmentController,
                  style: const TextStyle(color: CustomColor.customWhite),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: CustomColor.customLightGrey),
                      borderRadius:
                          BorderRadius.circular(CustomBorderRadius.md_12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: CustomColor.customBlue),
                      borderRadius:
                          BorderRadius.circular(CustomBorderRadius.md_12),
                    ),
                    hintStyle: const TextStyle(color: CustomColor.customWhite),
                    hintText: 'Setor',
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
                    value: _isAdmin,
                    onChanged: (newValue) {
                      setState(() {
                        _isAdmin = newValue!;
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

              //Save button
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: CustomSizes.size_45),
                child: GestureDetector(
                  onTap: () {
                    if ((_nameController.text.trim() != "") &&
                        (_emailController.text.trim() != "") &&
                        (_passwordController != "") &&
                        (_registrationController.text.trim() != "") &&
                        (_roleController.text.trim() != "") &&
                        (_departmentController.text.trim() != "")) {
                      signUp(
                        _userId,
                        _nameController.text.trim(),
                        _emailController.text.trim(),
                        _passwordController,
                        _registrationController.text.trim(),
                        _roleController.text.trim(),
                        _departmentController.text.trim(),
                        _isAdmin,
                      );
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              "Erro ao salvar o colaborador",
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
                  child: Container(
                    padding: const EdgeInsets.all(CustomSizes.size_15),
                    decoration: BoxDecoration(
                        color: CustomColor.customBlue,
                        borderRadius:
                            BorderRadius.circular(CustomBorderRadius.md_12)),
                    child: const Center(
                      child: Text(
                        'Salvar',
                        style: TextStyle(
                          color: CustomColor.customWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: FontSize.md,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: SpacingSizes.md_16),

              //Cancel button
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: CustomSizes.size_45),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (contex) {
                        return const MainPage();
                      }),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(CustomSizes.size_15),
                    decoration: BoxDecoration(
                        color: CustomColor.customRed,
                        borderRadius:
                            BorderRadius.circular(CustomBorderRadius.md_12)),
                    child: const Center(
                      child: Text(
                        'Cancelar',
                        style: TextStyle(
                          color: CustomColor.customWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: FontSize.md,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: SpacingSizes.l_32),
            ]),
          ),
        ),
      ),
    );
  }
}
