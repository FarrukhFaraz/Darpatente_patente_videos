import 'category.dart';
import 'chapter.dart';

class UserDataModel {
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
  CategoryModel? category;
  List<ChaptersModel>? chapters;

  UserDataModel(
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

  UserDataModel.fromJson(Map<String, dynamic> json) {
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
    category = json['category'] != null ? CategoryModel.fromJson(json['category']) : null;
    if (json['chapters'] != null) {
      chapters = <ChaptersModel>[];
      json['chapters'].forEach((v) {
        chapters!.add(ChaptersModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['phone'] = phone;
    data['image'] = image;
    data['category_id'] = categoryId;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['status'] = status;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (chapters != null) {
      data['chapters'] = chapters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
