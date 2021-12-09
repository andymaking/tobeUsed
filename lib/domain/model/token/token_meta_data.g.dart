// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_meta_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TokenMetaDataAdapter extends TypeAdapter<TokenMetaData> {
  @override
  final int typeId = 99;

  @override
  TokenMetaData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TokenMetaData(
      fields[0] as String,
      fields[1] as String,
      fields[2] as double,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TokenMetaData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.token)
      ..writeByte(1)
      ..write(obj.refreshToken)
      ..writeByte(2)
      ..write(obj.lastTimeStored)
      ..writeByte(3)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenMetaDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
