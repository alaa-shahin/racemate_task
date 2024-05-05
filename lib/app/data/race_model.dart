import '../../core/utils/utils.dart';

class RaceModel {
  final String name;
  final String? organizer;
  final String date;
  final String country;
  final String city;
  final String image;
  final String type;
  final String distances;

  RaceModel({
    required this.name,
    required this.organizer,
    required this.date,
    required this.country,
    required this.city,
    required this.image,
    required this.type,
    required this.distances,
  });

  factory RaceModel.fromJson(Map<String, dynamic> json) {
    return RaceModel(
      name: json['name'],
      organizer: json['organizer'],
      date: formatDate(json['date']),
      country: json['country'],
      city: json['city'],
      image: json['image'],
      type: json['type'],
      distances: json['distances'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['organizer'] = organizer;
    data['date'] = date;
    data['country'] = country;
    data['city'] = city;
    data['image'] = image;
    data['type'] = type;
    data['distances'] = distances;
    return data;
  }
}
