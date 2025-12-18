import 'package:equatable/equatable.dart';

class AuthUserEntity extends Equatable {
  final String token;
  const AuthUserEntity({required this.token});
  
  @override
  List<Object?> get props => [token];
}
