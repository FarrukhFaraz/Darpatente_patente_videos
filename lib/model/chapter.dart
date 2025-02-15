import 'category.dart';

class ChaptersModel {
  int? id;
  int? userId;
  int? chapterId;
  String? createdAt;
  String? updatedAt;
  Chapter? chapter;

  ChaptersModel({this.id, this.userId, this.chapterId, this.createdAt, this.updatedAt, this.chapter});

  ChaptersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    chapterId = json['chapter_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    chapter = json['chapter'] != null ? Chapter.fromJson(json['chapter']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['chapter_id'] = chapterId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (chapter != null) {
      data['chapter'] = chapter!.toJson();
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
  CategoryModel? cat;

  Chapter({this.id, this.categoryId, this.name, this.createdAt, this.updatedAt, this.cat});

  Chapter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    cat = json['cat'] != null ? CategoryModel.fromJson(json['cat']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (cat != null) {
      data['cat'] = cat!.toJson();
    }
    return data;
  }
}
