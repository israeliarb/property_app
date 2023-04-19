import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:property_app/constants/colors.dart';
import 'package:property_app/constants/custom_border_radius.dart';
import 'package:property_app/constants/custom_sizes.dart';
import 'package:property_app/constants/font_size.dart';
import 'package:property_app/constants/spacing_sizes.dart';

class PasswordRecoveryPage extends StatefulWidget {
  const PasswordRecoveryPage({super.key});

  @override
  State<PasswordRecoveryPage> createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content:
                Text('Link para recuperação da senha foi enviado ao email'),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              e.message.toString(),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.customBlue,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Digite seu email e enviaremos instruções de recuperação',
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: FontSize.l, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: SpacingSizes.md_16),

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
                  borderRadius: BorderRadius.circular(CustomBorderRadius.md_12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: CustomColor.customBlue),
                  borderRadius: BorderRadius.circular(CustomBorderRadius.md_12),
                ),
                hintStyle: const TextStyle(color: CustomColor.customWhite),
                hintText: 'Email',
                filled: true,
                fillColor: CustomColor.customDarkGrey,
              ),
            ),
          ),

          const SizedBox(height: SpacingSizes.sm_10),

          MaterialButton(
            onPressed: passwordReset,
            child: Text('Solicitar link para reset de senha'),
            color: CustomColor.customBlue,
          )
        ],
      ),
    );
  }
}
