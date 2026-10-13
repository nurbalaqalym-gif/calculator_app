import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: CalcApp()));
}

class CalcApp extends StatefulWidget {
  @override
  State<CalcApp> createState() => _CalcState();
}

class _CalcState extends State<CalcApp> {
  String number = '0';
  double firstNumber = 0;
  String operation = '';
  bool newNumber = false;

  void press(String value) {
    setState(() {
      if (value == 'C') {
        number = '0';
        firstNumber = 0;
        operation = '';
        newNumber = false;
      } else if (value == '⌫') {
        if (number.length > 1 && number != 'ERROR') {
          number = number.substring(0, number.length - 1);
        } else {
          number = '0';
        }
      } else if (value == '+' || value == '-' || value == '✕' || value == '÷') {
        firstNumber = double.parse(number);
        operation = value;
        newNumber = true;
      } else if (value == '=') {
        if (operation == '' || number == 'ERROR') return;

        double secondNumber = double.parse(number);
        double result = 0;

        if (operation == '+') {
          result = firstNumber + secondNumber;
        } else if (operation == '-') {
          result = firstNumber - secondNumber;
        } else if (operation == '✕') {
          result = firstNumber * secondNumber;
        } else if (operation == '÷') {
          if (secondNumber == 0) {
            number = 'ERROR';
            operation = '';
            newNumber = true;
            return;
          }
          result = firstNumber / secondNumber;
        }

        number = result == result.toInt()
            ? result.toInt().toString()
            : result.toString();

        operation = '';
        newNumber = true;
      } else {
        if (number == 'ERROR' || newNumber) {
          number = value == '.' ? '0.' : value;
          newNumber = false;
        } else if (value == '.') {
          if (!number.contains('.')) {
            number += '.';
          }
        } else {
          number = number == '0' ? value : number + value;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> buttons = [
      'C',
      '⌫',
      '÷',
      '✕',
      '7',
      '8',
      '9',
      '-',
      '4',
      '5',
      '6',
      '+',
      '1',
      '2',
      '3',
      '=',
      '0',
      '.',
    ];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 244, 195),
      appBar: AppBar(
        title: Text('My calculator', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
      ),

      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(28),
              child: Text(
                number,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.amberAccent,
                ),
              ),
            ),
          ),

          Expanded(
            flex: 5,
            child: GridView.count(
              crossAxisCount: 4,
              padding: EdgeInsets.all(12),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: buttons.map((button) {
                return ElevatedButton(
                  onPressed: () => press(button),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ['+', '-', '÷', '✕', '='].contains(button)
                        ? Colors.amberAccent
                        : Colors.white,

                    foregroundColor: ['+', '-', '÷', '✕', '='].contains(button)
                        ? Colors.white
                        : Colors.amberAccent,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    button,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
