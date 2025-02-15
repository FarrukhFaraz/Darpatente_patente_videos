class DemoCategoryModel {
  int? id;
  String? name;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? imageWithLink;

  DemoCategoryModel({this.id, this.name, this.image, this.createdAt, this.updatedAt, this.imageWithLink});

  DemoCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imageWithLink = json['imageWithLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['imageWithLink'] = imageWithLink;
    return data;
  }
}
