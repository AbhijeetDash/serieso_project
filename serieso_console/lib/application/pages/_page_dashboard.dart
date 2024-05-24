import 'package:flutter/material.dart';
import 'package:serieso_console/application/view/_view_escrow_list.dart';
import 'package:serieso_console/application/view/_view_settings.dart';
import 'package:serieso_console/application/view/_view_startup_list.dart';

class PageDashboard extends StatefulWidget {
  const PageDashboard({super.key});

  @override
  State<PageDashboard> createState() => _PageDashboardState();
}

class _PageDashboardState extends State<PageDashboard> {
  int selectedIndex = 0;

  @override
  void initState() {
    selectedIndex = 0;
    super.initState();
  }

  Widget getView() {
    switch (selectedIndex) {
      case 0:
        return const ViewStartupList();
      case 1:
        return const ViewEscrowList();
      case 2:
        return const ViewSettings();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.blueGrey.shade900,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "SeriesO Console",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 60.0),
                    const Divider(
                      color: Colors.white,
                    ),
                    ListTile(
                      onTap: () {
                        selectedIndex = 0;
                        setState(() {});
                      },
                      title: const Text(
                        "Listing requests",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    ListTile(
                      onTap: () {
                        selectedIndex = 1;
                        setState(() {});
                      },
                      title: const Text(
                        "Escrow Accounts",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    ListTile(
                      onTap: () {
                        selectedIndex = 2;
                        setState(() {});
                      },
                      title: const Text(
                        "Settings",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: getView(),
          ),
        ],
      ),
    );
  }
}
