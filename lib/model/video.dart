class VideoModel {
  int? id;
  String? name;
  int? number;
  int? categoryId;
  int? chapterId;
  String? video;
  String? link;
  String? createdAt;
  String? updatedAt;
  String? videoWithLink;
  Cat? cat;
  Chap? chap;

  VideoModel(
      {this.id,
      this.name,
      this.number,
      this.categoryId,
      this.chapterId,
      this.video,
      this.link,
      this.createdAt,
      this.updatedAt,
      this.videoWithLink,
      this.cat,
      this.chap});

  VideoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    number = json['number'];
    categoryId = json['category_id'];
    chapterId = json['chapter_id'];
    video = json['video'];
    link = json['link'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    videoWithLink = json['videoWithLink'];
    cat = json['cat'] != null ? Cat.fromJson(json['cat']) : null;
    chap = json['chap'] != null ? Chap.fromJson(json['chap']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['number'] = number;
    data['category_id'] = categoryId;
    data['chapter_id'] = chapterId;
    data['video'] = video;
    data['link'] = link;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['videoWithLink'] = videoWithLink;
    if (cat != null) {
      data['cat'] = cat!.toJson();
    }
    if (chap != null) {
      data['chap'] = chap!.toJson();
    }
    return data;
  }
}

class Cat {
  int? id;
  String? name;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? imageWithLink;

  Cat({this.id, this.name, this.image, this.createdAt, this.updatedAt, this.imageWithLink});

  Cat.fromJson(Map<String, dynamic> json) {
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

class Chap {
  int? id;
  int? categoryId;
  String? name;
  String? createdAt;
  String? updatedAt;

  Chap({this.id, this.categoryId, this.name, this.createdAt, this.updatedAt});

  Chap.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
