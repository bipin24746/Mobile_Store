import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetailsPage extends StatelessWidget {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: usersCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No users found.'));
          }

          List<DataRow> rows = snapshot.data!.docs.map((doc) {
            Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;

            return DataRow(cells: [
              DataCell(Text(userData['name'] ?? 'No Name')),
              DataCell(Text(doc.id)), // User ID
              DataCell(Text(userData['email'] ?? 'No Email')),
              DataCell(Text(userData['phone'] ?? 'No Phone')),
              DataCell(Text(userData['address'] ?? 'No Address')),
              // Add more cells for additional fields if needed
            ]);
          }).toList();

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Allows horizontal scrolling
            child: DataTable(
              columns: [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('User ID')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Phone')),
                DataColumn(label: Text('Address')),
                // Add more columns for additional fields if needed
              ],
              rows: rows,
            ),
          );
        },
      ),
    );
  }
}
