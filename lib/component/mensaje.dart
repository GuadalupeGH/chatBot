import 'package:flutter/material.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';

class Mensaje extends StatelessWidget {
  final Message message;
  final bool isUserMessage;
  const Mensaje({
    Key? key,
    required this.message,
    this.isUserMessage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: 250),
          child: Container(
            decoration: BoxDecoration(
              color: isUserMessage
                  ? Color.fromRGBO(62, 138, 243, 1)
                  : Colors.white,
              borderRadius: (isUserMessage)
                  ? BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))
                  : BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
            ),
            padding: EdgeInsets.all(10),
            child: Text(
              message.text?.text![0] ?? '',
              style: TextStyle(
                  color: (isUserMessage) ? Colors.white : Colors.black,
                  fontSize: 17),
            ),
          ),
        )
      ],
    );
  }
}
