class DemoChapter {
  int? id;
  String? name;
  String? description;
  String? link;
  String? createdAt;
  String? updatedAt;
  int? categoryId;

  DemoChapter({this.id, this.name, this.description, this.link, this.createdAt, this.updatedAt, this.categoryId});

  DemoChapter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    link = json['link'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['link'] = link;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['category_id'] = categoryId;
    return data;
  }
}
