// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seo_model_projection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Projection _$ProjectionFromJson(Map<String, dynamic> json) => Projection(
      year: json['year'] as int,
      revenueAmout: (json['revenueAmout'] as num).toDouble(),
      expenseAmount: (json['expenseAmount'] as num).toDouble(),
    );

Map<String, dynamic> _$ProjectionToJson(Projection instance) =>
    <String, dynamic>{
      'year': instance.year,
      'revenueAmout': instance.revenueAmout,
      'expenseAmount': instance.expenseAmount,
    };
