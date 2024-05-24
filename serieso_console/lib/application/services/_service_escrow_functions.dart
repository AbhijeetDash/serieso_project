import 'dart:convert';
import 'dart:developer';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:serieso_console/application/models/escrow_account_model/model_escrow_account.dart';

import '../models/model_startup_register_request/seo_model_startup_register_request.dart';

abstract class ServiceEscrow {
  Future<void> openEscrow(SeoModelStartupRegisterRequest startup);

  Future<List<EscrowAccount>> getAllEscrow();
}

class ServiceEscrowImpl extends ServiceEscrow {
  final functions = FirebaseFunctions.instance;

  @override
  Future<void> openEscrow(SeoModelStartupRegisterRequest startup) async {
    try {
      final result = await functions.httpsCallable('openEscrowAccount').call({
        "startup_id": startup.requestId,
        "startup_name": "${startup.companyName}_${startup.requestId}",
        "terms_and_conditions": "Some long terms and conditions",
        "key_deliverables": "Some long key deliverables that we decided",
      });
      final response = result.data as Map<String, dynamic>;
      log(response.toString());
    } on FirebaseFunctionsException catch (e) {
      log(e.code);
      rethrow;
    }
  }

  @override
  Future<List<EscrowAccount>> getAllEscrow() async {
    try {
      List<EscrowAccount> accounts = [];
      final result =
          await functions.httpsCallable('getListAllEscrowAccount').call();
      Map<String, dynamic> response = json.decode(result.data);
      for (Map<String, dynamic> element in response['data']) {
        accounts.add(EscrowAccount.fromJson(element));
      }
      return accounts;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
