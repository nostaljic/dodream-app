import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable()
class Item {
  final String id;
  final String price;
  final String itemName;
  final String itemURL;
  final String ino;
  final String acno;

  Item({required this.id, required this.ino, required this.itemName, required this.itemURL, required this.price, required this.acno});

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}