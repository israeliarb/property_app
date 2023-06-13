import 'package:flutter/material.dart';
import 'package:property_app/constants/colors.dart';
import 'package:property_app/controllers/item_controller.dart';
import 'package:property_app/models/item_model.dart';

class ItemsReport extends StatefulWidget {
  @override
  _ItemsReportState createState() => _ItemsReportState();
}

class _ItemsReportState extends State<ItemsReport> {
  late Future<List<ItemModel>> _itensListFuture;

  @override
  void initState() {
    super.initState();
    _itensListFuture = getItensList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.customBlue,
        title: Text('Itens'),
        actions: [],
      ),
      body: Center(
        child: FutureBuilder<List<ItemModel>>(
          future: _itensListFuture,
          builder:
              (BuildContext context, AsyncSnapshot<List<ItemModel>> snapshot) {
            if (snapshot.hasData) {
              final List<ItemModel>? itens = snapshot.data;
              return ListView.builder(
                itemCount: itens?.length,
                itemBuilder: (BuildContext context, int index) {
                  final ItemModel? item = itens?[index];
                  return InkWell(
                    onTap: () {
                      _showItemDetails(context, item);
                    },
                    child: ListTile(
                      title: Text(item!.name),
                      subtitle: Text(item.model),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  void _showItemDetails(BuildContext context, ItemModel item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(item.name),
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Modelo: ${item.model}'),
                  Text('Número de Série: ${item.serial}'),
                  Text('Categoria: ${item.category}'),
                  Text('Tipo: ${item.type}'),
                  Text('Conservação: ${item.conservation}'),
                  Text('NFe: ${item.nfe}'),
                  Text('Responsável: ${item.responsibleName}'),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text('Fechar'),
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
