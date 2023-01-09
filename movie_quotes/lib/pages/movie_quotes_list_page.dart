import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:movie_quotes/models/movie_quote.dart';

class MovieQuoteListPage extends StatefulWidget {
  const MovieQuoteListPage({super.key});

  @override
  State<MovieQuoteListPage> createState() => _MovieQuoteListPage();
}

class _MovieQuoteListPage extends State<MovieQuoteListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Quotes"),
      ),
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Text("Hello"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("You pressed the fab!");
        },
        tooltip: 'Create',
        child: const Icon(Icons.add),
      ),
    );
  }
}
