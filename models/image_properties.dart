import 'dart:io';

class SavedImage {
  final File? imgFile;
  final String? imgPath;

  SavedImage({this.imgFile, this.imgPath});


  SavedImage.fromMap(Map<String, dynamic> map)
      : imgFile = map["imgFile"],
        imgPath = map["imgPath"];

  Map<String, dynamic> toMap() => {"imgFile": imgFile, "imgPath": imgPath};
}