import 'package:flutter/material.dart';
import 'package:movie_quotes/models/movie_quote.dart';

class MovieQuoteDetailPage extends StatefulWidget {
  final MovieQuote mq;
  const MovieQuoteDetailPage(this.mq, {super.key});

  @override
  State<MovieQuoteDetailPage> createState() => _MovieQuoteDetailPageState();
}

class _MovieQuoteDetailPageState extends State<MovieQuoteDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Quotes"),
        actions: [
          IconButton(
            onPressed: () {
              print("You clicked Edit");
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              print("You clicked Delete");
              Navigator.pop(context);
            },
            icon: Icon(Icons.delete),
          )
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            LabelledTextDisplay(
              label: "Quote",
              content: widget.mq.quote,
              iconData: Icons.format_quote_outlined,
            ),
            LabelledTextDisplay(
              label: "Movie",
              content: widget.mq.movie,
              iconData: Icons.movie_filter_outlined,
            ),
          ],
        ),
      ),
    );
  }
}

class LabelledTextDisplay extends StatelessWidget {
  final String label;
  final String content;
  final IconData iconData;

  const LabelledTextDisplay(
      {super.key,
      required this.label,
      required this.content,
      required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            label,
            style: const TextStyle(fontStyle: FontStyle.normal),
          ),
          Card(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Text(content),
            ),
          )
        ],
      ),
    );
  }
}
