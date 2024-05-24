import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:serieso_console/application/serieso_console.dart';

import 'firebase_options.dart';

void main() async {
  // Ensure that firebase is initialised.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    try {
      FirebaseFunctions.instance.useFunctionsEmulator("localhost", 5001);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  runApp(const SeriesoConsole());
}
