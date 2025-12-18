import 'package:community/features/authenticaction/domain/entities/auth_user_entity.dart';
import 'package:equatable/equatable.dart';

class AuthUserModel extends AuthUserEntity with EquatableMixin {
  const AuthUserModel({required super.token});

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(token: json['token'] as String);
  }

  Map<String, dynamic> toJson() => {'token': token};

  @override
  List<Object?> get props => [token];
}
