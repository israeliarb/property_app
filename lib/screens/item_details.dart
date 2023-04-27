import 'package:flutter/material.dart';
import 'package:property_app/controllers/item_controller.dart';
import 'package:property_app/models/item_model.dart';

class ItemDetailsScreen extends StatefulWidget {
  final String itemId;

  const ItemDetailsScreen({super.key, required this.itemId});

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  late ItemModel _item;

  @override
  void initState() {
    super.initState();
    _fetchItem();
  }

  Future<void> _fetchItem() async {
    ItemModel item = await getItem(widget.itemId);
    setState(() {
      _item = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_item == null) {
      // exibe um indicador de carregamento enquanto os dados são buscados do Firebase
      return const Center(child: CircularProgressIndicator());
    }

    // exibe os dados do item
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Item'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text('Nome: ${_item.name}'),
          Text('Modelo: ${_item.model}'),
          Text('Serial: ${_item.serial}'),
          Text('Category: ${_item.category}'),
          Text('Tipo: ${_item.type}'),
          Text('Conservação: ${_item.conservation}'),
          Text('Nota fiscal: ${_item.nfe}'),
          Text('Data de emissão da NFe: ${_item.nfeDate}'),
          Text('Responsável: ${_item.responsibleName}'),
        ],
      ),
    );
  }
}
