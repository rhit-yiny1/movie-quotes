import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_quotes/models/firestore_model_utils.dart';

const String kMovieQuote_authorUid = "authorUid";
const String kMovieQuote_quote = "quote";
const String kMovieQuote_movie = "movie";
const String kMovieQuote_lastTouched = "lastTouched";
const String kMovieQuoteCollectionPath = "MovieQuotes";

class MovieQuote {
  String quote;
  String movie;
  Timestamp lastTouched;
  String? documentId;
  String authorUid;

  MovieQuote({
    this.documentId,
    required this.quote,
    required this.movie,
    required this.lastTouched,
    required this.authorUid,
  });
  MovieQuote.from(DocumentSnapshot doc)
      : this(
          documentId: doc.id,
          quote: FirestoreModelUtils.getStringField(doc, kMovieQuote_quote),
          movie: FirestoreModelUtils.getStringField(doc, kMovieQuote_movie),
          lastTouched: FirestoreModelUtils.getTimestampField(
              doc, kMovieQuote_lastTouched),
          authorUid:
              FirestoreModelUtils.getStringField(doc, kMovieQuote_authorUid),
        );

  Map<String, Object?> toMap() {
    return {
      kMovieQuote_quote: quote,
      kMovieQuote_movie: movie,
      kMovieQuote_authorUid: authorUid,
      kMovieQuote_lastTouched: lastTouched,
    };
  }
}
