import 'dart:convert';

class ImageModel {
  String? idImage;
  String? image;
  String? judul;
  String? deskripsi;

  ImageModel({this.idImage, this.image, this.judul, this.deskripsi});

  Map<String, dynamic> toMap() {
    return {
      "idImage": idImage,
      "image": image,
      "judul": judul,
      "deskripsi": deskripsi
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
        idImage: map["idImage"],
        image: map["image"],
        judul: map["judul"],
        deskripsi: map["deskripsi"]);
  }

  String toJson() => json.encode(toMap());
}
