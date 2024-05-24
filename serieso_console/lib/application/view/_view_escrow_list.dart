import 'package:flutter/material.dart';
import 'package:serieso_console/application/models/escrow_account_model/model_escrow_account.dart';
import 'package:serieso_console/application/services/_service_escrow_functions.dart';

class ViewEscrowList extends StatefulWidget {
  const ViewEscrowList({Key? key}) : super(key: key);

  @override
  State<ViewEscrowList> createState() => _ViewEscrowListState();
}

class _ViewEscrowListState extends State<ViewEscrowList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<EscrowAccount>>(
        future: ServiceEscrowImpl().getAllEscrow(),
        builder: (context, snap) {
          if (snap.data == null) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const Center(
              child: Text("NO ACCOUNTS FOUND"),
            );
          }

          int itemCount = snap.data!.length;
          List<EscrowAccount> accounts = snap.data!;
          return ListView.builder(
            itemCount: itemCount,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(accounts[index].escrowName),
                subtitle: Text(accounts[index].escrowId),
                onTap: () {
                  showDetailPopup(accounts[index]);
                },
              );
            },
          );
        },
      ),
    );
  }

  void showDetailPopup(EscrowAccount account) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Account Details",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 14.0),
                  const Text("Account Name",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(account.escrowName),
                  const SizedBox(height: 10.0),
                  const Text("Account ID",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(account.escrowId),
                  const SizedBox(height: 10.0),
                  const Text("Key Deliverables",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(account.keyDeliverables),
                  const SizedBox(height: 10.0),
                  const Text("Terms and Conditions",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(account.tnc),
                  const SizedBox(height: 14.0),
                ],
              ),
            ),
          );
        });
  }
}
