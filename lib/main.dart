import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:sandboxone/my_video.dart';
import 'package:sandboxone/registration_form.dart';
import 'package:universal_html/html.dart' show AnchorElement;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:convert';
import 'package:flutter/src/widgets/basic.dart' as B;
import 'dart:io';
import 'package:path/path.dart';
//import 'package:syncfusion_flutter_xlsio/xlsio.dart';

void main() => runApp(MaterialApp(home:FormScreen()));

class MyAppNNew extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FormScreen(),
    );
  }
}


/*class CreateFolder {

  String logOutput = "Display Output Here";

  Future<String>_createFolder(String name) async{

    //MyHomePage.downloadFile();

    final folderName = name;

    final path = Directory("storage/emulated/0/$folderName");

    final myImagePath = '${path}' ;
    //final myImgDir = await new Directory(myImagePath).create();


    var status = await Permission.storage.status;

    if (!status.isGranted) {
      await Permission.storage.request();
    }

    var excel = Excel.createExcel();

    Sheet sheetObject = excel['SheetName'];

    CellStyle cellStyle = CellStyle(backgroundColorHex: "#1AFF1A", fontFamily : getFontFamily(FontFamily.Calibri));

    cellStyle.underline = Underline.Single; // or Underline.Double


    var cell = sheetObject.cell(CellIndex.indexByString("A1"));
    cell.value = 8; // dynamic values support provided;
    cell.cellStyle = cellStyle;

    // printing cell-type
    print("CellType: "+ cell.cellType.toString());

    ///
    /// Inserting and removing column and rows

    // insert column at index = 8
    sheetObject.insertColumn(8);

    // remove column at index = 18
    sheetObject.removeColumn(18);

    // insert row at index = 82
    sheetObject.insertRow(82);

    var fileBytes = excel.save();
    var directory = await getApplicationDocumentsDirectory();

    print('excelcoming'+fileBytes.toString());



    if ((await path.exists())) {

      final directory = await getExternalStorageDirectory();

      final myImagePath = '${directory.path}' ;
      final myImgDir = await new Directory(myImagePath).create();

      var kompresimg = new File("$myImagePath/ss1.xlsx")
        ..writeAsBytesSync(fileBytes);

      *//*final File file = File(kompresimg);
      await file.writeAsBytes(fileBytes, flush: true);
      OpenFile.open(kompresimg);
      *//*
      *//*logOutput = 'Folder "$folderName" already exist';
      final String path = (await getApplicationSupportDirectory()).path;

      final String fileName =
      Platform.isWindows ? '$logOutput\\Output.xlsx' : '$logOutput/Output.xlsx';

      File(join("$directory/output_file_name.xlsx"))
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes);


      final File file = File(fileName);
      await file.writeAsBytes(fileBytes, flush: true);
      OpenFile.open(fileName);

      print(logOutput);
*//*      return logOutput;
    } else {
      //path.create();
      path.create();
      final directory = await getExternalStorageDirectory();

      //final myImagePath = '${directory.path}' ;
      //final myImgDir = await new Directory(myImagePath).create();

      //_writeToFile('this is sample');

      *//*final File file = File(path+'/ss1.xlsx');
      await file.writeAsBytes(fileBytes, flush: true);
      //OpenFile.open(file.path);

      var kompresimg = new File("$path/ss1.xlsx")
        ..writeAsBytesSync(fileBytes);*//*
    }


  }

  Future get _localFile async {
    final path = await _localPath;

    print('##path--'+path);
    return File('$path/zombie.txt');
  }

  Future get _localPath async {
    // Application documents directory: /data/user/0/{package_name}/{app_name}
    final applicationDirectory = await getApplicationDocumentsDirectory();

    // External storage directory: /storage/emulated/0
    final externalDirectory = await getExternalStorageDirectory();

    // Application temporary directory: /data/user/0/{package_name}/cache
    final tempDirectory = await getTemporaryDirectory();

    print('##ext--'+externalDirectory.path);

    return externalDirectory.path;
  }

  Future _writeToFile(String text) async {
    final file = await _localFile;

    // Write the file
    File result = await file.writeAsString('$text');
  }



*//*
  Future<String> _createFolder(String name) async {
    final folderName = name;
    final path = Directory("storage/emulated/0/$folderName");
    var status = await Permission.storage.status;

    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    sheet.getRangeByName('A1').setText('Hello World!');
    final List<int> bytes = workbook.saveAsStream();

    createExcel();
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if ((await path.exists())) {
      logOutput = 'Folder "$folderName" already exist';
      final String path = (await getApplicationSupportDirectory()).path;

      final String fileName =
      Platform.isWindows ? '$logOutput\\Output.xlsx' : '$logOutput/Output.xlsx';

      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);

      print(logOutput);
      return logOutput;
    } else {
      path.create();




      logOutput = 'Folder "$folderName" Created';
      print(logOutput);


      //final String path = (await getApplicationSupportDirectory()).path;

      final String fileName =
      Platform.isWindows ? '$logOutput\\Output.xlsx' : '$logOutput/Output.xlsx';

      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);

      return logOutput;
    }
  }
*//*



}*/

/*Future<void> createExcel() async {
  final Workbook workbook = Workbook();
  final Worksheet sheet = workbook.worksheets[0];
  sheet.getRangeByName('A1').setText('Hello World!');
  final List<int> bytes = workbook.saveAsStream();
  workbook.dispose();

  if (kIsWeb) {
    AnchorElement(
        href:
        'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
      ..setAttribute('download', 'Output.xlsx')
      ..click();
  } else {
    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName =
    Platform.isWindows ? '$path\\Output.xlsx' : '$path/Output.xlsx';
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(fileName);
  }
}*/

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    //  home: MyHomePage(folder: CreateFolder(),),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // Create Constructor
  //final CreateFolder folder;
  //MyHomePage({Key key, @required this.folder}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future outputFuture;

  @override
  void initState() {
    super.initState();
    outputFuture = _getOutput();


  }



  _getOutput() async {
    //return CreateFolder().logOutput;
  }
  @override
  Widget build(BuildContext context) {
    final folderNameController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Create folder on local storage'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: B.Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // FutureBuilder is required as CreateFolder() is ASYNC.
            // When not applied the UI will be rendered after the logOutput variable has been updated.
            FutureBuilder(
              future: _getOutput(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  //return  Text(widget.folder.logOutput);
                } else {
                  return CircularProgressIndicator();
                }
              },

            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: folderNameController,
                decoration: InputDecoration(
                  labelText: 'Folder Name',
                ),
              ),
            ),
            Text(
              "Press '+' to create folder on local storage.",
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { setState(() {
         // widget.folder._createFolder(folderNameController.text);
        }); },
        tooltip: 'Create Folder',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
