import 'dart:async';

import 'package:flutter/material.dart';

import './gpa_calc.dart';

class GPA extends StatefulWidget {
  const GPA({super.key});

  @override
  GPAState createState() => GPAState();
}

class GPAState extends State<GPA> {
  TextEditingController controller = TextEditingController();
  late int n;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "GPA calculator",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          backgroundColor: const Color.fromARGB(255, 217, 64, 255)),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent, width: 25.0),
            color: Colors.transparent),
        child: ListView(
          children: <Widget>[
            TextField(
              textAlign: TextAlign.center,
              autofocus: true,
              decoration: const InputDecoration(
                  fillColor: Color.fromARGB(255, 217, 64, 255),
                  hintText: "How many subjects did you have ",
                  hintStyle: TextStyle(color: Colors.black54)),
              keyboardType: TextInputType.number,
              controller: controller,
              onChanged: (String str) {
                setState(() {
                  if (controller.text == "") {
                    n = 0;
                  }
                  n = int.parse(controller.text);
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                if (n > 0) {
                  int pass = n;
                  n = 0;
                  controller.text = "";
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => GPAcalc(pass)));
                } else {
                  controller.text = "";
                  alert();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Future<Null> alert() async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('rewind and regret fool !'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You think you are smart?.'),
                Text('Guess what... you are not.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Regret'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
