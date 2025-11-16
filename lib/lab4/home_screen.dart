import 'package:flutter/material.dart';
import 'news_detail.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, String>> newsArticles = const [
    {
      'title': 'Breaking News: Flutter 4.0 Released',
      'summary': 'New features and improvements announced',
      'image': 'https://picsum.photos/400/200?random=1',
    },
    {
      'title': 'Tech Giants Announce AI Partnership',
      'summary': 'Collaboration aims to advance AI technology',
      'image': 'https://picsum.photos/400/200?random=2',
    },
    {
      'title': 'Climate Summit Reaches Agreement',
      'summary': 'Nations commit to carbon reduction targets',
      'image': 'https://picsum.photos/400/200?random=3',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Reader'),
        elevation: 2,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: newsArticles.length,
        itemBuilder: (context, index) {
          final article = newsArticles[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsDetailScreen(
                      title: article['title']!,
                      content: article['summary']!,
                      imageUrl: article['image']!,
                    ),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(4),
                    ),
                    child: Image.network(
                      article['image']!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article['title']!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          article['summary']!,
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}