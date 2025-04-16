import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:project_app/widgets/my_app_bar.dart';
import 'package:project_app/models/project_model.dart';
import 'package:project_app/pages/detail_project.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late Future<List<ProjectModel>> futureResponse;
  List<ProjectModel> projects = [];

  @override
  void initState() {
    super.initState();
    futureResponse = getData();

    futureResponse.then((value) {
      setState(() {
        projects = value;
      });
    });
  }

  Future<List<ProjectModel>> getData() async {
    final response = await http.get(
      Uri.parse(
          "https://my-json-server.typicode.com/zoelounge/menupizza/projects"),
    );
    final listJsonObj = json.decode(response.body) as List<dynamic>;

    return listJsonObj.map((jsonPost) {
      return ProjectModel.fromData(jsonPost);
    }).toList();
  }

  void navigateToDetails(BuildContext context, ProjectModel project) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailProject(
          project: project,
          onDelete: (ProjectModel deletedProject) {
            setState(() {
              projects.removeWhere((p) => p.id == deletedProject.id);
            });
          },
          onFavoriteChanged: (ProjectModel updatedProject) {
            setState(() {
              final index =
                  projects.indexWhere((p) => p.id == updatedProject.id);
              if (index != -1) {
                projects[index].isFavorite = updatedProject.isFavorite;
              }
            });
          },
        ),
      ),
    );
  }

//These are hardcoded into the project due to an issue
  String fixImageUrl(String url) {
    if (url.contains("sftcdn.net")) {
      return "https://upload.wikimedia.org/wikipedia/en/3/30/Java_programming_language_logo.svg";
    }
    if (url.contains("laramind.com")) {
      return "https://upload.wikimedia.org/wikipedia/commons/d/d1/Ionic_Logo.svg";
    }
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: MyAppBar(
          title: "Project App",
          showBackButton: false,
        ),
        body: body(),
      ),
    );
  }

  Widget body() {
    return FutureBuilder<List<ProjectModel>>(
      future: futureResponse,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Errore: ${snapshot.error}'),
          );
        }

        if (!snapshot.hasData || projects.isEmpty) {
          return const Center(
            child: Text('Nessun progetto disponibile'),
          );
        }

        return Center(
          child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 30,
              endIndent: 35,
            ),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];
              return ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 44),
                leading: Image.network(
                  project.image,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image,
                        size: 48, color: Colors.grey);
                  },
                ),
                title: Text(project.name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      project.isFavorite ? Icons.star : Icons.star_border,
                      color: Colors.redAccent,
                    ),
                    const SizedBox(width: 5),
                    const Icon(Icons.arrow_forward_ios),
                  ],
                ),
                onTap: () => navigateToDetails(context, project),
              );
            },
          ),
        );
      },
    );
  }
}
