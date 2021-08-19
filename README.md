# Create Customer Folder App

Simple app that allows you to create custom folder on your external storage.
App will show dialog in order to allow write permissions.

Dependencies used:
  -  permission_handler: ^5.0.1+1

Permission requirements: 
  - android.permission.WRITE_EXTERNAL_STORAGE"
  - android:name="android.permission.READ_EXTERNAL_STORAGE" (optional)




# Main.dart
````
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'dart:async';

void main() {
  runApp(MyApp());
}
class CreateFolder {
  String logOutput = "Display Output Here";
  Future<String> _createFolder(String name) async {
    final folderName = name;
    final path = Directory("storage/emulated/0/$folderName");
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if ((await path.exists())) {
      logOutput = 'Folder "$folderName" already exist';
      print(logOutput);
      return logOutput;
    } else {
      path.create();
      logOutput = 'Folder "$folderName" Created';
      print(logOutput);
      return logOutput;
    }
  }
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(folder: CreateFolder(),),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // Create Constructor
  final CreateFolder folder;
  MyHomePage({Key key, @required this.folder}) : super(key: key);

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
    return CreateFolder().logOutput;
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // FutureBuilder is required as CreateFolder() is ASYNC.
            // When not applied the UI will be rendered after the logOutput variable has been updated.
            FutureBuilder(
              future: _getOutput(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return  Text(widget.folder.logOutput);
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
          widget.folder._createFolder(folderNameController.text);
        }); },
        tooltip: 'Create Folder',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


````
