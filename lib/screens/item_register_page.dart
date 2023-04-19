import 'package:flutter/material.dart';
import 'package:property_app/auth/main_page.dart';
import 'package:property_app/constants/colors.dart';
import 'package:property_app/constants/custom_border_radius.dart';
import 'package:property_app/constants/custom_sizes.dart';
import 'package:property_app/constants/font_size.dart';
import 'package:property_app/constants/spacing_sizes.dart';
import 'package:property_app/controllers/item_controller.dart';
import 'package:intl/intl.dart';

class ItemRegisterPage extends StatefulWidget {
  @override
  State<ItemRegisterPage> createState() => _ItemRegisterPageState();
}

class _ItemRegisterPageState extends State<ItemRegisterPage> {
  //Text controllers
  String _itemId = ' ';
  final _nameController = TextEditingController();
  final _modelController = TextEditingController();
  final _serialController = TextEditingController();
  final _typeController = TextEditingController();
  final _conservationController = TextEditingController();
  final _nfeController = TextEditingController();
  String _responsibleId = ' ';
  String _responsibleName = ' Sem responsável ';
  String _createdAt = ' ';
  String _updatedAt = ' ';
  bool _active = true;

  bool showErrorMessage = false;

  @override
  void dispose() {
    _nameController.dispose();
    _modelController.dispose();
    _serialController.dispose();
    _typeController.dispose();
    _conservationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.customBlack,
      appBar: AppBar(
        title: Text('Registro de itens'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(height: SpacingSizes.md_16),

              const Text(
                'Faça o cadastro do item abaixo',
                style: TextStyle(
                  fontSize: FontSize.l,
                ),
              ),

              const SizedBox(height: SpacingSizes.l_32),

              //Name TextField
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: CustomSizes.size_45),
                child: TextField(
                  controller: _nameController,
                  style: const TextStyle(color: CustomColor.customWhite),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: CustomColor.customLightGrey),
                      borderRadius:
                          BorderRadius.circular(CustomBorderRadius.md_12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: CustomColor.customBlue),
                      borderRadius:
                          BorderRadius.circular(CustomBorderRadius.md_12),
                    ),
                    hintStyle: const TextStyle(color: CustomColor.customWhite),
                    hintText: 'Nome',
                    filled: true,
                    fillColor: CustomColor.customDarkGrey,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 12.0),
                  ),
                ),
              ),

              const SizedBox(height: SpacingSizes.md_16),

              //Model TextField
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: CustomSizes.size_45),
                child: TextField(
                  controller: _modelController,
                  style: const TextStyle(color: CustomColor.customWhite),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: CustomColor.customLightGrey),
                      borderRadius:
                          BorderRadius.circular(CustomBorderRadius.md_12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: CustomColor.customBlue),
                      borderRadius:
                          BorderRadius.circular(CustomBorderRadius.md_12),
                    ),
                    hintStyle: const TextStyle(color: CustomColor.customWhite),
                    hintText: 'Modelo',
                    filled: true,
                    fillColor: CustomColor.customDarkGrey,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 12.0),
                  ),
                ),
              ),

              const SizedBox(height: SpacingSizes.md_16),

              //Serial TextField
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: CustomSizes.size_45),
                child: TextField(
                  controller: _serialController,
                  style: const TextStyle(color: CustomColor.customWhite),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: CustomColor.customLightGrey),
                      borderRadius:
                          BorderRadius.circular(CustomBorderRadius.md_12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: CustomColor.customBlue),
                      borderRadius:
                          BorderRadius.circular(CustomBorderRadius.md_12),
                    ),
                    hintStyle: const TextStyle(color: CustomColor.customWhite),
                    hintText: 'Codigo de Série',
                    filled: true,
                    fillColor: CustomColor.customDarkGrey,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 12.0),
                  ),
                ),
              ),

              const SizedBox(height: SpacingSizes.md_16),

              //Type Dropdown
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: CustomSizes.size_45),
                child: InputDecorator(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: CustomColor.customDarkGrey,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: CustomColor.customLightGrey),
                      borderRadius:
                          BorderRadius.circular(CustomBorderRadius.md_12),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String?>(
                      value: _typeController.text.isNotEmpty
                          ? _typeController.text
                          : null,
                      onChanged: (newValue) {
                        setState(() {
                          _typeController.text = newValue!;
                        });
                      },
                      items: [
                        DropdownMenuItem<String>(
                          value: null,
                          child: Text('Selecione o tipo do item'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Computador',
                          child: Text('Computador'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Notebook',
                          child: Text('Notebook'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: SpacingSizes.md_16),

              //Conservation TextField
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: CustomSizes.size_45),
                child: InputDecorator(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: CustomColor.customDarkGrey,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: CustomColor.customLightGrey),
                      borderRadius:
                          BorderRadius.circular(CustomBorderRadius.md_12),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String?>(
                      value: _conservationController.text.isNotEmpty
                          ? _conservationController.text
                          : null,
                      onChanged: (newValue) {
                        setState(() {
                          _conservationController.text = newValue!;
                        });
                      },
                      items: [
                        DropdownMenuItem<String>(
                          value: null,
                          child: Text('Selecione o estado de conserva'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Novo',
                          child: Text('Novo'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Seminovo',
                          child: Text('Seminovo'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Usado',
                          child: Text('Usado'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: SpacingSizes.md_16),

              //NF-E TextField
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: CustomSizes.size_45),
                child: TextField(
                  controller: _nfeController,
                  style: const TextStyle(color: CustomColor.customWhite),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: CustomColor.customLightGrey),
                      borderRadius:
                          BorderRadius.circular(CustomBorderRadius.md_12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: CustomColor.customBlue),
                      borderRadius:
                          BorderRadius.circular(CustomBorderRadius.md_12),
                    ),
                    hintStyle: const TextStyle(color: CustomColor.customWhite),
                    hintText: 'Nota Fiscal',
                    filled: true,
                    fillColor: CustomColor.customDarkGrey,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 12.0),
                  ),
                ),
              ),

              const SizedBox(height: SpacingSizes.md_16),

              //Save button
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: CustomSizes.size_45),
                child: GestureDetector(
                  onTap: () {
                    if ((_nameController.text.trim() != "") &&
                        (_modelController.text.trim() != "") &&
                        (_serialController.text.trim() != "") &&
                        (_typeController.text.trim() != "") &&
                        (_conservationController.text.trim() != "") &&
                        (_nfeController.text.trim() != "")) {
                      DateTime now = DateTime.now(); // get current timestamp
                      String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss')
                          .format(now); // format timestamp as string
                      addItem(
                        _itemId,
                        _nameController.text.trim(),
                        _modelController.text.trim(),
                        _serialController.text.trim(),
                        _typeController.text.trim(),
                        _conservationController.text.trim(),
                        _nfeController.text.trim(),
                        _responsibleId,
                        _responsibleName,
                        formattedDate, // assign formatted timestamp to _createdAt
                        formattedDate,
                        _active,
                      );
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              "Erro ao salvar o item",
                              style: TextStyle(
                                fontSize: FontSize.l,
                              ),
                            ),
                            content: Text(
                              "Todos os campos devem ser preenchidos",
                              style: TextStyle(
                                fontSize: FontSize.sm,
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Ok"),
                              )
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(CustomSizes.size_15),
                    decoration: BoxDecoration(
                        color: CustomColor.customBlue,
                        borderRadius:
                            BorderRadius.circular(CustomBorderRadius.md_12)),
                    child: const Center(
                      child: Text(
                        'Salvar',
                        style: TextStyle(
                          color: CustomColor.customWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: FontSize.md,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: SpacingSizes.md_16),

              //Cancel button
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: CustomSizes.size_45),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (contex) {
                        return const MainPage();
                      }),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(CustomSizes.size_15),
                    decoration: BoxDecoration(
                        color: CustomColor.customRed,
                        borderRadius:
                            BorderRadius.circular(CustomBorderRadius.md_12)),
                    child: const Center(
                      child: Text(
                        'Cancelar',
                        style: TextStyle(
                          color: CustomColor.customWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: FontSize.md,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: SpacingSizes.l_32),
            ]),
          ),
        ),
      ),
    );
  }
}
