import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mybooknote/database/repositories/anotations/i_anotation_repository.dart';

class AnotationRepository implements IAnotationRepository {
  @override
  Future addImage() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    var collectionData = db
        .collection("subjects")
        .doc('5M9geOM4qoDARvcXDGW8')
        .collection('anotations')
        .doc('SVDql2ksXroWaZspBFuY');
    var get = await collectionData.get();
    var images = get.data()?['images'] as List;
    images = [...images, 'foto2'];

    await collectionData.set({'images': images}, SetOptions(merge: true));
  }

  @override
  Future create() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    var collectionData = db.collection("subjects").doc('5M9geOM4qoDARvcXDGW8').collection('anotations');
    await collectionData.add({
      'title': 'Geo aula 12',
      'description': 'Aula feita com o Sales',
      'images': [],
    });
  }
}
