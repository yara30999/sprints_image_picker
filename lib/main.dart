import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final List<File> _imageFiles = [];

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    List<XFile>? files = await picker.pickMultiImage();

    if (files.isNotEmpty) {
      setState(() {
        _imageFiles.addAll(files.map((file) => File(file.path)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Picker App')),
      body: Column(
        children: [
          Expanded(
            child: _imageFiles.isEmpty
                ? const Center(
                    child: Text(
                      'No images selected',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )
                : ListView.builder(
                    itemCount: _imageFiles.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card.filled(
                          child: Image.file(
                            _imageFiles[index],
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _pickImages,
              child: const Text('Pick Images'),
            ),
          ),
        ],
      ),
    );
  }
}
