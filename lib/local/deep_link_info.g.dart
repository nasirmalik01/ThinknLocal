// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deep_link_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeepLinkInfoAdapter extends TypeAdapter<DeepLinkInfo> {
  @override
  final int typeId = 2;

  @override
  DeepLinkInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeepLinkInfo(
      causeId: fields[0] as int?,
      businessId: fields[1] as int?,
      organizationId: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, DeepLinkInfo obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.causeId)
      ..writeByte(1)
      ..write(obj.businessId)
      ..writeByte(2)
      ..write(obj.organizationId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeepLinkInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
