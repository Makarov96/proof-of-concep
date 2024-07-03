import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:just_in_play_proof/core/core_config/country/datasources/model/country_model.dart';
import 'package:just_in_play_proof/core/core_config/country/domain/entity/entity.dart';
import 'package:just_in_play_proof/core/core_config/country/domain/repository/country_repository.dart';
import 'package:just_in_play_proof/core/error/error.dart';

class ApiCountryDataSource extends CountryRepository {
  final FirebaseFirestore _firebaseFirestore;
  ApiCountryDataSource({
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore;
  @override
  Future<(JustInPLayException?, List<Country>)> getCountry() async {
    try {
      var collection = _firebaseFirestore.collection('country');

      var querySnapshot = await collection.get();
      final data = querySnapshot.docs
          .map((e) => CountryModel.fromMap(e.data()))
          .toList();
      return (null, data);
    } on FirebaseException catch (e) {
      var emptyList = <Country>[];
      return (
        FirebaseError(
          message: e.message,
          preffix: e.code,
        ),
        emptyList
      );
    }
  }
}
