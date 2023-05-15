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
          15,
          (index) => items.length + index,
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        controller: _controller,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final info = loadImageInfo(index, context);
          return ListTile(
            onTap: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return ImagePage(
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
          return Row(
            children: const [
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
    final response =
        await http.get(Uri.parse('https://picsum.photos/id/$id/info'));

    return ImageInformation.fromJson(response.body);
  }
}
