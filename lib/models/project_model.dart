class ProjectModel {
  late int id;
  late String target;
  late String name;
  late String image;
  late String description;
  bool isFavorite;

  ProjectModel({
    required this.id,
    required this.target,
    required this.name,
    required this.image,
    required this.description,
    this.isFavorite = false,
  });

  factory ProjectModel.fromData(Map<String, dynamic> data) {
    final id = data['id'];
    final target = data['target'];
    final name = data['name'];
    final image = data['image'];
    final description = data['description'];
    return ProjectModel(
        id: id,
        target: target,
        name: name,
        image: image,
        description: description);
  }
}
