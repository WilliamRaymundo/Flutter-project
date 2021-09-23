import 'package:flutter/material.dart';

void main() => runApp(ByteBankApp());

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListagemTransferencias(),
      ),
    );
  }
}

class FormularioTransferencia extends StatefulWidget {
  final TextEditingController _controleCampoNumeroConta = TextEditingController();
  final TextEditingController _controleCampoValor = TextEditingController();

  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaStates();
  }
}

class FormularioTransferenciaStates extends State<FormularioTransferencia>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Inserir Transferência"),
        ),
        body:  ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: widget._controleCampoNumeroConta,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  labelText: "Número da Conta",
                  hintText: "0000",
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: widget._controleCampoValor,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  icon: Icon(Icons.monetization_on),
                  labelText: "Valor da Transferência",
                  hintText: "0.00",
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                debugPrint('Clicou no confirmar');
                final Int? numeroConta = widget._controleCampoNumeroConta.text;
                final Double? valor = widget._controleCampoValor.text;
                if (numeroConta != null && valor != null) {
                  final transferenciaCriada = Transferencia(valor, numeroConta);
                  Navigator.pop(context, transferenciaCriada);
                }
              },
              child: Text('Confirmar'),
            )
          ],
        ));
  }
}


class ListagemTransferencias extends StatefulWidget {
  final List<Transferencia> _transferencia = [];
  State<StatefulWidget> createState() {
    return ListagemTransferenciasState();
  }
}
class ListagemTransferenciasState extends State<ListagemTransferencias>{
  @override
  Widget build(BuildContext context) {
    widget._transferencia.add(Transferencia(100.0,10));
    widget._transferencia.add(Transferencia(100.0,10));
    widget._transferencia.add(Transferencia(100.0,10));
    widget._transferencia.add(Transferencia(100.0,10));
    return Scaffold(
      body: ListView.builder(
          itemCount: widget._transferencia.length,
          itemBuilder: (context, indice){
            return ItemTransferencia(widget._transferencia[indice]);
          }
      ),
      appBar: AppBar(
        title: Text(
          "Transferências",
        ),
        backgroundColor: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          debugPrint("Foi bot");
          final Future futuro = Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return FormularioTransferencia();
            }),
          );
          futuro.then((transferenciaRecebida){
            debugPrint("$transferenciaRecebida");
            if(transferenciaRecebida != null)
              setState((){
                widget._transferencia.add(transferenciaRecebida);
              });

          });
        },
        hoverColor: Colors.black,
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia transferencia;

  ItemTransferencia(this.transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(transferencia.valor.toString()),
        subtitle: Text(transferencia.numeroConta.toString()),
      ),
    );
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);
  String toString(){
    return "Transf foi{valor : $valor, numero: $numeroConta}";
  }
}
