// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteItemModelAdapter extends TypeAdapter<FavoriteItemModel> {
  @override
  final int typeId = 0;

  @override
  FavoriteItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteItemModel(
      stockCode: fields[0] as String,
      stockName: fields[1] as String,
      alertTypeIndex: fields[4] as int,
      createdAt: fields[5] as DateTime,
      logoUrl: fields[2] as String?,
      targetPrice: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteItemModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.stockCode)
      ..writeByte(1)
      ..write(obj.stockName)
      ..writeByte(2)
      ..write(obj.logoUrl)
      ..writeByte(3)
      ..write(obj.targetPrice)
      ..writeByte(4)
      ..write(obj.alertTypeIndex)
      ..writeByte(5)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
