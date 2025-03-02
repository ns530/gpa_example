import 'package:flutter/material.dart';

import './gpapage.dart';

class ScorePage extends StatelessWidget {
  final double score;
  const ScorePage(this.score, {super.key});
  @override
  Widget build(BuildContext context) {
    return Material(
        color: const Color.fromARGB(255, 217, 64, 255),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Your GPA is: ",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 50.0)),
            Text(
                score
                    .toStringAsFixed(score.truncateToDouble() == score ? 0 : 3),
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 50.0)),
            IconButton(
              icon: const Icon(Icons.arrow_right),
              color: Colors.white,
              iconSize: 50.0,
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => const GPA()),
                  (Route route) => route == null),
            )
          ],
        ));
  }
}
