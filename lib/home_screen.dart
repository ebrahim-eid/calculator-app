import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:math_expressions/math_expressions.dart';

import 'constants.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  var userInput = '';
  var userOutput = '';

  Color isOperator(String operator){
    if(operator =='DEL')
    {
      return Colors.red;
    }else if(operator=='%'||
        operator=='/'||operator=='*'||operator=='-'
        ||operator=='+'||operator =='='){
      return HexColor('#296e3c');
    }else if(operator=='C'){
      return Colors.green;
    }
    else{
      return HexColor('#647b6a');
    }
  }

  void function(String operator){
    if (operator == 'C'){
      userInput = '';
      userOutput ='';
    }else if(operator == 'DEL'){
      if(userInput !=''){
        userOutput = '';
        userInput = userInput.substring(0,userInput.length-1);
      }
    }else if(operator == '='){
      Parser p =Parser();
      Expression exp = p.parse(userInput);
      ContextModel cm = ContextModel();
      var eval = exp.evaluate(EvaluationType.REAL, cm);
      userOutput ="$eval";
      print(eval);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#9cb5ad'),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text('Calculator',style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(userInput,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24
            ),
            ),
            const SizedBox(height: 20,),
            Align(
              alignment: Alignment.bottomRight,
              child:Text( userOutput,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24
                ),
              ),
            ),
            const Spacer(),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              children: List.generate(
                  buttonsList.length,
                  (index) => MaterialButton(
                      onPressed: () {
                        setState(() {
                          if(buttonsList[index] !='DEL' && buttonsList[index] != '='){
                            userInput += buttonsList[index];
                            function(buttonsList[index]);
                          }
                          function(buttonsList[index]);

                        });
                      },
                      child: Container(
                        width: 60,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: isOperator(buttonsList[index])
                        ),
                        child: Center(
                          child: Text(
                            buttonsList[index],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      )
                  )
              ),
            )
          ],
        ),
      ),
    );
  }

}
