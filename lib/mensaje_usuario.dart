import 'package:chatbot/component/mensaje.dart';
import 'package:flutter/material.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';

class MensajeUsuario extends StatelessWidget {
  List<Map<String, dynamic>> messages = [];

  MensajeUsuario({
    Key? key,
    this.messages = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 25, right: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        color: Color.fromRGBO(224, 232, 251, 1),
      ),
      child: ListView.separated(
        itemCount: messages.length,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        separatorBuilder: (_, i) => const SizedBox(height: 10),
        itemBuilder: (context, i) {
          var obj = messages[messages.length - 1 - i];
          return Mensaje(
            message: obj['message'],
            isUserMessage: obj['isUserMessage'],
          );
        },
        reverse: true,
      ),
    );
  }
}
