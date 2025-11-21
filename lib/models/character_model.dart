class Character {
  final String id;
  final String name;
  final String house;
  final String species;
  final String actor;
  final String image;

  Character({
    required this.id,
    required this.name,
    required this.house,
    required this.species,
    required this.actor,
    required this.image,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown Name',
      house: json['house'] ?? 'No House',
      species: json['species'] ?? 'Unknown Species',
      actor: json['actor'] ?? 'Unknown Actor',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'house': house,
      'species': species,
      'actor': actor,
      'image': image,
    };
  }
}