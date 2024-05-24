import 'package:flutter/material.dart';
import 'package:serieso_console/application/services/_service_firebase.dart';

import '../models/model_startup_register_request/seo_model_startup_register_request.dart';

class StartupDetailsPage extends StatelessWidget {
  final SeoModelStartupRegisterRequest startup;

  const StartupDetailsPage({Key? key, required this.startup}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            Text(
              startup.companyName,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text('Founder: ${startup.founderName}'),
            Text('Email: ${startup.founderEmail}'),
            Text('LinkedIn: ${startup.founderLinkedIn}'),
            const SizedBox(height: 16.0),
            const Text(
              'Company Description:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Text(startup. ?? ""),
            // const SizedBox(height: 16.0),
            // const Text(
            //   'Problem Statement:',
            //   style: TextStyle(
            //     fontSize: 16.0,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // Text(startup.problemStatement ?? ""),
            // const SizedBox(height: 16.0),
            // const Text(
            //   'Solution Statement:',
            //   style: TextStyle(
            //     fontSize: 16.0,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // Text(startup.solutionStatement ?? ""),
            // const SizedBox(height: 16.0),
            // Text('Total Addressable Market (TAM): ${startup.tam}'),
            // Text('Serviceable Available Market (SAM): ${startup.sam}'),
            // Text('Serviceable Obtainable Market (SOM): ${startup.som}'),
            // const SizedBox(height: 16.0),
            // const Text(
            //   'Competitive Landscape:',
            //   style: TextStyle(
            //     fontSize: 16.0,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // Text(startup.competitiveLandscape ?? ""),
            // const SizedBox(height: 16.0),
            // const Text(
            //   'Revenue Model:',
            //   style: TextStyle(
            //     fontSize: 16.0,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // Text(startup.revenueModel ?? ""),
            // const SizedBox(height: 16.0),
            // const Text(
            //   'Growth Strategy:',
            //   style: TextStyle(
            //     fontSize: 16.0,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // Text(startup.growthStrategy ?? ""),
            // const SizedBox(height: 16.0),
            // const Text(
            //   'Market Traction:',
            //   style: TextStyle(
            //     fontSize: 16.0,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // Text(startup.marketTraction ?? ""),
            // const SizedBox(height: 16.0),
            // const Text(
            //   'Projections:',
            //   style: TextStyle(
            //     fontSize: 16.0,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // Text('Status: ${startup.status.name.toString().toUpperCase()}'),
            const SizedBox(height: 16.0),
            RawMaterialButton(
              onPressed: () {
                FirebaseServiceImpl().approveStartup(startup);
              },
              fillColor: Colors.blue,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Approve Application"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
