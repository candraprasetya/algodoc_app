part of 'services.dart';

class ChatService {
  static final CollectionReference chatCollection =
      FirebaseFirestore.instance.collection('chats');

  static final FirebaseStorage storage = FirebaseStorage.instance;
  static final Reference reference = storage.ref().child('image');

  static Future<String> uploadImage(File image) async {
    int tanggal = DateTime.now().millisecondsSinceEpoch;
    String fileName = 'chat/$tanggal';

    Reference ref = storage.ref().child(fileName);
    UploadTask task = ref.putFile(image);
    TaskSnapshot snapshot = await task.whenComplete(() => ref.getDownloadURL());

    return await snapshot.ref.getDownloadURL();
  }

  static Future<String> uploadSound(String voice) async {
    int tanggal = DateTime.now().millisecondsSinceEpoch;
    String fileName = 'chat/$tanggal';

    Reference ref = storage.ref().child(fileName);
    UploadTask task = ref.putString(voice);
    TaskSnapshot snapshot = await task.whenComplete(() => ref.getDownloadURL());

    return await snapshot.ref.getDownloadURL();
  }

  static Future<void> sendMessage(ChatModel chatModel) async {
    await ChatService.chatCollection.add({
      'imageUrl': chatModel.imageUrl,
      'message': chatModel.message,
      'voiceUrl': chatModel.voiceUrl,
      'videoUrl': chatModel.videoUrl,
      'locationLat': chatModel.locationLat,
      'locationLong': chatModel.locationLong,
      'sender': chatModel.sender,
      'dateTime': chatModel.dateTime ?? DateTime.now().millisecondsSinceEpoch,
      'messageType': chatModel.messageType ?? 'text'
    });
  }
}
