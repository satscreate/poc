import 'package:cloud_firestore/cloud_firestore.dart';

import 'organization.dart';

class OrganizationRepository {
  final CollectionReference _organizationsCollection =
      FirebaseFirestore.instance.collection('tic');

  Future<String> createOrganization(Organization organization) async {
    final docRef =
        await _organizationsCollection.add({'name': organization.name});
    return docRef.id;
  }

  Future<List<Organization>> getAllOrganizations() async {
    try {
      final querySnapshot = await _organizationsCollection.get();
      final organizationDocs = querySnapshot.docs;

      return organizationDocs
          .map((doc) => Organization(name: doc.get('name')))
          .toList();
    } catch (e) {
      print('Error fetching organizations: $e');
      throw e;
    }
  }

  // Add update and delete methods here if needed
}
