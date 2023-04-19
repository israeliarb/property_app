class ItemModel {
  final String id;
  final String name;
  final String model;
  final String serial;
  final String type;
  final String conservation;
  final String nfe;
  final String responsibleId;
  final String responsibleName;
  final String createdAt;
  final String updatedAt;
  final bool active;

  ItemModel({
    required this.id,
    required this.name,
    required this.model,
    required this.serial,
    required this.type,
    required this.conservation,
    required this.nfe,
    required this.responsibleId,
    required this.responsibleName,
    required this.createdAt,
    required this.updatedAt,
    required this.active,
  });
}
