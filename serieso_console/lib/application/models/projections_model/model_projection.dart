import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model_projection.g.dart';

@JsonSerializable()
class Projection extends Equatable {
  final int year;
  final double revenueAmout;
  final double expenseAmount;

  const Projection({
    required this.year,
    required this.revenueAmout,
    required this.expenseAmount,
  });

  factory Projection.fromJson(Map<String, dynamic> data) =>
      _$ProjectionFromJson(data);

  Map<String, dynamic> toJson() => _$ProjectionToJson(this);

  @override
  List<Object?> get props => [
        year,
        revenueAmout,
        expenseAmount,
      ];
}
