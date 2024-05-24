import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model_escrow_account.g.dart';

@JsonSerializable()
class EscrowAccount extends Equatable {
  @JsonKey(name: "escrow_id")
  final String escrowId;
  @JsonKey(name: "escrow_name")
  final String escrowName;
  @JsonKey(name: "key_deliverables")
  final String keyDeliverables;
  @JsonKey(name: "terms_and_conditions")
  final String tnc;

  const EscrowAccount({
    required this.escrowId,
    required this.escrowName,
    required this.keyDeliverables,
    required this.tnc,
  });

  factory EscrowAccount.fromJson(Map<String, dynamic> data) =>
      _$EscrowAccountFromJson(data);

  Map<String, dynamic> toJson() => _$EscrowAccountToJson(this);

  @override
  List<Object?> get props => [
        escrowId,
        escrowName,
        keyDeliverables,
        tnc,
      ];
}
