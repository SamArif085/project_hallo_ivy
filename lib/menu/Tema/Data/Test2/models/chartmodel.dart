 import 'dart:convert';

    List<GenderModel> genderModelFromJson(List data) => List<GenderModel>.from(
          data.map(
            (x) => GenderModel.fromJson(x),
          ),
        );
    
    class GenderModel {
      GenderModel({
        required this.name,
        required this.gender,
        required this.probability,
        required this.count,
      });
    
      String name;
      String gender;
      double probability;
      int count;
    
      factory GenderModel.fromJson(Map<String, dynamic> json) => GenderModel(
            name: json["name"],
            gender: json["gender"],
            probability: json["probability"].toDouble(),
            count: json["count"],
          );
    }