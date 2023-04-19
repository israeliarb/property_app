import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  final String title;
  final String content;

  const MyAlertDialog({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          child: Text('Confirmar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        /*TextButton(
          child: Text('Confirmar'),
          onPressed: () {
            // Ação a ser realizada quando o usuário pressionar o botão de confirmar.
          },
        ),*/
      ],
    );
  }
}
