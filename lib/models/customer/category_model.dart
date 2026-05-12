import 'package:fork_mate/models/customer/services_model.dart';

class CategoryModel {
  final int id;
  final String title;
  final ServiceModel service;
  CategoryModel({required this.id, required this.title, required this.service});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      title: json['title'],
      service: ServiceModel.fromJson(json['service']),
    );
  }
}
