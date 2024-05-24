// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seo_model_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeoModelUser _$SeoModelUserFromJson(Map<String, dynamic> json) => SeoModelUser(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
      startupID: json['startupID'] as String?,
    );

Map<String, dynamic> _$SeoModelUserToJson(SeoModelUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'role': _$UserRoleEnumMap[instance.role]!,
      'startupID': instance.startupID,
    };

const _$UserRoleEnumMap = {
  UserRole.investor: 'investor',
  UserRole.startup: 'startup',
};
