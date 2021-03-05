part of 'utils.dart';

Future<String> getImage(bool isGallery) async {
  final pickedFile = await picker.getImage(
      source: (isGallery) ? ImageSource.gallery : ImageSource.camera,
      imageQuality: 10);
  print(pickedFile.path);
  return pickedFile.path;
}

Future<String> getVideo(bool isGallery) async {
  final pickedFile = await picker.getVideo(
      source: (isGallery) ? ImageSource.gallery : ImageSource.camera,
      maxDuration: Duration(seconds: 30));
  print(pickedFile.path);
  return pickedFile.path;
}
