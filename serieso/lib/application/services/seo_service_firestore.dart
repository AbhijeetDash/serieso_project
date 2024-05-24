import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serieso/application/models/model_startup_register_request/seo_model_startup_register_request.dart';
import 'package:serieso/application/models/model_user/seo_model_user.dart';
import 'package:serieso/application/services/seo_utility_service.dart';

abstract class SeoFirestoreService {
  static const String cUserCollectionName = "seo_users";
  static const String cStartupRequestCollectionName =
      "seo_startup_registration_requests";
  static const String cStartupsCollectionName = "seo_startups";
  static const String cUserPhoneCollectionName = "seo_phone_numbers";

  Future<void> createPlatformUser(SeoModelUser user);

  Future<SeoModelUser> getPlatformUser(String uid);

  Future<SeoModelStartupRegisterRequest> getStartupRegistrationRequest(
      String startupId);

  Future<bool> checkPhoneNumber(String phoneNumber);

  Future<bool> createStartupRegistrationRequest(
      {required SeoModelStartupRegisterRequest request, required String uid});

  Future<void> addPhoneNumber(String phoneNumber, String uid);
}

class SeoFirestoreServiceImpl extends SeoFirestoreService {
  final FirebaseFirestore fireStoreInstance = FirebaseFirestore.instance;

  @override
  Future<void> createPlatformUser(SeoModelUser user) {
    try {
      final userCollection =
          fireStoreInstance.collection(SeoFirestoreService.cUserCollectionName);
      return userCollection
          .doc(user.id)
          .set(user.toJson(), SetOptions(merge: true));
    } catch (e) {
      log("Error occurred while creating user : $e");
      rethrow;
    }
  }

  @override
  Future<SeoModelUser> getPlatformUser(String uid) async {
    try {
      final userCollection =
          fireStoreInstance.collection(SeoFirestoreService.cUserCollectionName);
      final userData = await userCollection.doc(uid).get();
      if (userData.exists) {
        final SeoModelUser model = SeoModelUser.fromJson(userData.data()!);
        return model;
      }
      throw Exception("User Not Found");
    } catch (e) {
      log("Error occurred while fetching user : $e");
      rethrow;
    }
  }

  @override
  Future<bool> createStartupRegistrationRequest(
      {required SeoModelStartupRegisterRequest request,
      required String uid}) async {
    try {
      final startupRequestCollection = fireStoreInstance
          .collection(SeoFirestoreService.cStartupRequestCollectionName);
      final userCollection =
          fireStoreInstance.collection(SeoFirestoreService.cUserCollectionName);

      // Create startup id.
      String requestId = SeoUtilityService.getRandomString(16);
      SeoModelStartupRegisterRequest requestModel =
          request.copyWith(requestId: requestId);

      log(requestModel.toJson().toString());

      await startupRequestCollection.doc(requestId).set(
            requestModel.toJson(),
            SetOptions(merge: true),
          );

      await userCollection.doc(uid).set({
        "hasStartup": true,
        "startupID": requestId,
      }, SetOptions(merge: true));

      return Future.value(true);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SeoModelStartupRegisterRequest> getStartupRegistrationRequest(
      String startupId) async {
    try {
      final startupRequestCollection = fireStoreInstance
          .collection(SeoFirestoreService.cStartupRequestCollectionName);
      final startupRequestDetails =
          await startupRequestCollection.doc(startupId).get();

      if (startupRequestDetails.exists) {
        return SeoModelStartupRegisterRequest.fromJson(
            startupRequestDetails.data()!);
      }
      throw Exception("Request Not Found");
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<bool> checkPhoneNumber(String phoneNumber) async {
    try {
      final phoneCollection = fireStoreInstance
          .collection(SeoFirestoreService.cUserPhoneCollectionName);
      final details = await phoneCollection.doc(phoneNumber).get();
      return details.exists;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addPhoneNumber(String phoneNumber, String uid) async {
    try {
      final phoneCollection = fireStoreInstance
          .collection(SeoFirestoreService.cUserPhoneCollectionName);
      await phoneCollection.doc(phoneNumber).set({"uid": uid});
    } catch (e) {
      rethrow;
    }
  }
}
