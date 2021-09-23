import 'package:flutter/material.dart';

void main() => runApp(ByteBankApp());

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListagemControles(),
      ),
    );
  }
}

class FormularioControle extends StatefulWidget {
  final TextEditingController _controleCampoNumeroConta = TextEditingController();
  final TextEditingController _controleCampoValor = TextEditingController();
  @override
  State<StatefulWidget> createState() {
    return FormularioControleStates();
  }
}

class FormularioControleStates extends State<FormularioControle>{
  late int selectedRadioTile;

  @override
  void initState() {
    super.initState();
    var selectedRadio = 0;
    selectedRadioTile = 1;
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Nova Entrada/Saída"),
          backgroundColor: Colors.grey[900]!,
        ),
        body:  ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: widget._controleCampoValor,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  icon: Icon(Icons.report_problem),
                  labelText: "Modelo: ",
                  hintText: "Ex: Gol/Fox",
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: widget._controleCampoNumeroConta,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  icon: Icon(Icons.report_problem),
                  labelText: "Placa: ",
                  hintText: "AAA-1234",
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            RadioListTile(
              value: 1,
              groupValue: selectedRadioTile,
              title: Text("Entrada",style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green[600]!,
              ),),
              subtitle: Text("(Veículo entrou no estabelecimento)",style: TextStyle(
                fontSize: 10,
                color: Colors.grey[600]!
              ),),
              onChanged: (val) {
                print("Seleção $val");
                setSelectedRadioTile(1);
              },
              activeColor: Colors.red,
              selected: true,
            ),
            RadioListTile(
              value: 2,
              groupValue: selectedRadioTile,
              title: Text("Saída",style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),),
              subtitle: Text("(Veículo saiu do estabelecimento)",style: TextStyle(
                fontSize: 10,
                color: Colors.grey[600]!,
              ),),
              onChanged: (val) {
                print("Seleção $val");
                setSelectedRadioTile(2);
              },
              activeColor: Colors.red,
              selected: false,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[900]!,
                onPrimary: Colors.white,
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                ),
              ),
              onPressed: () {
                final String? numeroConta = widget._controleCampoNumeroConta.text;
                final String? valor = widget._controleCampoValor.text;
                final int selcted = selectedRadioTile;
                if (numeroConta != null && valor != null) {
                    final controleCriada = Controle(valor, numeroConta, selcted, DateTime.now());
                    Navigator.pop(context, controleCriada);
                }
              },
              child: Text('Confirmar'),
            )
          ],
        ));
  }
}

class ListagemControles extends StatefulWidget {
  final List<Controle> _controle = [];
  State<StatefulWidget> createState() {
    return ListagemControlesState();
  }
}

class ListagemControlesState extends State<ListagemControles>{
  @override
  Widget build(BuildContext context) {
    //VOCÊ PODE TIRAR PRA NÃO TER REPETIÇÃO
    widget._controle.add(Controle('Gol','JGH-5964',1,DateTime(2017, 5, 15, 12, 30)));
    widget._controle.add(Controle('Fox','ASF-4568',2,DateTime(2018, 9, 27, 14, 23)));
    widget._controle.add(Controle('Onix','FDG-1595',1,DateTime(2019, 1, 1, 16, 45)));
    widget._controle.add(Controle('Sandero','XCV-8584',2,DateTime(2020, 10, 17, 06, 01)));
    return Scaffold(
      body: ListView.builder(
          itemCount: widget._controle.length,
          itemBuilder: (context, indice){
            return ItemControle(widget._controle[indice]);
          }
      ),
      appBar: AppBar(
        leading: Icon(Icons.directions_car_filled_sharp),
        title: Text("Controle de acesso"),
        backgroundColor: Colors.grey[900]!,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[900]!,
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          final Future futuro = Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return FormularioControle();
            }),
          );
          futuro.then((controleRecebida){
            debugPrint("$controleRecebida");
            if(controleRecebida != null)
              setState((){
                widget._controle.add(controleRecebida);
              });
          });
        },
        hoverColor: Colors.black,
      ),
    );
  }
}

class ItemControle extends StatelessWidget {
  final Controle controle;
  ItemControle(this.controle);
  @override
  Widget build(BuildContext context) {
    Icon? oi;
    Text? act;
    Text? sub;
    if (controle.selectedRadioTile == 1){
      oi = Icon(
        Icons.arrow_circle_up,
        color: Colors.green,
      );
      act =  Text.rich(
        TextSpan(
          text: 'Placa: ', // default text style
          children: <TextSpan>[
            TextSpan(text: controle.numeroConta.toString() +' - ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: 'Entrada',style: TextStyle(fontStyle: FontStyle.italic, color:Colors.green)),
          ],
        ),
      );
      sub =  Text.rich(
        TextSpan(
          text: '', // default text style
          children: <TextSpan>[
            TextSpan(text: 'Modelo:  ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: controle.valor.toString() +' - '),
            TextSpan(text: 'Data:  ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: ''+controle.now.toString().substring(0,16), style: TextStyle(fontStyle: FontStyle.italic)),
          ],
        ),
      );
    }else{
      oi = Icon(
        Icons.arrow_circle_down,
        color: Colors.red,
      );
      act =  Text.rich(
        TextSpan(
          text: 'Placa: ', // default text style
          children: <TextSpan>[
            TextSpan(text: controle.numeroConta.toString() +' - ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: 'Saida',style: TextStyle(fontStyle: FontStyle.italic, color:Colors.red)),
          ],
        ),
      );
      sub =  Text.rich(
        TextSpan(
          text: '', // default text style
          children: <TextSpan>[
            TextSpan(text: 'Modelo:  ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: controle.valor.toString() +' - '),
            TextSpan(text: 'Data:  ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: ''+controle.now.toString().substring(0,16), style: TextStyle(fontStyle: FontStyle.italic)),
          ],
        ),
      );
    }
      return Card(
        child: ListTile(
          leading: oi,
          title: act,
          subtitle: sub,
        ),
      );
    }
}

class Controle {
  final String valor;
  final String numeroConta;
  final int selectedRadioTile;
  final DateTime? now;
  Controle(this.valor, this.numeroConta, this.selectedRadioTile, this.now);
  String toString(){
    return "Controle: {valor : $valor, numero: $numeroConta, selected: $selectedRadioTile)}";
  }
}
