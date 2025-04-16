import 'package:flutter/material.dart';
import 'package:project_app/models/project_model.dart';
import 'package:project_app/widgets/my_app_bar.dart';

class DetailProject extends StatefulWidget {
  final ProjectModel project;
  final Function(ProjectModel) onDelete;
  final Function(ProjectModel) onFavoriteChanged;

  const DetailProject({
    super.key,
    required this.project,
    required this.onDelete,
    required this.onFavoriteChanged,
  });

  @override
  State<DetailProject> createState() => _DetailProjectState();
}

class _DetailProjectState extends State<DetailProject> {
  void toggleFavorite() {
    setState(() {
      widget.project.isFavorite = !widget.project.isFavorite;
      widget.onFavoriteChanged(widget.project);
    });
  }

  void deleteProject() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Conferma eliminazione'),
          content: const Text('Sei sicuro di voler eliminare questo progetto?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annulla'),
            ),
            TextButton(
              onPressed: () {
                widget.onDelete(widget.project);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text(
                'Elimina',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: widget.project.name,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 600,
                child: Image.network(
                  widget.project.image,
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image,
                        size: 250, color: Colors.grey);
                  },
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.project.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.project.target,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      widget.project.isFavorite
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.redAccent,
                      size: 30,
                    ),
                    onPressed: toggleFavorite,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.project.description,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: deleteProject,
        backgroundColor: Colors.red,
        child: const Icon(Icons.delete),
      ),
    );
  }
}
