import 'package:cloud_firestore/cloud_firestore.dart';
import'package:germaway/models/brew.dart';

class DataBaseService{

  final String uid;
  DataBaseService({this.uid});
  //collection reference
  final CollectionReference restrictionCollection = Firestore.instance.collection('Restrictions');

  Future updateUserData(String sugar, String name, int strength) async{
    return await restrictionCollection.document(uid).setData(
      {
        'sugar': sugar,
        'name': name,
        'strength': strength
      }
    );
  }

    //Brew list from snapshot

List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
return snapshot.documents.map((doc) {
return Brew(
  name:doc.data['name'] ?? '',
  sugar: doc.data['sugar'] ?? '0',
  strength: doc.data['strength'] ?? 100 
);
}).toList();
}
   //Get brews strem
  Stream<List<Brew>> get brews{
    return restrictionCollection.snapshots()
    .map(_brewListFromSnapshot); 
 }

}