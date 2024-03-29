import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:property_app/main.dart';
import 'package:property_app/models/item_model.dart';

Future addItem(
  String id,
  String name,
  String model,
  String serial,
  String category,
  String type,
  String conservation,
  String nfe,
  String nfeDate,
  String responsibleId,
  String responsibleName,
  String createdAt,
  String updatedAt,
  bool active,
) async {
  ItemModel newItem = ItemModel(
    id: id,
    name: name,
    model: model,
    serial: serial,
    category: category,
    type: type,
    conservation: conservation,
    nfe: nfe,
    nfeDate: nfeDate,
    responsibleId: responsibleId,
    responsibleName: responsibleName,
    createdAt: createdAt,
    updatedAt: updatedAt,
    active: active,
  );

  try {
    //Add item details
    addItemDetails(
      newItem,
    );
  } catch (e) {
    print(e);
  }
}

void addItemDetails(ItemModel item) async {
  await db.collection('itens').add({
    'name': item.name,
    'model': item.model,
    'serial': item.serial,
    'category': item.category,
    'type': item.type,
    'conservation': item.conservation,
    'nfe': item.nfe,
    'nfeDate': item.nfeDate,
    'responsibleId': item.responsibleId,
    'responsibleName': item.responsibleName,
    'createdAt': item.createdAt,
    'updatedAt': item.updatedAt,
    'active': item.active,
  });
}

//Get list of itens
Future<List<ItemModel>> getItensList() async {
  final QuerySnapshot snapshot = await db.collection('itens').get();

  final List<ItemModel> itens = [];

  for (var doc in snapshot.docs) {
    itens.add(ItemModel(
      id: doc.id,
      name: doc['name'],
      model: doc['model'],
      serial: doc['serial'],
      category: doc['category'],
      type: doc['type'],
      conservation: doc['conservation'],
      nfe: doc['nfe'],
      nfeDate: doc['nfeDate'],
      responsibleId: doc['responsibleId'],
      responsibleName: doc['responsibleName'],
      createdAt: doc['createdAt'],
      updatedAt: doc['updatedAt'],
      active: doc['active'],
    ));
  }

  return itens;
}

Future<ItemModel> getItem(String itemId) async {
  DocumentSnapshot snapshot =
      await FirebaseFirestore.instance.collection('itens').doc(itemId).get();

  ItemModel item = ItemModel(
      id: itemId,
      name: snapshot['name'],
      model: snapshot['model'],
      serial: snapshot['serial'],
      category: snapshot['category'],
      type: snapshot['type'],
      conservation: snapshot['conservation'],
      nfe: snapshot['nfe'],
      nfeDate: snapshot['nfeDate'],
      responsibleId: snapshot['responsibleId'],
      responsibleName: snapshot['responsibleName'],
      createdAt: snapshot['createdAt'],
      updatedAt: snapshot['updatedAt'],
      active: snapshot['active']);

  return item;
}

void updateItemResponsible(String itemId, String newResponsibleName) async {
  await FirebaseFirestore.instance
      .collection('itens')
      .doc(itemId)
      .update({'responsibleName': newResponsibleName});
}

void updateItem(
  String itemId,
  String name,
  String model,
  String serial,
  String category,
  String type,
  String conservation,
  String nfe,
  String nfeDate,
  String responsibleId,
  String responsibleName,
  String updatedAt,
  bool active,
) async {
  await FirebaseFirestore.instance.collection('itens').doc(itemId).update({
    'name': name,
    'model': model,
    'serial': serial,
    'category': category,
    'type': type,
    'conservation': conservation,
    'nfe': nfe,
    'nfeDate': nfeDate,
    'responsibleId': responsibleId,
    'responsibleName': responsibleName,
    'updatedAt': updatedAt,
    'active': active,
  });
}
