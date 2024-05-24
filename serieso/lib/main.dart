import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:serieso/application/seo_application_material.dart';
import 'package:serieso/application/services/seo_service_locator.dart';
import 'package:serieso/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Registers all the Services in GetIt
  SeoLocatorService.setupLocator();

  if (kDebugMode) {
    print('Initialized default app $app');

    //   try {
    //     FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    //     await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    //     await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
    //   } catch (e) {
    //     throw Exception("Debug mode emulator error : $e");
    //   }
  }
  runApp(const SeoMaterialApp());
}
