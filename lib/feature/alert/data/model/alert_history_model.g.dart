// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert_history_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlertHistoryModelAdapter extends TypeAdapter<AlertHistoryModel> {
  @override
  final int typeId = 1;

  @override
  AlertHistoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AlertHistoryModel(
      id: fields[0] as String,
      stockCode: fields[1] as String,
      stockName: fields[2] as String,
      targetPrice: fields[3] as int,
      triggeredPrice: fields[4] as int,
      alertTypeIndex: fields[5] as int,
      triggeredAt: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, AlertHistoryModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.stockCode)
      ..writeByte(2)
      ..write(obj.stockName)
      ..writeByte(3)
      ..write(obj.targetPrice)
      ..writeByte(4)
      ..write(obj.triggeredPrice)
      ..writeByte(5)
      ..write(obj.alertTypeIndex)
      ..writeByte(6)
      ..write(obj.triggeredAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlertHistoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
