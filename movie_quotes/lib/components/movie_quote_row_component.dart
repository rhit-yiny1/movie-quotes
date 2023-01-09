import 'package:flutter/material.dart';
import '../models/movie_quote.dart';

class MovieQuoteRow extends StatelessWidget {
  final MovieQuote mq;
  const MovieQuoteRow({
    super.key,
    required this.mq,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 1.0),
      child: Card(
        child: ListTile(
          leading: const Icon(Icons.movie_creation_outlined),
          trailing: const Icon(Icons.chevron_right),
          title: Text(
            mq.quote,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            mq.movie,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
