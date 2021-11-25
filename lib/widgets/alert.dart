import 'package:flutter/material.dart';

class AlertBoxWidget extends StatelessWidget {
  const AlertBoxWidget({Key? key, required this.path}) : super(key: key);
  final String path;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.limeAccent,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          Text(
            "Picture captured ",
            style: TextStyle(fontFamily: "Brand Bold"),
          ),
          Icon(
            Icons.done,
            color: Colors.green,
          ),
        ],
      ),
      content: Text(
        path,
        style: TextStyle(),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Thanks!"),
        ),
      ],
    );
  }
}
