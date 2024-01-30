import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_picture.g.dart';

@JsonSerializable()
@HiveType(typeId: 4)
class UserPicture {
  @HiveField(0)
  String? path;

  UserPicture({this.path});

  static Future<Box<UserPicture>> _getUserPictureDb() async {
    return Hive.box<UserPicture>('UserPicture');
  }

  static Future<List<UserPicture>> get() async {
    var r = await _getUserPictureDb();
    return r.values.toList();
  }

  static Future<void> set(UserPicture userPicture) async {
    var r = await _getUserPictureDb();
    await r.clear();
    await r.add(userPicture);
  }

  static Future<void> clear() async {
    var r = await _getUserPictureDb();
    await r.clear();
  }

  factory UserPicture.fromJson(Map<String, dynamic> json) =>
      _$UserPictureFromJson(json);

  Map<String, dynamic> toJson() => _$UserPictureToJson(this);
}
