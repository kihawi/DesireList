// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'desire.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DesireAdapter extends TypeAdapter<Desire> {
  @override
  final typeId = 0;

  @override
  Desire read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Desire(
      id: (fields[0] as num?)?.toInt(),
      title: fields[1] as String,
      description: fields[2] as String,
      status: fields[3] == null ? 'идея' : fields[3] as String,
      category: fields[4] == null
          ? const <String>['Общее']
          : (fields[4] as List).cast<String>(),
      imageUrl: fields[5] as String?,
      createdAt: fields[6] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Desire obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.imageUrl)
      ..writeByte(6)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DesireAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
