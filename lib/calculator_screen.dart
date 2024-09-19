import 'package:calculator/button_values.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {

  String number1 = "";
  String operand = "";
  String number2 = "";

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
        children: [
        //Output
        Expanded(
          child: SingleChildScrollView(
            reverse: true,
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(16),
              child: Text(
                "$number1$operand$number2".isEmpty ? "0"
                :"$number1$operand$number2",
                style: const TextStyle(
                fontSize: 55,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.end,
                    ),
            ),
          ),
        ),

          //Buttons
        Wrap(
          children: Btn.buttonValues
              .map(
                (value) => SizedBox(
                  width: value == Btn.n0?screenSize.width/2 : screenSize.width/4,
                  height: screenSize.width/5,
                  child: buildButton(value),
                )
              )
              .toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildButton(value){
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Material(
        color: getBtnColor(value),
        clipBehavior: Clip.hardEdge,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(150),
            borderSide: const BorderSide(color: Colors.white10
            ),
          ),
          child: InkWell(
            onTap: () => onBtnTap(value),
            child: Center(
              child: Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              )
            ),
          ),
        ),
    );
  }

  void onBtnTap(String value){

    if(value == Btn.clr){
      clearAll();
      return;
    }

    if(value == Btn.del){
      delete();
      return;
    }

    if(value == Btn.per){
      convertToPer();
      return;
    }

    if(value == Btn.calculate){
      calculate();
      return;
    }

    appendValue(value);
  }
  void calculate(){
    if(number1.isEmpty) return;
    if(operand.isEmpty) return;
    if(number2.isEmpty) return;

    double num1 = double.parse(number1);
    double num2 = double.parse(number2);
    var result = 0.0;

    switch (operand){
      case Btn.add:
        result = num1 + num2;
        break;
      case Btn.subtract:
        result = num1 - num2;
        break;
      case Btn.multiply:
        result = num1 * num2;
        break;
      case Btn.divide:
        result = num1 / num2;
        break;
      default:

    }
    setState(() {
      number1 = "$result";
      if(number1.endsWith(".0")){
        number1 = number1.substring(0, number1.length - 2);
      }
      operand = "";
      number2 = "";
    });
  }

  void convertToPer(){
    if(number1.isNotEmpty && number2.isNotEmpty && operand.isNotEmpty){
      calculate();
    }
    if(operand.isNotEmpty){
      return;
    }
    final number = double.parse(number1);
    setState(() {
      number1 = "${(number / 100)}";
      operand = "";
      number2 = "";
    });
  }

  void clearAll(){
    setState(() {
      number1 = "";
      operand = "";
      number2 = "";

    });
  }

  void delete(){
    if(number2.isNotEmpty){
      number2 = number2.substring(0, number2.length - 1);
    }else if(operand.isNotEmpty){
      operand = "";
    }
    else if(number1.isNotEmpty){
      number1 = number1.substring(0, number1.length - 1);
    }

    setState(() {});
  }

  void appendValue(String value) {
    if (value != Btn.dot && int.tryParse(value) == null) {
      if (value == Btn.subtract && (number1.isEmpty && operand.isEmpty)) {
        number1 += "-";
        setState(() {});
        return;
      }
      if (value == Btn.subtract && (number2.isEmpty && operand.isNotEmpty)) {
        number2 += "-";
        setState(() {});
        return;
      }
      if (operand.isNotEmpty && number2.isNotEmpty) {
        calculate();
      }
      operand = value;
    } else if (number1.isEmpty || operand.isEmpty) {
      if (value == Btn.dot && number1.contains(Btn.dot)) return;
      if (value == Btn.dot && number1.isEmpty) {
        number1 += "0.";
      } else {
        number1 += value;
      }
    } else if (number2.isEmpty || operand.isNotEmpty) {
      if (value == Btn.dot && number2.contains(Btn.dot)) return;
      if (value == Btn.dot && number2.isEmpty) {
        value = "0.";
      }
      number2 += value;
    }

    setState(() {});
  }


  Color getBtnColor(value){
    return [Btn.del,Btn.clr].contains(value)?Colors.white10
        :[Btn.per,
      Btn.divide,
      Btn.multiply,
      Btn.subtract,
      Btn.add,
      Btn.calculate,
    ].contains(value)?Colors.white10
        :Colors.white10;
  }
}
