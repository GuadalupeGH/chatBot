import 'package:chatbot/mensaje_usuario.dart';
import 'package:flutter/material.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _controller = TextEditingController();

  //List<Message> messages = [];
  List<Map<String, dynamic>> messages = [];

  void sendMessage(String text) async {
    final DialogAuthCredentials credentials =
        await DialogAuthCredentials.fromFile("assets/dialog_flow_auth.json");
    final DialogFlowtter _dialogFlowtter =
        DialogFlowtter(credentials: credentials);
    if (text.isEmpty) return;
    setState(() {
      Message userMessage = Message(text: DialogText(text: [text]));
      addMessage(userMessage, true);
    });
    QueryInput query = QueryInput(text: TextInput(text: text));
    DetectIntentResponse res = await _dialogFlowtter.detectIntent(
      queryInput: query,
    );
    if (res.message == null) return;
    setState(() {
      addMessage(res.message!);
    });
  }

  void addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({
      'message': message,
      'isUserMessage': isUserMessage,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Mitología Griega')),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 160,
            width: double.infinity,
            padding: EdgeInsets.only(
              left: 100,
              top: 0,
            ),
            decoration: BoxDecoration(color: Color.fromRGBO(186, 198, 240, 1)),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.topRight,
                  width: 80,
                  height: 80,
                  margin: EdgeInsets.only(right: 25, top: 0),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://comodibujarclub.com/wp-content/uploads/2020/09/dibujo-de-zeus.png'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(50)),
                  padding: EdgeInsets.all(0),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Zeus',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 130),
            padding: EdgeInsets.only(top: 1),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: Color.fromRGBO(224, 232, 251, 1),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26, blurRadius: 20, spreadRadius: 1)
                ]),
            child: Column(
              children: [
                Expanded(child: MensajeUsuario(messages: messages)),
                Container(
                  margin:
                      EdgeInsets.only(bottom: 30, left: 30, right: 30, top: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                            ),
                            controller: _controller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            )),
                      ),
                      IconButton(
                        // color: Colors.white,
                        icon: Icon(
                          Icons.send,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          sendMessage(_controller.text);
                          _controller.clear();
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
