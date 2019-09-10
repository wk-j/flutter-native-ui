import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var pages = 0;
  var pdfPath = "";

  view(path) => PDFView(
        filePath: path,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: true,
        pageFling: false,
        onRender: (_pages) {
          setState(() {
            pages = _pages;
            debugPrint("pages $pages");
          });
        },
        onViewCreated: (PDFViewController pdfViewController) {},
        onPageChanged: (int page, int total) {
          print('page change: $page/$total');
        },
      );

  open(path) {
    OpenFile.open(
      path,
      type: "application/pdf",
      uti: "com.adobe.pdf",
    );
  }

  Future<String> load() async {
    var directory = await getApplicationDocumentsDirectory();
    var dbPath = join(directory.path, "bus.pdf");
    var data = await rootBundle.load("assets/tesla.pdf");
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes);
    return dbPath;
  }

  @override
  void initState() {
    super.initState();
    load().then((path) {
      setState(() {
        pdfPath = path;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fluff fluff"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RaisedButton(
            onPressed: () async {
              open(pdfPath);
            },
            child: Text("Open PDF"),
          ),
          // Expanded(
          //     child: pdfPath != ""
          //         ? view(pdfPath)
          //         : Container(
          //             height: 200,
          //           )),
          Expanded(
            child: UiKitView(viewType: "PdfView"),
          ),
        ],
      ),
    );
  }
}
