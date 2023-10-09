// ignore_for_file: public_member_api_docs, sort_constructors_first
class CategoryModel {
  String? id;
  String? name;

  CategoryModel({this.id, this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['_id'] as String?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };

  @override
  String toString() => 'CategoryModel(id: $id, name: $name)';
}
