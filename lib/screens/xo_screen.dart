import 'package:flutter/material.dart';

class XOScreen extends StatefulWidget {
  const XOScreen({super.key});

  @override
  State<XOScreen> createState() => _XOScreenState();
}

class _XOScreenState extends State<XOScreen> {
  List<String> plays = [];

  @override
  void initState() {
    plays = List<String>.generate(9, (index) => "");
    super.initState();
  }

  bool xTurn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("XO Game"),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            xTurn ? "X Turn" : "O Turn",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: xTurn ? Colors.green : Colors.red,
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            itemCount: plays.length,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (ctx, i) {
              return InkWell(
                onTap: () {
                  if (xTurn) {
                    checkCouldPlayHere(plays[i])
                        ? plays[i] = "X"
                        : showMessagecantPlay();
                  } else {
                    checkCouldPlayHere(plays[i])
                        ? plays[i] = "O"
                        : showMessagecantPlay();
                  }
                  xTurn = !xTurn;

                  setState(() {});

                  checkGameWin();
                },
                child: Card(
                  color: plays[i] == "X"
                      ? Colors.green
                      : plays[i] == "O"
                          ? Colors.red
                          : Colors.grey,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      plays[i],
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                ),
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              restartRound();
            },
            child: const Text("Restart"),
          ),
        ],
      ),
    );
  }

  void checkGameWin() {
    if (plays[0] == plays[1] && plays[0] == plays[2]) {
      _checkIf_X_Or_O(plays[0]);
    } else if (plays[3] == plays[4] && plays[3] == plays[5]) {
      _checkIf_X_Or_O(plays[3]);
    } else if (plays[6] == plays[7] && plays[6] == plays[8]) {
      _checkIf_X_Or_O(plays[6]);
    } else if (plays[0] == plays[3] && plays[0] == plays[6]) {
      _checkIf_X_Or_O(plays[0]);
    } else if (plays[1] == plays[4] && plays[1] == plays[7]) {
      _checkIf_X_Or_O(plays[1]);
    } else if (plays[2] == plays[5] && plays[2] == plays[8]) {
      _checkIf_X_Or_O(plays[2]);
    } else if (plays[0] == plays[4] && plays[0] == plays[8]) {
      _checkIf_X_Or_O(plays[0]);
    } else if (plays[2] == plays[4] && plays[2] == plays[6]) {
      _checkIf_X_Or_O(plays[2]);
    } else {
      if (plays.every((element) => element == "X" || element == "O")) {
        showDialogWinner("No One Won, it's Drawww!!!");
      }
    }
  }

  _checkIf_X_Or_O(String v) {
    if (v == 'X') {
      showDialogWinner('X Won');
    } else if (v == 'O') {
      showDialogWinner('O Won');
    }
  }

  void showDialogWinner(String message) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) {
          return Dialog(
            child: PopScope(
              onPopInvoked: (v) {
                restartRound();
              },
              child: SizedBox(
                width: 200,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      message,
                      style: const TextStyle(fontSize: 30),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        restartRound();
                        Navigator.pop(context);
                      },
                      child: const Text("Play again"),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  void restartRound() {
    xTurn = true;
    plays = List<String>.generate(9, (index) => '');
    setState(() {});
  }

  void showMessagecantPlay() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Can't Play Here"),
        duration: Duration(milliseconds: 500),
      ),
    );
  }

  bool checkCouldPlayHere(String p) {
    return p != "X" && p != "O";
  }
}
