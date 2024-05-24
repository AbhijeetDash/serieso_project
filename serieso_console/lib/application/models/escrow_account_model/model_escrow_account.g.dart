// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_escrow_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EscrowAccount _$EscrowAccountFromJson(Map<String, dynamic> json) =>
    EscrowAccount(
      escrowId: json['escrow_id'] as String,
      escrowName: json['escrow_name'] as String,
      keyDeliverables: json['key_deliverables'] as String,
      tnc: json['terms_and_conditions'] as String,
    );

Map<String, dynamic> _$EscrowAccountToJson(EscrowAccount instance) =>
    <String, dynamic>{
      'escrow_id': instance.escrowId,
      'escrow_name': instance.escrowName,
      'key_deliverables': instance.keyDeliverables,
      'terms_and_conditions': instance.tnc,
    };
