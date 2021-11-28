// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      id: json['id'] as String,
      ino: json['ino'] as String,
      itemName: json['itemName'] as String,
      itemURL: json['itemURL'] as String,
      price: json['price'] as String,
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'itemName': instance.itemName,
      'itemURL': instance.itemURL,
      'ino': instance.ino,
    };
