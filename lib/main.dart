import 'dart:core';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:html/dom.dart' as dom;
// Project from YouTube: https://www.youtube.com/watch?v=wW9T5lP3DoY&t=1s
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
      color: Colors.black87,
      home: const MyHomePage(title: 'Flutter Web Scraper - Web App'),
    );
  }

}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // homepage

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool bgColorSwitch = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWebsiteDate();
  }
  Future getWebsiteDate() async {
    final url = Uri.parse('https://www.amazon.com/s?kiphone');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);
final titles = html
    .querySelector('#react-app > div:nth-child(1) > div > main > div > div > div > div.GridItemStyle-sc-1g068l7.iTmHdn > div > div.sc-bczRLJ.iLjiPQ > div > div.HiddenStyle-sc-y8qbhm.eAWTrU > div > div > div:nth-child(4) > div > div > div > div.GridItemStyle-sc-1g068l7.catKOp > div > div > div.GridItemStyle-sc-1g068l7.ebUpEP > div > div > div:nth-child(2) > a > span')
    .map((element) => element.innerHtml.trim())
    .toList();

print ('Count: ${titles.length}');
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
       // title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Lights Off',
        child: const Icon(Icons.light_mode),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
