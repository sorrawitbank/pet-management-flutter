import 'package:flutter/material.dart';

class Pet {
  final String petId;
  String petType;
  String petName;
  String breedName;
  Gender gender;
  double? weight;
  List<PetColor>? color;
  DateTime? birthday;
  String age;
  String story;
  String imageUrl;
  String imageId;
  Pet({
    required this.petId,
    required this.petType,
    required this.petName,
    this.breedName = '',
    this.gender = Gender.none,
    this.weight,
    this.color,
    this.birthday,
    this.age = '',
    this.story = '',
    this.imageUrl = '',
    this.imageId = '',
  });

  factory Pet.fromJson(String petId, Map<String, dynamic> jsonMap) {
    final gender = Gender.values.firstWhere(
      (gender) => gender.text == jsonMap['gender'],
      orElse: () => Gender.none,
    );
    final colorList =
        PetColor.values
            .where((color) => jsonMap['color']?.contains(color.text) ?? false)
            .toList();
    final age = calculateAge(jsonMap['birthday']?.toDate());
    return Pet(
      petId: petId,
      petType: jsonMap['pet_type'],
      petName: jsonMap['pet_name'],
      breedName: jsonMap['breed_name'] ?? '',
      gender: gender,
      weight: jsonMap['weight'],
      color: colorList,
      birthday: jsonMap['birthday']?.toDate(),
      age: age,
      story: jsonMap['story'] ?? '',
      imageUrl: jsonMap['image_url'] ?? '',
      imageId: jsonMap['image_id'] ?? '',
    );
  }

  static Map<String, dynamic> toJson(String uid, Pet pet) {
    final colorList = pet.color?.map((color) => color.text).toList() ?? [];
    colorList.sort();

    final Map<String, dynamic> petMap = {
      'pet_type': pet.petType,
      'pet_name': pet.petName,
      'breed_name': pet.breedName,
      'gender': pet.gender.text,
      'weight': pet.weight,
      'color': colorList,
      'birthday': pet.birthday,
      'story': pet.story,
      'image_url': pet.imageUrl,
      'image_id': pet.imageId,
    };
    if (uid.isNotEmpty) {
      petMap['owner_id'] = uid;
    }
    return petMap;
  }

  static String calculateAge(DateTime? birthday) {
    if (birthday == null) {
      return '';
    }
    final now = DateTime.now();

    int yearDiff = now.year - birthday.year;
    int monthDiff = now.month - birthday.month;
    if (now.day < birthday.day) {
      monthDiff -= 1;
    }
    if (monthDiff < 0) {
      yearDiff -= 1;
      monthDiff += 12;
    }
    return '${yearDiff != 0 ? '${yearDiff}y ' : ''}${monthDiff}m';
  }
}

enum Gender {
  none('None', Colors.black, Icons.question_mark),
  male('Male', Color(0xFF1565C0), Icons.male),
  female('Female', Color(0xFFF576AC), Icons.female);

  final String text;
  final Color color;
  final IconData icon;

  const Gender(this.text, this.color, this.icon);
}

enum PetColor {
  amber('Amber', Colors.amber),
  apricot('Apricot', Color(0xFFFBCEB1)),
  beige('Beige', Color(0xFFEDE8D0)),
  black('Black', Colors.black),
  blue('Blue', Colors.blue),
  blueGrey('Blue Grey', Colors.blueGrey),
  brown('Brown', Colors.brown),
  champagne('Champagne', Color(0xFFF7E7CE)),
  charcoal('Charcoal', Color(0xFF36454F)),
  chocolate('Chocolate', Color(0xFF381819)),
  cream('Cream', Color(0xFFFDFBD4)),
  creamWhite('Cream White', Color(0xFFFFFDD0)),
  cyan('Cyan', Colors.cyan),
  fawn('Fawn', Color(0xFFE5AA70)),
  gold('Gold', Color(0xFFEFBF04)),
  green('Green', Colors.green),
  grey('Grey', Colors.grey),
  indigo('Indigo', Colors.indigo),
  lightBlue('Light Blue', Colors.lightBlue),
  lightGreen('Light Green', Colors.lightGreen),
  lime('Lime', Colors.lime),
  magenta('Magenta', Color(0xFFFD3DB5)),
  navyBlue('Navy Blue', Color(0xFF000080)),
  orange('Orange', Colors.orange),
  pink('Pink', Color(0xFFFF8DA1)),
  purple('Purple', Colors.purple),
  red('Red', Colors.red),
  rust('Rust', Color(0xFFB7410E)),
  sable('Sable', Color(0xFF5C3A21)),
  silver('Silver', Color(0xFFC0C0C0)),
  tan('Tan', Color(0xFFD2B48C)),
  teal('Teal', Colors.teal),
  white('White', Colors.white),
  yellow('Yellow', Colors.yellow);

  final String text;
  final Color color;

  const PetColor(this.text, this.color);
}
