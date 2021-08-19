import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/src/widgets/basic.dart' as B;
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class MyVideo extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Gallery Storage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool loading = false;
  double progress = 0;

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  Future<bool> saveVideo(String url, String fileName) async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory();
          String newPath = "";
          print(directory);
          List<String> paths = directory.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          newPath = newPath + "/PasswordSaver-data";
          directory = Directory(newPath);
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        File saveFile = File(directory.path + "/$fileName");
        //generateExcel(saveFile,fileName);
        //generateExcelnew(saveFile,fileName);
        generate4(saveFile,fileName,directory.path + "/$fileName");

        /*var dio = Dio();
        print('##saving'+saveFile.path);
        await dio.download(url, saveFile.path,
            onReceiveProgress: (value1, value2) {
              setState(() {
                progress = value1 / value2;
              });
            });
        if (Platform.isIOS) {
          await ImageGallerySaver.saveFile(saveFile.path,
              isReturnPathOfIOS: true);
        }*/
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<void> generateExcelnew(File saveFile, String filename) async{

// Create a new Excel document.
    final Workbook workbook = new Workbook();
//Accessing worksheet via index.
    workbook.worksheets[0];
// Save the document.
    final List<int> bytes = workbook.saveAsStream();
    File(filename+"1").writeAsBytes(bytes);
//Dispose the workbook.
    workbook.dispose();

    saveFile
      ..writeAsBytesSync(bytes);

    OpenFile.open(filename);



    // Create a new Excel document.
    final Workbook workbook2= new Workbook();
//Accessing worksheet via index.
    final Worksheet sheet2= workbook2.worksheets[0];
//Add Text.
    sheet2.getRangeByName('A1').setText('Hello World');
//Add Number
    sheet2.getRangeByName('A3').setNumber(44);
//Add DateTime
    sheet2.getRangeByName('A5').setDateTime(DateTime(2020,12,12,1,10,20));
// Save the document.
    final List<int> bytes2 = workbook2.saveAsStream();
    File(filename+"2").writeAsBytes(bytes2);
//Dispose the workbook.
    workbook2.dispose();

    saveFile
      ..writeAsBytesSync(bytes2);

    OpenFile.open(filename+"2");

    // Create a new Excel document.
    final Workbook workbook3 = new Workbook();
//Accessing worksheet via index.
    final Worksheet sheet3= workbook3.worksheets[0];

//Applying Number format.
    sheet3.getRangeByName('A1').builtInStyle = BuiltInStyles.linkedCell;

// Save the document.
    final List<int> bytes3 = workbook3.saveAsStream();
    File(filename+"3").writeAsBytes(bytes3);
//Dispose the workbook.
    workbook3.dispose();

    saveFile
      ..writeAsBytesSync(bytes);

    OpenFile.open(filename+"3");


    // Create a new Excel document.
    final Workbook workbook4 = new Workbook();
//Accessing worksheet via index.
    final Worksheet sheet4 = workbook4.worksheets[0];

//Applying Number format.
    final Range range4 = sheet4.getRangeByName('A1');
    range4.setNumber(100);
    range4.numberFormat = '\S#,##0.00';

// Save the document.
    final List<int> bytes4 = workbook4.saveAsStream();
    File(filename+"4").writeAsBytes(bytes4);
//Dispose the workbook.
    workbook4.dispose();

    saveFile
      ..writeAsBytesSync(bytes4);

    OpenFile.open(filename+"4");


    // Create a new Excel Document.
    final Workbook workbook5 = Workbook();

// Accessing sheet via index.
    final Worksheet sheet5 = workbook5.worksheets[0];

//Creating a Hyperlink for a Website.
    final Hyperlink hyperlink = sheet5.hyperlinks.add(sheet5.getRangeByName('A1'),
        HyperlinkType.url, 'https://www.syncfusion.com');
    hyperlink.screenTip =
    'To know more about Syncfusion products, go through this link.';
    hyperlink.textToDisplay = 'Syncfusion';

// Save and dispose workbook.
    final List<int> bytes5 = workbook.saveAsStream();
    File(filename+"5").writeAsBytes(bytes5);
    workbook5.dispose();

    saveFile
      ..writeAsBytesSync(bytes5);

    OpenFile.open(filename+"5");

    // Create a new Excel Document.
    final Workbook workbook6 = Workbook();

// Accessing sheet via index.
    final Worksheet sheet6 = workbook6.worksheets[0];

// Assigning text to cells
    final Range range6 = sheet6.getRangeByName('A1');
    range6.setText('WorkBook Protected');

    final bool isProtectWindow = true;
    final bool isProtectContent = true;

// Protect Workbook
    workbook6.protect(isProtectWindow, isProtectContent, 'password');

// Save and dispose workbook.
    final List<int> bytes6 = workbook6.saveAsStream();
    File(filename+"6").writeAsBytes(bytes6);
    workbook6.dispose();

    saveFile
      ..writeAsBytesSync(bytes6);

    OpenFile.open(filename+"6");


  }

  generate4(File saveFile, String filename,String completePath)
  {
    // Create a new Excel document.
    // Create a new Excel document.
    final Workbook workbook = new Workbook();
//Accessing worksheet via index.
    final Worksheet sheet = workbook.worksheets[0];

    final bool isProtectWindow = true;
    final bool isProtectContent = true;

// Protect Workbook
    workbook.protect(isProtectWindow, isProtectContent, 'password');
    // Create a new Excel document.
//Accessing worksheet via index.

    final ExcelSheetProtectionOption options = ExcelSheetProtectionOption();
    options.all = true;

// Protecting the Worksheet by using a Password
    sheet.protect('Password', options);

//Defining a global style with all properties.
    Style globalStyle = workbook.styles.add('style');
    Style globalStyle2 = workbook.styles.add('style2');
//set back color by hexa decimal.
    globalStyle.backColor = '#000000';
//set font name.
   // globalStyle.fontName = 'Times New Roman';
//set font size.
    //globalStyle.fontSize = 20;
//set font color by hexa decimal.
    globalStyle.fontColor = '#C67878';
//set font italic.
   // globalStyle.italic = true;
//set font bold.
    globalStyle.bold = true;
    globalStyle2.bold = false;

    globalStyle.hAlign = HAlignType.center;
    globalStyle2.hAlign = HAlignType.center;


    //set font underline.
    sheet.getRangeByName('A1').cellStyle = globalStyle;
    sheet.getRangeByName('B1').cellStyle = globalStyle;
    sheet.getRangeByName('C1').cellStyle = globalStyle;
    sheet.getRangeByName('D1').cellStyle = globalStyle;
    sheet.getRangeByName('E1').cellStyle = globalStyle;
    sheet.getRangeByName('F1').cellStyle = globalStyle;
    sheet.getRangeByName('G1').cellStyle = globalStyle;

    sheet.getRangeByName('A1').columnWidth = 22.0;
    sheet.getRangeByName('B1').columnWidth = 22.0;
    sheet.getRangeByName('C1').columnWidth = 22.0;
    sheet.getRangeByName('D1').columnWidth = 22.0;
    sheet.getRangeByName('E1').columnWidth = 22.0;
    sheet.getRangeByName('F1').columnWidth = 22.0;
    sheet.getRangeByName('G1').columnWidth = 22.0;
//Add Text.
    sheet.getRangeByName('A1').setText('Sl.No');
    sheet.getRangeByName('B1').setText('Title');
    sheet.getRangeByName('c1').setText('Username');
    sheet.getRangeByName('D1').setText('Password');
    sheet.getRangeByName('E1').setText('Link');
    sheet.getRangeByName('F1').setText('Email');
    sheet.getRangeByName('G1').setText('Phone');

    setSheetNo(sheet,globalStyle,globalStyle2);


  final List<int> bytes = workbook.saveAsStream();
   // File('AddingTextNumberDateTime.xlsx').writeAsBytes(bytes);
//Dispose the workbook.
    //workbook.dispose();

    saveFile
      ..writeAsBytesSync(bytes);

    OpenFile.open(completePath.toString());

  }

  setSheetNo(Worksheet sheet, Style globalStyle, Style globalStyle2)
  {
    for(int i=2;i<10;i++)
      {
        sheet.getRangeByName('A'+i.toString()).setText((i-1).toString());
        sheet.getRangeByName('B'+i.toString()).setText('title'+i.toString());
        sheet.getRangeByName('C'+i.toString()).setText('username'+i.toString());
        sheet.getRangeByName('D'+i.toString()).setText('password'+i.toString());
       // sheet.getRangeByName('E'+i.toString()).setText('www.google.com');

        final Hyperlink hyperlink = sheet.hyperlinks.add(sheet.getRangeByName('E'+i.toString()),
            HyperlinkType.url, 'www.google.com');
        hyperlink.screenTip =
        'click to go through this link.';
        hyperlink.textToDisplay = 'www.google.com';

        sheet.getRangeByName('F'+i.toString()).setText('email'+i.toString());
        sheet.getRangeByName('G'+i.toString()).setText('phone'+i.toString());


        //set font underline.
        sheet.getRangeByName('A'+i.toString()).cellStyle = globalStyle;
        sheet.getRangeByName('B'+i.toString()).cellStyle = globalStyle2;
        sheet.getRangeByName('C'+i.toString()).cellStyle = globalStyle2;
        sheet.getRangeByName('D'+i.toString()).cellStyle = globalStyle2;
        sheet.getRangeByName('E'+i.toString()).cellStyle = globalStyle2;
        sheet.getRangeByName('F'+i.toString()).cellStyle = globalStyle2;
        sheet.getRangeByName('G'+i.toString()).cellStyle = globalStyle2;
      }

  }

  Future<void> generateExcel(File saveFile, String filename) async {
    //Create a Excel document.

    //Creating a workbook.
    final Workbook workbook = Workbook();
    //Accessing via index
    final Worksheet sheet = workbook.worksheets[0];
    sheet.showGridlines = false;

    // Enable calculation for worksheet.
    sheet.enableSheetCalculations();

    //Set data in the worksheet.
    sheet.getRangeByName('A1').columnWidth = 4.82;
    sheet.getRangeByName('B1:C1').columnWidth = 13.82;
    sheet.getRangeByName('D1').columnWidth = 13.20;
    sheet.getRangeByName('E1').columnWidth = 7.50;
    sheet.getRangeByName('F1').columnWidth = 9.73;
    sheet.getRangeByName('G1').columnWidth = 8.82;
    sheet.getRangeByName('H1').columnWidth = 4.46;

    sheet.getRangeByName('A1:H1').cellStyle.backColor = '#333F4F';
    sheet.getRangeByName('A1:H1').merge();
    sheet.getRangeByName('B4:D6').merge();

    sheet.getRangeByName('B4').setText('Invoice');
    sheet.getRangeByName('B4').cellStyle.fontSize = 32;

    sheet.getRangeByName('B8').setText('BILL TO:');
    sheet.getRangeByName('B8').cellStyle.fontSize = 9;
    sheet.getRangeByName('B8').cellStyle.bold = true;

    sheet.getRangeByName('B9').setText('Abraham Swearegin');
    sheet.getRangeByName('B9').cellStyle.fontSize = 12;

    sheet
        .getRangeByName('B10')
        .setText('United States, California, San Mateo,');
    sheet.getRangeByName('B10').cellStyle.fontSize = 9;

    sheet.getRangeByName('B11').setText('9920 BridgePointe Parkway,');
    sheet.getRangeByName('B11').cellStyle.fontSize = 9;

    sheet.getRangeByName('B12').setNumber(9365550136);
    sheet.getRangeByName('B12').cellStyle.fontSize = 9;
    sheet.getRangeByName('B12').cellStyle.hAlign = HAlignType.left;

    final Range range1 = sheet.getRangeByName('F8:G8');
    final Range range2 = sheet.getRangeByName('F9:G9');
    final Range range3 = sheet.getRangeByName('F10:G10');
    final Range range4 = sheet.getRangeByName('F11:G11');
    final Range range5 = sheet.getRangeByName('F12:G12');

    range1.merge();
    range2.merge();
    range3.merge();
    range4.merge();
    range5.merge();

    sheet.getRangeByName('F8').setText('INVOICE#');
    range1.cellStyle.fontSize = 8;
    range1.cellStyle.bold = true;
    range1.cellStyle.hAlign = HAlignType.right;

    sheet.getRangeByName('F9').setNumber(2058557939);
    range2.cellStyle.fontSize = 9;
    range2.cellStyle.hAlign = HAlignType.right;

    sheet.getRangeByName('F10').setText('DATE');
    range3.cellStyle.fontSize = 8;
    range3.cellStyle.bold = true;
    range3.cellStyle.hAlign = HAlignType.right;

    sheet.getRangeByName('F11').dateTime = DateTime(2020, 08, 31);
    sheet.getRangeByName('F11').numberFormat =
    r'[$-x-sysdate]dddd, mmmm dd, yyyy';
    range4.cellStyle.fontSize = 9;
    range4.cellStyle.hAlign = HAlignType.right;

    range5.cellStyle.fontSize = 8;
    range5.cellStyle.bold = true;
    range5.cellStyle.hAlign = HAlignType.right;

    final Range range6 = sheet.getRangeByName('B15:G15');
    range6.cellStyle.fontSize = 10;
    range6.cellStyle.bold = true;

    sheet.getRangeByIndex(15, 2).setText('Code');
    sheet.getRangeByIndex(16, 2).setText('CA-1098');
    sheet.getRangeByIndex(17, 2).setText('LJ-0192');
    sheet.getRangeByIndex(18, 2).setText('So-B909-M');
    sheet.getRangeByIndex(19, 2).setText('FK-5136');
    sheet.getRangeByIndex(20, 2).setText('HL-U509');

    sheet.getRangeByIndex(15, 3).setText('Description');
    sheet.getRangeByIndex(16, 3).setText('AWC Logo Cap');
    sheet.getRangeByIndex(17, 3).setText('Long-Sleeve Logo Jersey, M');
    sheet.getRangeByIndex(18, 3).setText('Mountain Bike Socks, M');
    sheet.getRangeByIndex(19, 3).setText('ML Fork');
    sheet.getRangeByIndex(20, 3).setText('Sports-100 Helmet, Black');

    sheet.getRangeByIndex(15, 3, 15, 4).merge();
    sheet.getRangeByIndex(16, 3, 16, 4).merge();
    sheet.getRangeByIndex(17, 3, 17, 4).merge();
    sheet.getRangeByIndex(18, 3, 18, 4).merge();
    sheet.getRangeByIndex(19, 3, 19, 4).merge();
    sheet.getRangeByIndex(20, 3, 20, 4).merge();

    sheet.getRangeByIndex(15, 5).setText('Quantity');
    sheet.getRangeByIndex(16, 5).setNumber(2);
    sheet.getRangeByIndex(17, 5).setNumber(3);
    sheet.getRangeByIndex(18, 5).setNumber(2);
    sheet.getRangeByIndex(19, 5).setNumber(6);
    sheet.getRangeByIndex(20, 5).setNumber(1);

    sheet.getRangeByIndex(15, 6).setText('Price');
    sheet.getRangeByIndex(16, 6).setNumber(8.99);
    sheet.getRangeByIndex(17, 6).setNumber(49.99);
    sheet.getRangeByIndex(18, 6).setNumber(9.50);
    sheet.getRangeByIndex(19, 6).setNumber(175.49);
    sheet.getRangeByIndex(20, 6).setNumber(34.99);

    sheet.getRangeByIndex(15, 7).setText('Total');
    sheet.getRangeByIndex(16, 7).setFormula('=E16*F16+(E16*F16)');
    sheet.getRangeByIndex(17, 7).setFormula('=E17*F17+(E17*F17)');
    sheet.getRangeByIndex(18, 7).setFormula('=E18*F18+(E18*F18)');
    sheet.getRangeByIndex(19, 7).setFormula('=E19*F19+(E19*F19)');
    sheet.getRangeByIndex(20, 7).setFormula('=E20*F20+(E20*F20)');
    sheet.getRangeByIndex(15, 6, 20, 7).numberFormat = r'$#,##0.00';

    sheet.getRangeByName('E15:G15').cellStyle.hAlign = HAlignType.right;
    sheet.getRangeByName('B15:G15').cellStyle.fontSize = 10;
    sheet.getRangeByName('B15:G15').cellStyle.bold = true;
    sheet.getRangeByName('B16:G20').cellStyle.fontSize = 9;

    sheet.getRangeByName('E22:G22').merge();
    sheet.getRangeByName('E22:G22').cellStyle.hAlign = HAlignType.right;
    sheet.getRangeByName('E23:G24').merge();

    final Range range7 = sheet.getRangeByName('E22');
    final Range range8 = sheet.getRangeByName('E23');
    range7.setText('TOTAL');
    range7.cellStyle.fontSize = 8;
    range8.setFormula('=SUM(G16:G20)');
    range8.numberFormat = r'$#,##0.00';
    range8.cellStyle.fontSize = 24;
    range8.cellStyle.hAlign = HAlignType.right;
    range8.cellStyle.bold = true;

    sheet.getRangeByIndex(26, 1).text =
    '800 Interchange Blvd, Suite 2501, Austin, TX 78721 | support@adventure-works.com';
    sheet.getRangeByIndex(26, 1).cellStyle.fontSize = 8;

    final Range range9 = sheet.getRangeByName('A26:H27');
    range9.cellStyle.backColor = '#ACB9CA';
    range9.merge();
    range9.cellStyle.hAlign = HAlignType.center;
    range9.cellStyle.vAlign = VAlignType.center;

    //Save and launch the excel.
    final List<int> bytes = workbook.saveAsStream();
    //Dispose the document.
    workbook.dispose();

    //Save and launch the file.
   // await FileSaveHelper.saveAndLaunchFile(bytes, 'Invoice.xlsx');

    saveFile
      ..writeAsBytesSync(bytes);

    OpenFile.open(filename);

    //var fileBytes = excel.save();



  }

 /* createExcel(File saveFile, String filename)
  {
    var excel = Excel.createExcel();

    Sheet sheetObject = excel['Password-saver'];

    CellStyle cellStyle = CellStyle(backgroundColorHex: "#1AFF1A", fontFamily : getFontFamily(FontFamily.Calibri));

    cellStyle.underline = Underline.Single; // or Underline.Double


    var cell1 = sheetObject.cell(CellIndex.indexByString("A1"));
    var cell2 = sheetObject.cell(CellIndex.indexByString("B1"));
    var cell3 = sheetObject.cell(CellIndex.indexByString("C1"));
    var cell4 = sheetObject.cell(CellIndex.indexByString("D1"));
    var cell5 = sheetObject.cell(CellIndex.indexByString("E1"));
    var cell6 = sheetObject.cell(CellIndex.indexByString("F1"));
    var cell7 = sheetObject.cell(CellIndex.indexByString("G1"));
   // cell.value = 3; // dynamic values support provided;
    cell1.cellStyle = cellStyle;
    cell2.cellStyle = cellStyle;
    cell3.cellStyle = cellStyle;
    cell4.cellStyle = cellStyle;
    cell5.cellStyle = cellStyle;
    cell6.cellStyle = cellStyle;
    cell7.cellStyle = cellStyle;

    // printing cell-type
    print("CellType: "+ cell1.cellType.toString());

    ///
    /// Inserting and removing column and rows

    // insert column at index = 8
    //sheetObject.insertColumn(8);

    // remove column at index = 18
    //sheetObject.removeColumn(18);

    // insert row at index = 82
    //sheetObject.insertRow(22);

    List<String> dataList = ["Sl.No", "Title", "Link", "Username", "Password", "Email", "Phone"];

    sheetObject.insertRowIterables(dataList, 0);

    sheetObject.appendRow(["Flutter", "till", "Eternity"]);


    var fileBytes = excel.save();

    saveFile
      ..writeAsBytesSync(fileBytes);

    OpenFile.open(filename);
  }*/

  downloadFile() async {
    setState(() {
      loading = true;
      progress = 0;
    });
    // saveVideo will download and save file to Device and will return a boolean
    // for if the file is successfully or not
    bool downloaded = await saveVideo(
        "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
        "password-saver.xlsx");
    if (downloaded) {
      print("File Downloaded");
    } else {
      print("Problem Downloading File");
    }

    setState(() {
      loading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: loading
            ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: LinearProgressIndicator(
            minHeight: 10,
            value: progress,
          ),
        )
            : FlatButton.icon(
            icon: Icon(
              Icons.download_rounded,
              color: Colors.white,
            ),
            color: Colors.blue,
            onPressed: downloadFile,
            padding: const EdgeInsets.all(10),
            label: Text(
              "Download Video",
              style: TextStyle(color: Colors.white, fontSize: 25),
            )),
      ),
    );
  }
}