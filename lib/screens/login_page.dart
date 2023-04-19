import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:property_app/constants/colors.dart';
import 'package:property_app/constants/custom_border_radius.dart';
import 'package:property_app/constants/font_size.dart';
import 'package:property_app/constants/custom_sizes.dart';
import 'package:property_app/constants/spacing_sizes.dart';
import 'package:property_app/screens/password_recovery_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.customBlack,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(
                Icons.view_in_ar_outlined,
                size: CustomSizes.size_100,
              ),
              //Image(image: AssetImage('assets/icon/icon.png'), height: 150),
              const SizedBox(height: CustomSizes.size_50),
              //Hello again!
              const Text(
                'Patrimônio',
                style: TextStyle(
                  fontSize: FontSize.xxl,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: SpacingSizes.sm_10),

              const Text(
                'Faça login abaixo',
                style: TextStyle(
                  fontSize: FontSize.l,
                ),
              ),

              const SizedBox(height: SpacingSizes.l_32),

              //Email TextField
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: CustomSizes.size_25),
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
                  ),
                ),
              ),

              const SizedBox(height: SpacingSizes.sm_10),

              //Password TextField
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: CustomSizes.size_25),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
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
                    hintText: 'Password',
                    filled: true,
                    fillColor: CustomColor.customDarkGrey,
                  ),
                ),
              ),

              const SizedBox(height: SpacingSizes.sm_10),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: CustomSizes.size_25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (contex) {
                            return PasswordRecoveryPage();
                          }),
                        );
                      },
                      child: const Text(
                        'Esqueceu sua senha?',
                        style: TextStyle(
                          color: CustomColor.customlightBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: SpacingSizes.sm_10),

              //Sign in button
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: CustomSizes.size_25),
                child: GestureDetector(
                  onTap: signIn,
                  child: Container(
                    padding: const EdgeInsets.all(CustomSizes.size_15),
                    decoration: BoxDecoration(
                        color: CustomColor.customBlue,
                        borderRadius:
                            BorderRadius.circular(CustomBorderRadius.md_12)),
                    child: const Center(
                      child: Text(
                        'Entrar',
                        style: TextStyle(
                          color: CustomColor.customWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: FontSize.l,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: SpacingSizes.l_32),

              //Not a member? Register now
              /*Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Não é um membro?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.showRegisterPage,
                    child: Text(
                      ' Crie uma conta agora',
                      style: TextStyle(
                        color: CustomColor.customlightBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )*/
            ]),
          ),
        ),
      ),
    );
  }
}
