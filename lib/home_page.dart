import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_course_navigator/image_card.dart';
import 'package:flutter_course_navigator/image_page.dart';
import 'package:flutter_course_navigator/info.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final items = List.generate(30, (index) => index);

  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()
      ..addListener(() {
        if (_controller.position.maxScrollExtent == _controller.offset) {
          _fetchItems();
        }
      });
  }

  void _fetchItems() {
    setState(() {
      items.addAll(
        List.generate(
          30,
          (index) => items.length + index,
        ),
      );
    });
    _controller.jumpTo(_controller.position.maxScrollExtent + 50);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Picsum Browser'),
      ),
      body: ListView.builder(
        controller: _controller,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final info = loadImageInfo(index, context);
          return ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            onTap: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return ImagePage(
                  url: 'https://picsum.photos/400/400?image=$index',
                  title: info,
                  child: ImageCard(
                    index: index,
                    height: 400,
                    width: 400,
                  ),
                );
              },
            )),
            title: loadImageInfo(index, context),
            leading: ImageCard(index: index),
          );
        },
      ),
    );
  }

  FutureBuilder<ImageInformation> loadImageInfo(
      int index, BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder(
      future: _loadImageInfo(id: index),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Row(
            children: [
              Icon(Icons.question_mark),
            ],
          );
        } else {
          if (snapshot.hasData) {
            return Text(snapshot.data!.author);
          } else {
            return Shimmer.fromColors(
              baseColor: theme.colorScheme.onSurface.withOpacity(0.05),
              highlightColor: theme.colorScheme.onSurface.withOpacity(0.1),
              child: Container(
                decoration: BoxDecoration(
                    color: theme.colorScheme.background,
                    borderRadius: BorderRadius.circular(8)),
                height: 40,
                width: 80,
              ),
            );
          }
        }
      },
    );
  }

  Future<ImageInformation> _loadImageInfo({required int id}) async {
    final address = 'https://picsum.photos/id/$id/info';
    final uri = Uri.parse(address);
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      return Future.error('Could not find $address');
    }
    return ImageInformation.fromJson(jsonDecode(response.body));
  }
}
