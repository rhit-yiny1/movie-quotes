import 'package:flutter/material.dart';
import 'package:movie_quotes/models/movie_quote.dart';

class MovieQuoteDetailPage extends StatefulWidget {
  final MovieQuote mq;
  const MovieQuoteDetailPage(this.mq, {super.key});

  @override
  State<MovieQuoteDetailPage> createState() => _MovieQuoteDetailPageState();
}

class _MovieQuoteDetailPageState extends State<MovieQuoteDetailPage> {
  final movieTextController = TextEditingController();
  final quoteTextController = TextEditingController();

  // @override
  // void dispose() {
  //   quoteTextController.dispose();
  //   movieTextController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Quotes"),
        actions: [
          IconButton(
            onPressed: () {
              print("You clicked Edit");
              showCreateQuoteDialog(context);
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              print("You clicked Delete");
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('Quote Deleted'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      print("TODO: Figure out undo");
                    },
                  )));
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

  Future<void> showCreateQuoteDialog(BuildContext context) {
    quoteTextController.text = widget.mq.quote;
    movieTextController.text = widget.mq.movie;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit a Movie Quote'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: quoteTextController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter the quote',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: movieTextController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter the movie',
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Update'),
              onPressed: () {
                setState(() {
                  // quotes.add(MovieQuote(
                  //     quote: quoteTextController.text,
                  //     movie: movieTextController.text));
                  // quoteTextController.text = widget.mq.quote;
                  // movieTextController.text = widget.mq.movie;
                  widget.mq.quote = quoteTextController.text;
                  widget.mq.movie = movieTextController.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
