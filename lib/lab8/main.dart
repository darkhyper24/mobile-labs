import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/meals_provider.dart';
import 'ui/meals_page.dart';
void main() {
  runApp(const MealsApp());
}
class MealsApp extends StatelessWidget {
  const MealsApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MealsProvider(),
      child: MaterialApp(
        title: 'Meals Search',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MealsPage(),
      ),
    );
  }
}
