import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'news_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> newsArticles = [];
  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  Future<void> _loadNews() async {
    final prefs = await SharedPreferences.getInstance();
    final String? newsJson = prefs.getString('news');
    
    if (newsJson != null) {
      final List<dynamic> decoded = jsonDecode(newsJson);
      setState(() {
        newsArticles = decoded.map((item) => Map<String, String>.from(item)).toList();
      });
    } else {
      newsArticles = [
        {
          'title': 'Breaking News: Flutter 4.0 Released',
          'summary': 'New features and improvements announced',
          'content': 'Flutter 4.0 brings exciting new features including improved performance, new widgets, and enhanced developer tools.',
          'image': 'https://picsum.photos/400/200?random=1',
        },
        {
          'title': 'Tech Giants Announce AI Partnership',
          'summary': 'Collaboration aims to advance AI technology',
          'content': 'Leading technology companies have formed a partnership to advance artificial intelligence research and development.',
          'image': 'https://picsum.photos/400/200?random=2',
        },
        {
          'title': 'Climate Summit Reaches Agreement',
          'summary': 'Nations commit to carbon reduction targets',
          'content': 'World leaders have reached a historic agreement on carbon reduction targets to achieve net-zero emissions by 2050.',
          'image': 'https://picsum.photos/400/200?random=3',
        },
      ];
      await prefs.setString('news', jsonEncode(newsArticles));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Reader'),
        elevation: 2,
      ),
      body: newsArticles.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
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
                            content: article['content']!,
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