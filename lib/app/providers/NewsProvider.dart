import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../data/models/NewsModel.dart';
import '../themes/DarkTheme.dart';
import '../themes/LightTheme.dart';



class NewsProvider with ChangeNotifier {
  ThemeData _currentTheme = lightTheme; // Default to light theme

  ThemeData get currentTheme => _currentTheme;

  void toggleTheme() {
    _currentTheme = _currentTheme == lightTheme ? darkTheme : lightTheme;
    notifyListeners();
  }

  List<News> _newsList = [];
  int _currentPage = 1; // Track the current page
  bool _isLoading = false; // Track whether a request is already in progress

  List<News> get newsList => _newsList;
  bool get isLoading => _isLoading;

  Future<void> fetchNews() async {
    _currentPage = 1; // Reset the current page when fetching new data
    _isLoading = true;

    final apiKey = 'e3b47176c4de496985d4f116bf34a16c'; // Replace with your News API key
    final apiUrl = 'https://newsapi.org/v2/everything?q=tesla&from=2023-10-01&sortBy=publishedAt&apiKey=${apiKey}';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> articles = data['articles'];

        _newsList = articles
            .map((article) => News(
          title: article['title'],
          description: article['description'],
          urlToImage: article['urlToImage']
        ))
            .toList();

        notifyListeners();
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      print('Error fetching news: $e');
    } finally {
      _isLoading = false;
    }
  }

  Future<void> loadMoreNews() async {
    if (_isLoading) {
      return; // Prevent multiple simultaneous requests
    }

    _isLoading = true;

    _currentPage++; // Increment the current page
    final apiKey = 'e3b47176c4de496985d4f116bf34a16c'; // Replace with your News API key
    final apiUrl =
        'https://newsapi.org/v2/everything?q=tesla&from=2023-10-01&sortBy=publishedAt&page=$_currentPage&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> articles = data['articles'];

        final newNews = articles
            .map((article) => News(
          title: article['title'],
          description: article['description'],
            urlToImage: article['urlToImage']

        ))
            .toList();

        _newsList.addAll(newNews);

        notifyListeners();
      } else {
        throw Exception('Failed to load more news');
      }
    } catch (e) {
      print('Error loading more news: $e');
    } finally {
      _isLoading = false;
    }
  }
}