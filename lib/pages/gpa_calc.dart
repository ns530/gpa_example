import 'dart:async';

import 'package:flutter/material.dart';

import './score_page.dart';

class GPAcalc extends StatefulWidget {
  final int n;

  const GPAcalc(this.n, {super.key});

  @override
  GPAcalcstate createState() => GPAcalcstate();
}

class GPAcalcstate extends State<GPAcalc> {
  final List<String> _items = ['O', 'A+', 'A', 'B+', 'B', 'C', 'P', 'F/Ab/I'];
  final List<String> _itemsCp = ['1', '2', '3', '4', '5'];
  List<String?> _selection = [];
  List<String?> _selectionCp = [];
  late List<int> list;

  @override
  void initState() {
    super.initState();
    _selection = List<String?>.filled(widget.n, null);
    _selectionCp = List<String?>.filled(widget.n, null);
    list = List<int>.generate(widget.n, (i) => i);
  }

  @override
  Widget build(BuildContext context) {
    int sogxc = 0, soc = 0;
    var textFields = <Widget>[];
    bool safeToNavigate = true;
    textFields.add(
      const Row(children: [
        Padding(
          padding: EdgeInsets.only(left: 96.0),
        ),
        Column(children: [
          Text(
            "Grade",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
          ),
        ]),
        Padding(
          padding: EdgeInsets.only(left: 72.0),
        ),
        Column(
          children: [
            Text(
              "Credits",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 25.0),
        ),
      ]),
    );
    for (var i in list) {
      textFields.add(
        Column(
          children: [
            Row(children: [
              Text(
                "Subject ${i + 1}:",
                style: const TextStyle(
                    color: Colors.black87, fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
              ),
              DropdownButton<String>(
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
                hint: Text(
                  "grade ${i + 1}",
                  style: const TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.normal),
                ),
                value: _selection[i],
                items: _items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      textAlign: TextAlign.center,
                    ),
                  );
                }).toList(),
                onChanged: (s) {
                  setState(() {
                    _selection[i] = s;
                  });
                },
              ),
              const Padding(
                padding: EdgeInsets.all(35.0),
              ),
              DropdownButton<String>(
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
                hint: Text(
                  "credit ${i + 1}",
                  style: const TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.normal),
                ),
                value: _selectionCp[i],
                items: _itemsCp.map((String items) {
                  return DropdownMenuItem<String>(
                    value: items,
                    child: Text(
                      items,
                      textAlign: TextAlign.center,
                    ),
                  );
                }).toList(),
                onChanged: (s) {
                  setState(() {
                    _selectionCp[i] = s;
                  });
                },
              ),
            ]),
          ],
        ),
      );
    }

    double res = 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("GPA calculator"),
        backgroundColor: const Color.fromARGB(255, 217, 64, 255),
      ),
      backgroundColor: const Color.fromARGB(255, 249, 229, 255),
      body: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent, width: 30.0)),
        child: ListView(
          children: textFields,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Calculate',
        backgroundColor: const Color.fromARGB(255, 217, 64, 255),
        child: const Icon(Icons.gavel),
        onPressed: () {
          sogxc = 0;
          soc = 0;
          safeToNavigate = true;

          for (int i = 0; i < widget.n; i++) {
            if (_selectionCp[i] == null || _selection[i] == null) {
              safeToNavigate = false;
              continue;
            }
            int r = int.parse(_selectionCp[i]!);
            int gp = calculate(_selection[i]!);
            int cp = r;
            int gxc = gp * cp;
            sogxc += gxc;
            soc += cp;
          }

          if (soc > 0) {
            res = sogxc / soc;
          }

          if (safeToNavigate) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => ScorePage(res),
              ),
            );
          } else {
            alert();
          }
        },
      ),
    );
  }

  int calculate(String a) {
    if (a == "O") return 10;
    if (a == "A+") return 9;
    if (a == "A") return 8;
    if (a == "B+") return 7;
    if (a == "B") return 6;
    if (a == "C") return 5;
    if (a == "P") return 4;
    if (a == "F/Ab/I") return 0;
    return 0;
  }

  Future<void> alert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Rewind and remember'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You have done something terrible.'),
                Text('Go back and reflect on your mistakes.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('give me one more chance'),
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
