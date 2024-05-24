import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:serieso/application/models/seo_enums/seo_enums.dart';

part 'seo_model_user.g.dart';

@JsonSerializable()
class SeoModelUser extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final UserRole role;
  final String? startupID;

  const SeoModelUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.role,
    this.startupID,
  });

  factory SeoModelUser.fromJson(Map<String, dynamic> data) =>
      _$SeoModelUserFromJson(data);

  Map<String, dynamic> toJson() => _$SeoModelUserToJson(this);

  @override
  List<Object?> get props =>
      [id, firstName, lastName, email, phoneNumber, role];
}
