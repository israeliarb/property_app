import 'package:flutter/material.dart';
import 'package:property_app/constants/colors.dart';
import 'package:property_app/controllers/image_controller.dart';
import 'package:property_app/controllers/item_controller.dart';
import 'package:property_app/models/item_model.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';

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

  Future<void> _copyToClipboard(String data) async {
    await Clipboard.setData(ClipboardData(text: data));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Dados copiados para a área de transferência')));
  }

  @override
  Widget build(BuildContext context) {
    if (_item == null) {
      // exibe um indicador de carregamento enquanto os dados são buscados do Firebase
      return const Center(child: CircularProgressIndicator());
    }

    // converte os dados do item em uma string
    String itemDetails = 'Nome: ${_item.name}\n'
        'Modelo: ${_item.model}\n'
        'Serial: ${_item.serial}\n'
        'Categoria: ${_item.category}\n'
        'Tipo: ${_item.type}\n'
        'Conservação: ${_item.conservation}\n'
        'Nota fiscal: ${_item.nfe}\n'
        'Data de emissão da NFe: ${_item.nfeDate}\n'
        'ID: ${_item.id}';

    // converte os dados do item em uma string (Função com responsável e dados da NFe)
    /*String itemDetails = 'Nome: ${_item.name}\n'
        'Modelo: ${_item.model}\n'
        'Serial: ${_item.serial}\n'
        'Categoria: ${_item.category}\n'
        'Tipo: ${_item.type}\n'
        'Conservação: ${_item.conservation}\n'
        'Nota fiscal: ${_item.nfe}\n'
        'Data de emissão da NFe: ${_item.nfeDate}\n'
        'Responsável: ${_item.responsibleName}';*/

    // exibe os dados do item e um botão para copiar para a área de transferência
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.customBlue,
        title: const Text('Detalhes do Item'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Text('Nome: ${_item.name}'),
                Text('Modelo: ${_item.model}'),
                Text('Serial: ${_item.serial}'),
                Text('Categoria: ${_item.category}'),
                Text('Tipo: ${_item.type}'),
                Text('Conservação: ${_item.conservation}'),
                Text('Nota fiscal: ${_item.nfe}'),
                Text('Data de emissão da NFe: ${_item.nfeDate}'),
                Text('Responsável: ${_item.responsibleName}'),
                const SizedBox(height: 16.0),
                Container(
                  color: CustomColor.customWhite,
                  child: Center(
                    child: QrImage(
                      data: itemDetails,
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () => _copyToClipboard(itemDetails),
                  child: const Text('Copiar para a Área de Transferência'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
