import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MinhaAplicacao());
}

class MinhaAplicacao extends StatefulWidget {
  @override
  Formulario createState() => new Formulario();
}

class Formulario extends State<MinhaAplicacao> {
  String _operacao = "";
  final TextEditingController controleCampoNum1 = TextEditingController();
  final TextEditingController controleCampoNum2 = TextEditingController();
  double result = 0;

  dialogo(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Center(child: Text('Resultado')),
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$result',
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                child: Text('beleza'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        appBar: AppBar(
          title: Text('Formulario'),
        ),
        body: Builder(builder: (context) {
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: controleCampoNum1,
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Numero 1',
                    hintText: '00000',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: controleCampoNum2,
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Numero 2',
                    hintText: '00000',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  int num1 = int.parse(controleCampoNum1.text);
                  int num2 = int.parse(controleCampoNum2.text);
                  if (_operacao == 'somar') {
                    result = (num1 / num2).toDouble();
                  } else if (_operacao == 'subtrair') {
                    result = (num1 / num2).toDouble();
                  } else if (_operacao == 'multiplicar') {
                    result = (num1 / num2).toDouble();
                  } else if (_operacao == 'dividir') {
                    result = (num1 / num2).toDouble();
                  } else {
                    result = 0;
                  }
                  dialogo(context);
                },
                child: Text("Calcular"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      children: [
                        Text('Somar'),
                        Radio(
                          value: "somar",
                          groupValue: _operacao,
                          activeColor: Colors.green,
                          onChanged: (valor) {
                            setState(() {
                              _operacao = valor.toString();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      children: [
                        Text('Multiplicar'),
                        Radio(
                          value: 'multiplicar',
                          groupValue: _operacao,
                          activeColor: Colors.green,
                          onChanged: (valor) {
                            setState(() {
                              _operacao = valor.toString();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      children: [
                        Text('Subtrair'),
                        Radio(
                          value: "subtrair",
                          groupValue: _operacao,
                          activeColor: Colors.green,
                          onChanged: (valor) {
                            setState(() {
                              _operacao = valor.toString();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      children: [
                        Text('Dividir'),
                        Radio(
                          value: 'dividir',
                          groupValue: _operacao,
                          activeColor: Colors.green,
                          onChanged: (valor) {
                            setState(() {
                              _operacao = valor.toString();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
