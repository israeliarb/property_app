import 'package:flutter/material.dart';
import 'package:property_app/constants/colors.dart';
import 'package:property_app/constants/custom_border_radius.dart';
import 'package:property_app/constants/font_size.dart';
import 'package:property_app/constants/spacing_sizes.dart';
import 'package:property_app/controllers/item_controller.dart';
import 'package:property_app/controllers/user_controller.dart';
import 'package:property_app/models/item_model.dart';
import 'package:property_app/models/user_model.dart';

class AssignPage extends StatefulWidget {
  final String selectedItem;
  const AssignPage({Key? key, required this.selectedItem}) : super(key: key);

  @override
  State<AssignPage> createState() => _AssignPageState();
}

class _AssignPageState extends State<AssignPage> {
  late Future<ItemModel> _futureItem;
  List<UserModel> _users = [];
  final _selectedResponsible = TextEditingController();

  @override
  void initState() {
    super.initState();
    _futureItem = getItem(widget.selectedItem);
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    List<UserModel> users = await getUsers();
    setState(() {
      _users = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reponsável pelo Item'),
      ),
      body: Center(
        child: FutureBuilder<ItemModel>(
          future: _futureItem,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Erro ao carregar o item: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return Text('Nenhum dado encontrado');
            }
            final item = snapshot.data!;
            return Column(
              children: [
                const SizedBox(height: SpacingSizes.md_16),
                const Text(
                  'Faça o vínculo do item ao responsável',
                  style: TextStyle(
                    fontSize: FontSize.l,
                  ),
                ),
                const SizedBox(height: SpacingSizes.l_32),
                Text(
                  'Item: ${item.name}',
                  style: TextStyle(
                    fontSize: FontSize.l,
                  ),
                ),
                const SizedBox(height: SpacingSizes.md_16),
                const Text(
                  'Selecione o responsável abaixo',
                  style: TextStyle(
                    fontSize: FontSize.md,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(SpacingSizes.l_32),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: CustomColor.customDarkGrey,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: CustomColor.customLightGrey),
                        borderRadius:
                            BorderRadius.circular(CustomBorderRadius.md_12),
                      ),
                    ),
                    child: DropdownButtonFormField<UserModel>(
                      /*decoration: InputDecoration(
                        labelText: 'Selecione o usuário',
                      ),*/
                      value: null,
                      onChanged: (UserModel? user) {
                        // Faça algo com o usuário selecionado
                        print(user?.name);
                      },
                      items: _users.map((UserModel user) {
                        return DropdownMenuItem<UserModel>(
                          value: user,
                          child: Text(user.name),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
