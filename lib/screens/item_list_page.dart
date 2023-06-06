import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:property_app/auth/main_page.dart';
import 'package:property_app/constants/colors.dart';
import 'package:property_app/constants/custom_border_radius.dart';
import 'package:property_app/constants/custom_sizes.dart';
import 'package:property_app/constants/font_size.dart';
import 'package:property_app/constants/spacing_sizes.dart';
import 'package:property_app/screens/assign_page.dart';
import 'package:property_app/screens/item_details.dart';
import 'package:property_app/screens/item_edit_page.dart';
import 'package:property_app/screens/item_images.dart';
import 'package:property_app/screens/item_insert_page.dart';
import 'package:property_app/screens/items_report.dart';

class ItemListPage extends StatefulWidget {
  const ItemListPage({super.key});

  @override
  _ItemListPageState createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Itens cadastrados no sistema',
          style: TextStyle(
            fontSize: FontSize.l,
          ),
        ),
        backgroundColor: CustomColor.customBlue,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: SpacingSizes.l_32, right: SpacingSizes.l_32),
                child: Container(
                  height: CustomSizes.size_250,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: CustomColor.customWhite,
                    ),
                    borderRadius:
                        BorderRadius.circular(CustomBorderRadius.md_12),
                  ),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('itens')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Text('Nenhum item cadastrado.'),
                        );
                      } else {
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: snapshot.data!.docs.map((document) {
                                  return SizedBox(
                                    height: CustomSizes.size_50,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: SpacingSizes.sm_10,
                                        top: SpacingSizes.sm_10,
                                      ),
                                      child: RadioListTile(
                                        title: Text(
                                          document['name'] +
                                              ' - ' +
                                              document['responsibleName'],
                                        ),
                                        value: document.id,
                                        groupValue: selectedItem,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedItem = value.toString();
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: SpacingSizes.l_32),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ItemRegisterPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: CustomColor.customBlue,
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Adicionar novo item',
                      style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedItem == null) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Item não selecionado'),
                            content: const Text(
                                'Por favor, selecione um item antes de prosseguir.'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Ok'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ItemEditPage(itemId: selectedItem!),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: CustomColor.customBlue,
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child:
                      const Text('Editar item', style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ItemsReport()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: CustomColor.customBlue,
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Relatório de itens',
                      style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedItem == null) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Item não selecionado'),
                            content: const Text(
                                'Por favor, selecione um item antes de prosseguir.'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Ok'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ItemDetailsScreen(itemId: selectedItem!),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: CustomColor.customBlue,
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Detalhes do item',
                      style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedItem == null) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Item não selecionado'),
                            content: const Text(
                                'Por favor, selecione um item antes de prosseguir.'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Ok'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ItemImagesScreen(itemId: selectedItem!),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: CustomColor.customBlue,
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Imagens do item',
                      style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
