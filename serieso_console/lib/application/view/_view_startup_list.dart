import 'package:flutter/material.dart';
import 'package:serieso_console/application/models/model_startup_register_request/seo_model_startup_register_request.dart';
import 'package:serieso_console/application/pages/_page_startup_details.dart';
import 'package:serieso_console/application/services/_service_firebase.dart';

class ViewStartupList extends StatefulWidget {
  const ViewStartupList({super.key});

  @override
  State<ViewStartupList> createState() => _ViewStartupListState();
}

class _ViewStartupListState extends State<ViewStartupList> {
  late Size size;

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height,
      child: FutureBuilder<List<SeoModelStartupRegisterRequest>>(
        future: FirebaseServiceImpl().getStartups(),
        builder: (context, data) {
          if (data.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.data!.isEmpty) {
            return const Center(
              child: Text("No Startup found"),
            );
          }

          return ListView.builder(
            itemCount: data.data?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              final document = data.data![index];
              // Create your list item widget using the document data
              return ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => StartupDetailsPage(
                        startup: document,
                      ),
                    ),
                  );
                },
                // leading: CachedNetworkImage(
                //   imageUrl: document.logoUrl,
                //   placeholder: (context, url) =>
                //       const CircularProgressIndicator(),
                //   errorWidget: (context, url, error) => const Icon(Icons.error),
                // ),
                title: Text(document.companyName),
                subtitle: Text(
                  "CIN Number : ${document.cinNumber}\nCompany PAN : ${document.companyPan}",
                ),
              );
            },
          );
        },
      ),
    );
  }
}
