class UserData {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? phone;
  String? image;
  int? categoryId;
  String? startDate;
  String? endDate;
  String? status;
  Category? category;
  List<Chapters>? chapters;

  UserData(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.phone,
      this.image,
      this.categoryId,
      this.startDate,
      this.endDate,
      this.status,
      this.category,
      this.chapters});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    phone = json['phone'];
    image = json['image'];
    categoryId = json['category_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    if (json['chapters'] != null) {
      chapters = <Chapters>[];
      json['chapters'].forEach((v) {
        chapters!.add(new Chapters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['category_id'] = this.categoryId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['status'] = this.status;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.chapters != null) {
      data['chapters'] = this.chapters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? image;
  String? createdAt;
  String? updatedAt;

  Category({this.id, this.name, this.image, this.createdAt, this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Chapters {
  int? id;
  int? userId;
  int? chapterId;
  String? createdAt;
  String? updatedAt;
  Chapter? chapter;

  Chapters(
      {this.id,
      this.userId,
      this.chapterId,
      this.createdAt,
      this.updatedAt,
      this.chapter});

  Chapters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    chapterId = json['chapter_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    chapter =
        json['chapter'] != null ? new Chapter.fromJson(json['chapter']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['chapter_id'] = this.chapterId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.chapter != null) {
      data['chapter'] = this.chapter!.toJson();
    }
    return data;
  }
}

class Chapter {
  int? id;
  int? categoryId;
  String? name;
  String? createdAt;
  String? updatedAt;
  Category? cat;

  Chapter(
      {this.id,
      this.categoryId,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.cat});

  Chapter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    cat = json['cat'] != null ? new Category.fromJson(json['cat']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.cat != null) {
      data['cat'] = this.cat!.toJson();
    }
    return data;
  }
}
