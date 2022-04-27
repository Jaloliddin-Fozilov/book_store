import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/book_model.dart';
import '../providers/book_provider.dart';
import '../screens/book_detail_page.dart';

class MySearchDelegete extends SearchDelegate {
  String resultId = '';
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Center(
      child: Text('Book not found! Error:404'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final allBooks = Provider.of<BookProvider>(context);

    List<BookModel> searchResults = allBooks.list.map((book) => book).toList();

    List<BookModel> suggestions = searchResults.where(
      (searchResult) {
        final result = searchResult.title.toLowerCase();
        final input = query.toLowerCase();
        return result.contains(input);
      },
    ).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (ctx, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion.title),
          onTap: () {
            resultId = suggestion.id;
            query = suggestion.title;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetailPage(id: suggestion.id),
              ),
            );
            showResults(context);
          },
        );
      },
    );
  }
}
