class MultiImgModel {
  String image;

  MultiImgModel(this.image);

  Map<String, dynamic> toMap() {
    return {
      'image': image,
    };
  }
}