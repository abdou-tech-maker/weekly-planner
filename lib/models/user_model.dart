// ignore_for_file: non_constant_identifier_names, sdk_version_since

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
class UserModel {
  @HiveField(0)
  @JsonKey(name: 'user_id')
  int? id;
  @HiveField(1)
  String? username;
  @HiveField(2)
  @JsonKey(name: 'full_name')
  String? fullname;
  @HiveField(3)
  String? phone;
  @HiveField(4)
  String? role;
  @HiveField(5)
  int? country;
  @HiveField(6)
  String? address;
  @HiveField(7)
  String? rib;
  @HiveField(8)
  UserModel(
      {this.id,
      this.username,
      this.fullname,
      this.phone,
      this.role,
      this.country,
      this.address,
      this.rib});
  static Future<Box<UserModel>> _getUserModelDb() async {
    return Hive.box<UserModel>('UserModel');
  }

  static Future<UserModel?> get() async {
    var r = await _getUserModelDb();
    return r.values.firstOrNull;
  }

  static Future<String> set(UserModel? user) async {
    if (user == null) return "User is empty";
    var r = await _getUserModelDb();
    await r.clear();
    await r.add(user);
    return "user saved succusfully";
  }

/*  static Future<void> deleteWhere(String id) async {
    var r = await _getUserModelDb();
    await r.values.first.photos
        ?.firstWhereOrNull((element) => element.id == id)
        ?.delete();
  }*/
  Future<void> updateCountry(int countryId) async {
    var userModelBox = await _getUserModelDb();
    var currentUser = userModelBox.values.firstOrNull;

    if (currentUser != null) {
      currentUser.country = countryId;
      await userModelBox.put(currentUser.id, currentUser);
    }
  }

  static Future<void> clear() async {
    var r = await _getUserModelDb();
    await r.clear();
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
