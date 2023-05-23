class ItemModel {
  final String id;
  final String name;
  final String model;
  final String serial;
  final String category;
  final String type;
  final String conservation;
  final String nfe;
  final String nfeDate;
  final String responsibleId;
  String responsibleName;
  final String createdAt;
  final String updatedAt;
  final String imageUrl;
  final bool active;

  ItemModel({
    required this.id,
    required this.name,
    required this.model,
    required this.serial,
    required this.category,
    required this.type,
    required this.conservation,
    required this.nfe,
    required this.nfeDate,
    required this.responsibleId,
    required this.responsibleName,
    required this.createdAt,
    required this.updatedAt,
    required this.imageUrl,
    required this.active,
  });
}
