import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _orderController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _quantityController = TextEditingController();

  Future<void> _submitOrder() async {
    if (_formKey.currentState?.validate() ?? false) {
      String order = _orderController.text;
      String description = _descriptionController.text;
      String quantity = _quantityController.text;

      try {
        // Enviar dados para o Firestore
        await FirebaseFirestore.instance.collection('pedidos').add({
          'order': order,
          'description': description,
          'quantity': int.parse(quantity),
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Mostrar diálogo de sucesso
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Pedido enviado'),
              content: Text(
                  'Order: $order\nDescription: $description\nQuantity: $quantity'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
                ),
              ],
            );
          },
        );

        // Limpar os campos após o envio
        _orderController.clear();
        _descriptionController.clear();
        _quantityController.clear();
      } catch (e) {
        // Mostrar mensagem de erro se o envio falhar
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Erro ao enviar pedido'),
              content: Text(e.toString()),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escolha seu pedido'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _orderController,
                decoration: InputDecoration(
                  labelText: 'Pedido',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O que deseja comer hoje?';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Descreva como gostaria seu pedido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(
                  labelText: 'Quantidade',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Selecione a quantidade';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor coloque uma quantidade valida';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitOrder,
                child: Text('Envie seu pedido'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _orderController.dispose();
    _descriptionController.dispose();
    _quantityController.dispose();
    super.dispose();
  }
}
