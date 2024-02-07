// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PetHiveModelAdapter extends TypeAdapter<PetHiveModel> {
  @override
  final int typeId = 1;

  @override
  PetHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PetHiveModel(
      petId: fields[0] as String?,
      name: fields[1] as String,
      age: fields[2] as String,
      species: fields[3] as String,
      breed: fields[4] as String,
      gender: fields[5] as String,
      description: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PetHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.petId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(3)
      ..write(obj.species)
      ..writeByte(4)
      ..write(obj.breed)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PetHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
