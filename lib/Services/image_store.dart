import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

Future<String> uploadImageAndGetUrl(File imageFile) async {
  try {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('images')
        .child('quiz_${DateTime.now().millisecondsSinceEpoch}.jpg');

    await ref.putFile(imageFile);
    String imageUrl = await ref.getDownloadURL();

    return imageUrl;
  } catch (e) {
    print('Erreur lors du téléchargement de l\'image: $e');
    throw e; // Gérer l'erreur de téléchargement ici
  }
}
