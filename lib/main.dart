import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapitask/ui/viewmodels/NewsViewModel.dart';

import 'app/App.dart';
import 'app/providers/NewsProvider.dart';

void main() {


  runApp(
    MaterialApp(

      debugShowCheckedModeBanner: false,


      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => NewsProvider()),
          ChangeNotifierProxyProvider<NewsProvider, NewsViewModel>(
            create: (_) => NewsViewModel(NewsProvider()),
            update: (_, newsProvider, newsViewModel) {
              newsViewModel!.newsProvider = newsProvider; // Set the newsProvider
              return newsViewModel;
            },
          ),
        ],

        child:  MyApp(),
      ),
    ),
  );
}

