import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../widgets/custom_image.dart';
import '../widgets/icon_box.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconBox(
              bgColor: Colors.black54.withOpacity(0.055),
              isShadow: false,
              radius: 30,
              padding: const EdgeInsets.all(10),
              onTap: () {
                Navigator.pop(context);
              },
              child: const Center(
                child: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.black38,
                  size: 18,
                ),
              ),
            ),
            const Text(
              'جزییات',
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Icon(
              Icons.bookmark_outline,
              color: Colors.black38,
              size: 32,
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SafeArea(
                child: Text(
                  data['title'],
                  overflow: TextOverflow.visible,
                  softWrap: true,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      data['category'],
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'april 8, 2022',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              CustomImage(
                data['image'],
                radius: 0,
                borderRadius: const BorderRadius.all(
                  Radius.circular(14),
                ),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
              ),
              const SizedBox(
                height: 18,
              ),
              Html(
                data: data['description'],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
