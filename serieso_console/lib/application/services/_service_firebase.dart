import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serieso_console/application/models/model_startup_register_request/seo_model_startup_register_request.dart';
import 'package:serieso_console/application/services/_service_escrow_functions.dart';

import '../models/seo_enums/seo_enums.dart';

abstract class FirebaseService {
  static const cStartupRequestCollectionName =
      "seo_startup_registration_requests";

  static const cActiveStartupCollectionName = "seo_active_startups";
  Future<SeoModelStartupRegisterRequest> getStartup(String id);

  Future<List<SeoModelStartupRegisterRequest>> getStartups();

  Future<void> approveStartup(SeoModelStartupRegisterRequest startup);
}

class FirebaseServiceImpl extends FirebaseService {
  final registrationRequests = FirebaseFirestore.instance
      .collection(FirebaseService.cStartupRequestCollectionName);
  final approvedStartupsCollection = FirebaseFirestore.instance
      .collection(FirebaseService.cActiveStartupCollectionName);

  @override
  Future<SeoModelStartupRegisterRequest> getStartup(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<SeoModelStartupRegisterRequest>> getStartups() async {
    try {
      List<SeoModelStartupRegisterRequest> startups = [];
      final data = await registrationRequests.get();

      for (var element in data.docs) {
        startups.add(SeoModelStartupRegisterRequest.fromJson(element.data()));
      }
      return startups;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> approveStartup(SeoModelStartupRegisterRequest startup) async {
    try {
      // Make a call to firebase function to create Escrow account..
      // final res =
      //     await ServiceEscrowImpl().openEscrow(startup) as Map<String, dynamic>;
      // log(res.toString());
      // On success show all the details of the account on the page.

      registrationRequests.doc(startup.requestId).set(
          {"requestStatus": StartupRegistrationStatus.accepted.name},
          SetOptions(merge: true));

      approvedStartupsCollection.doc("listing_${startup.requestId}").set({
        "id": "listing_${startup.requestId}",
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
