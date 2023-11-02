import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/providers/NewsProvider.dart';
import '../../data/models/NewsModel.dart';

class NewsViewModel with ChangeNotifier {
  NewsProvider _newsProvider; // Private field

  NewsViewModel(this._newsProvider);

  ThemeData get currentTheme => _newsProvider.currentTheme;

  List<News> get newsList => _newsProvider.newsList as List<News>;

  Future<List<void>?> fetchNews() async {
    await _newsProvider.fetchNews();
    notifyListeners();


  }

  void toggleTheme() {
    _newsProvider.toggleTheme();
    notifyListeners();
  }
  set newsProvider(NewsProvider newsProvider) {
    _newsProvider = newsProvider;
  }

  Future<void> loadMoreNews() async {
    await _newsProvider.loadMoreNews();
    notifyListeners();
  }
}
