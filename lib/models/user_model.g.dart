// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 2;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] as int?,
      username: fields[1] as String?,
      fullname: fields[2] as String?,
      phone: fields[3] as String?,
      role: fields[4] as String?,
      country: fields[5] as int?,
      address: fields[6] as String?,
      rib: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.fullname)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.role)
      ..writeByte(5)
      ..write(obj.country)
      ..writeByte(6)
      ..write(obj.address)
      ..writeByte(7)
      ..write(obj.rib);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['user_id'] as int?,
      username: json['username'] as String?,
      fullname: json['full_name'] as String?,
      phone: json['phone'] as String?,
      role: json['role'] as String?,
      country: json['country'] as int?,
      address: json['address'] as String?,
      rib: json['rib'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'user_id': instance.id,
      'username': instance.username,
      'full_name': instance.fullname,
      'phone': instance.phone,
      'role': instance.role,
      'country': instance.country,
      'address': instance.address,
      'rib': instance.rib,
    };
