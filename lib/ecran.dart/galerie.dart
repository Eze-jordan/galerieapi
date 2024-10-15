import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class Galerie extends StatelessWidget {
  const Galerie({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'TopGalerie',
      home: PhotoGrid(),
      debugShowCheckedModeBanner: false,

    );
  }
}

class PhotoGrid extends StatefulWidget {
  const PhotoGrid({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PhotoGridState createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  List photos = [];

  @override
  void initState() {
    super.initState();
    fetchPhotos();
  }

  Future<void> fetchPhotos() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos'),
    );

    if (response.statusCode == 200) {
      // Parse the JSON data
      setState(() {
        photos = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Center(
          child: Text('TopGalerie',style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),),
        ),
        backgroundColor: const Color(0xFF674AEF),

      ),

      body: photos.isEmpty

          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 images par ligne
                crossAxisSpacing: 5.0, // Espacement horizontal
                mainAxisSpacing: 5.0, // Espacement vertical
              ),
              itemCount: photos.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Card(
                    child: Image.network(
                      photos[index]['thumbnailUrl'],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
