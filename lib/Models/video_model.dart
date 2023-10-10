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
    cat = json['cat'] != null ? new Cat.fromJson(json['cat']) : null;
    chap = json['chap'] != null ? new Chap.fromJson(json['chap']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['number'] = this.number;
    data['category_id'] = this.categoryId;
    data['chapter_id'] = this.chapterId;
    data['video'] = this.video;
    data['link'] = this.link;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['videoWithLink'] = this.videoWithLink;
    if (this.cat != null) {
      data['cat'] = this.cat!.toJson();
    }
    if (this.chap != null) {
      data['chap'] = this.chap!.toJson();
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

  Cat(
      {this.id,
      this.name,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.imageWithLink});

  Cat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imageWithLink = json['imageWithLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['imageWithLink'] = this.imageWithLink;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
