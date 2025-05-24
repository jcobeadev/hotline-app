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
  final String imageAsset;

  @HiveField(6)
  final int? seq;

  Office({
    this.id,
    required this.name,
    this.mobile,
    this.phone,
    this.radio,
    required this.imageAsset,
    this.seq,
  });

  factory Office.fromJson(Map<String, dynamic> json) {
    return Office(
      id: json['id'],
      name: json['name'],
      mobile: (json['mobile'] as List?)?.map((e) => e.toString()).toList(),
      phone: (json['phone'] as List?)?.map((e) => e.toString()).toList(),
      radio: json['radio'],
      imageAsset: json['image_asset'] ?? 'default.png',
      seq: (json['seq'] ?? 99) as int, // ✅ fallback to 0 if missing
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mobile': mobile,
      'phone': phone,
      'radio': radio,
      'image_asset': imageAsset,
      'seq': seq,
    };
  }
}
