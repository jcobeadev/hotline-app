import 'package:hive/hive.dart';

part 'office.g.dart';

@HiveType(typeId: 0)
class Office {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<String>? mobile;

  @HiveField(3)
  final List<String>? phone;

  @HiveField(4)
  final String? radio;

  @HiveField(5)
  final String? imageUrl;

  Office({
    this.id,
    required this.name,
    this.mobile,
    this.phone,
    this.radio,
    this.imageUrl,
  });

  factory Office.fromJson(Map<String, dynamic> json) {
    return Office(
      id: json['id'],
      name: json['name'],
      mobile: (json['mobile'] as List?)?.map((e) => e.toString()).toList(),
      phone: (json['phone'] as List?)?.map((e) => e.toString()).toList(),
      radio: json['radio'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mobile': mobile,
      'phone': phone,
      'radio': radio,
      'image_url': imageUrl,
    };
  }
}
