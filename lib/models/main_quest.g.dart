// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_quest.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MainQuestModelAdapter extends TypeAdapter<MainQuestModel> {
  @override
  final int typeId = 1;

  @override
  MainQuestModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MainQuestModel(
      mainQuestIconPath: fields[0] as String,
      mainQuestName: fields[1] as String,
      subTasks: (fields[2] as List).cast<SubTaskModel>(),
      exp: fields[3] as int,
      completed: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MainQuestModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.mainQuestIconPath)
      ..writeByte(1)
      ..write(obj.mainQuestName)
      ..writeByte(2)
      ..write(obj.subTasks)
      ..writeByte(3)
      ..write(obj.exp)
      ..writeByte(4)
      ..write(obj.completed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MainQuestModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
