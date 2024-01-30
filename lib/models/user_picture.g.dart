// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_picture.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserPictureAdapter extends TypeAdapter<UserPicture> {
  @override
  final int typeId = 4;

  @override
  UserPicture read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserPicture(
      path: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserPicture obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.path);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserPictureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPicture _$UserPictureFromJson(Map<String, dynamic> json) => UserPicture(
      path: json['path'] as String?,
    );

Map<String, dynamic> _$UserPictureToJson(UserPicture instance) =>
    <String, dynamic>{
      'path': instance.path,
    };
