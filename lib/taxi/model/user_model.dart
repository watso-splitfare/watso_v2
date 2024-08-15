import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class MyUser with _$MyUser {
  const factory MyUser({
    required int id,
    required String nickname,
  }) = _User;

  factory MyUser.fromJson(Map<String, Object?> json) => _$MyUserFromJson(json);
}
