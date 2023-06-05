import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web Scraper - Web App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool bgColorSwitch = false;

  @override
  void initState() {
    super.initState();
    getWebsiteData();
  }

  Future<void> getWebsiteData() async {
    final url = Uri.parse('https://www.amazon.com/s?kiphone');
    final response = await http.get(url);
    final html = await response.body;

    final document = dom.Document.html(html);

    final titles = document.querySelectorAll('.a-size-base.a-link-normal')
        .map((element) => element.text)
        .toList();

    print('Count: ${titles.length}');
    for (final title in titles) {
      debugPrint(title);
    }
  }

  void _incrementCounter() { // Switch the color theme to dark mode.
    setState(() {
      bgColorSwitch = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Web Scraper - Web App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Here are the titles of the first 10 results on Amazon for "iphone":'),
            titles.take(10).map((title) => Text(title)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Lights Off',
        child: const Icon(Icons.light_mode),
      ),
    );
  }
}
