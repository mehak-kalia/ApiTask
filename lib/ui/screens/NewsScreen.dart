import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app/providers/NewsProvider.dart';
import 'dart:core';
import '../viewmodels/NewsViewModel.dart';


class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Locale currentLocale = Locale('en'); // Set the initial locale to English

  void _onLocaleChanged(Locale? newLocale) {
    setState(() {
      currentLocale = newLocale!;
    });
  }

  @override
  void initState() {
    super.initState();
    Provider.of<NewsProvider>(context, listen: false).fetchNews();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // User has reached the end of the list, load more news.
        _loadMoreNews();
      }
    });
  }

  void _loadMoreNews() {
    // You should implement your logic to load more news here.
    // For example, you can call Provider to fetch additional news data.
    Provider.of<NewsProvider>(context, listen: false).loadMoreNews();
  }

  @override
  Widget build(BuildContext context) {
    final newsList = Provider.of<NewsProvider>(context).newsList;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Localizations.override(
            context: context,
            locale: currentLocale,
            child: Text('News App')),
        actions: [
          ElevatedButton(
            onPressed: () {
              Provider.of<NewsViewModel>(context, listen: false).toggleTheme();
            },
            child: Icon(Icons.toggle_on),
          ),
          DropdownButton<Locale>(
            value: currentLocale,
            onChanged: _onLocaleChanged,
            items: [
              DropdownMenuItem(
                value: Locale('en'),
                child: Text('English'),
              ),
              DropdownMenuItem(
                value: Locale('es'),
                child: Text('Español'),
              ),
              // Add more languages as needed
            ],
          ),
        ],
      ),
      body: Localizations.override(
        context: context,
        locale: currentLocale,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: newsList.length + 1, // Add 1 for the loading indicator
          itemBuilder: (context, index) {
            if (index < newsList.length) {
              return Card(

                child: Column(
                  children: [

                    Container(
                      height: 100,
                        width: 100,
                        child: Image.network(newsList[index].urlToImage ?? 'https://bloximages.chicago2.vip.townnews.com/pressofatlanticcity.com/content/tncms/assets/v3/editorial/9/74/974aae60-784c-11ee-913d-57ac481ec352/65419be439caa.preview.jpg?crop=1804%2C947%2C0%2C100&resize=1200%2C630&order=crop%2Cresize', scale: 0.5,)),

                    Text(newsList[index].title, style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(newsList[index].description),
                  ],
                ),

              );
            } else {
              // Display a loading indicator when reaching the end
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

