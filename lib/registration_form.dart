
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as Xls;

class FormScreen extends StatefulWidget {
  const FormScreen({Key key}) : super(key: key);

  @override
  _FormScreenState createState() => _FormScreenState();

}


enum Gender { male, female }

class _FormScreenState extends State<FormScreen> {
   String _firstName;
   String _email;
   String _password;
   dynamic _gender;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   String dropdownValue;
   var _currentSelectedValue;
   var output;
  TextEditingController dateinput = TextEditingController();

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

   downloadFile() async {
     setState(() {
       loading = true;
       progress = 0;
     });
     // saveVideo will download and save file to Device and will return a boolean
     // for if the file is successfully or not
     bool downloaded = await save(
         "exampletest.xlsx");
     if (downloaded) {
       print("File Downloaded");
     } else {
       print("Problem Downloading File");
     }

     setState(() {
       loading = false;
     });
   }

   Future<bool> save( String fileName) async {
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
           newPath = newPath + "/Excel-data";
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
         generateExcel(saveFile,fileName,directory.path + "/$fileName");

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

   generateExcel(File saveFile, String filename,String completePath)
   {
     // Create a new Excel document.
     // Create a new Excel document.
     final Xls.Workbook workbook = new Xls.Workbook();
//Accessing worksheet via index.
     final Xls.Worksheet sheet = workbook.worksheets[0];

     final bool isProtectWindow = true;
     final bool isProtectContent = true;

// Protect Workbook
     workbook.protect(isProtectWindow, isProtectContent, 'password');
     // Create a new Excel document.
//Accessing worksheet via index.

     final Xls.ExcelSheetProtectionOption options = Xls.ExcelSheetProtectionOption();
     options.all = true;

// Protecting the Worksheet by using a Password
     sheet.protect('Password', options);

//Defining a global style with all properties.
     Xls.Style globalStyle = workbook.styles.add('style');
     Xls.Style globalStyle2 = workbook.styles.add('style2');
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

     globalStyle.hAlign = Xls.HAlignType.center;
     globalStyle2.hAlign = Xls.HAlignType.center;


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
     sheet.getRangeByName('B1').setText('Name');
     sheet.getRangeByName('c1').setText('Email');
     sheet.getRangeByName('D1').setText('Password');
     sheet.getRangeByName('E1').setText('Location');
     sheet.getRangeByName('F1').setText('Gender');
     sheet.getRangeByName('G1').setText('Dob');

     //setSheetNo(sheet,globalStyle,globalStyle2);

     sheet.getRangeByName('A2').setText('1');
     sheet.getRangeByName('B2').setText(_firstName);
     sheet.getRangeByName('C2').setText(_email);
     sheet.getRangeByName('D2').setText(_password);
     sheet.getRangeByName('E2').setText(dropdownValue);
     sheet.getRangeByName('F2').setText(_gender.toString());
     sheet.getRangeByName('G2').setText(formattedDate);

     //set font underline.
     sheet.getRangeByName('A2').cellStyle = globalStyle2;
     sheet.getRangeByName('B2').cellStyle = globalStyle2;
     sheet.getRangeByName('C2').cellStyle = globalStyle2;
     sheet.getRangeByName('D2').cellStyle = globalStyle2;
     sheet.getRangeByName('E2').cellStyle = globalStyle2;
     sheet.getRangeByName('F2').cellStyle = globalStyle2;
     sheet.getRangeByName('G2').cellStyle = globalStyle2;


     final List<int> bytes = workbook.saveAsStream();
     // File('AddingTextNumberDateTime.xlsx').writeAsBytes(bytes);
//Dispose the workbook.
     //workbook.dispose();

     saveFile
       ..writeAsBytesSync(bytes);

     OpenFile.open(completePath.toString());

   }

   setSheetNo(Xls.Worksheet sheet, Xls.Style globalStyle, Xls.Style globalStyle2)
   {

     sheet.getRangeByName('A2').setText('1');
     sheet.getRangeByName('B2').setText(_firstName);
     sheet.getRangeByName('C2').setText(_email);
     sheet.getRangeByName('D2').setText(_password);
     sheet.getRangeByName('E2').setText(dropdownValue);
     sheet.getRangeByName('F2').setText(_gender);
     sheet.getRangeByName('G2').setText(formattedDate);

     //set font underline.
     sheet.getRangeByName('A1').cellStyle = globalStyle2;
     sheet.getRangeByName('B1').cellStyle = globalStyle2;
     sheet.getRangeByName('C1').cellStyle = globalStyle2;
     sheet.getRangeByName('D1').cellStyle = globalStyle2;
     sheet.getRangeByName('E1').cellStyle = globalStyle2;
     sheet.getRangeByName('F1').cellStyle = globalStyle2;
     sheet.getRangeByName('G1').cellStyle = globalStyle2;

   }

  String formattedDate = '';
  //text editing controller for text field
  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }


  static const colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];
  static const colorizeTextStyle = TextStyle(
    fontSize: 50.0,
    fontFamily: 'Horizon',
  );

  Widget _buildName(){
    return TextFormField(
        decoration:InputDecoration(labelText: "Enter your Name"),
        maxLength: 10,
        validator: (value){
          if(value.isEmpty){
            return 'Name is required';
          }
        },
        onSaved: (value){
          _firstName = value;
        }
    );
  }
  Widget _buildEmail(){
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Email'
      ),
      validator: (value) {
        if(value==null){
          return "Email is required";
        }

        if(!RegExp("^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*").hasMatch(value)){
          return 'Enter a valid email address';
        }

        // validator has to return something :)
        return null;
      },
      onSaved: (value) {
        _email = value;
      },
    );
  }
  Widget _buildPassword() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Password'),
      obscureText: true,
      //keyboardType: TextInputType.,
      validator: (value) {
        if (value.isEmpty) {
          return 'Password is Required';
        }
        return null;
      },
      onSaved: (value) {
        _password = value;
      },
    );
  }
  Widget _buildGender(){

    return InputDecorator(

      decoration: InputDecoration(
        labelText: 'Please select your Gender',
        labelStyle: TextStyle(fontSize: 20.0),

        //errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0)
      ),

      child: Row(

          children: <Widget>[
            Expanded(
              child: ListTile(

                title: const Text('Female'),
                leading: Radio(
                  value: Gender.female,
                  groupValue: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value;

                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: const Text('Male'),
                leading: Radio(
                  value: Gender.male,
                  groupValue: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                ),
              ),
            )
          ]

      ),
    );

  }
  Widget _buildLocation(){
    return InputDecorator(
        decoration: InputDecoration(
          labelText: 'Please select your city',
          labelStyle: TextStyle(fontSize: 20.0),

          //errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0)
        ),
        //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)
        isEmpty: _currentSelectedValue == '',
        child: DropdownButton<String>(
          value: dropdownValue,
          iconSize: 20.0,
          isExpanded: true,

          icon: const Icon(Icons.arrow_downward),

          //elevation: 10,
          style: const TextStyle(color: Colors.teal),

          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;

            });
          },
          items: <String>['Islamabad', 'Rawalpindi', 'Lahore', 'Karachi','Other']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
                value: value,
                child: Text(value)
            );
          }).toList(),
        )
    );

  }
  Widget _buildDOB(){
    return TextField(
      controller: dateinput, //editing controller of this TextField
      decoration: InputDecoration(
          icon: Icon(Icons.calendar_today), //icon of text field
          labelText: "Enter Your Date of Birth" //label text of field
      ),
      readOnly: true,  //set it true, so that user will not able to edit text
      onTap: () async {
        DateTime pickedDate = await showDatePicker(
            context: this.context, initialDate: DateTime.now(),
            firstDate: DateTime(1980), //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2101)
        );

        if(pickedDate != null ){
          print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
          formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          //print(formattedDate); //formatted date output using intl package =>  2021-03-16
          //you can implement different kind of Date Format here according to your requirement

          setState(() {
            dateinput.text = formattedDate; //set output date to TextField value.
          });
        }else{
          print("Date is not selected");
        }
      },
    );
  }

  @override

  Widget build(BuildContext context) {
    //DataStorage ds =  DataStorage();
    return Scaffold(
      appBar: AppBar(

       // toolbarHeight:60, // Set this height

        flexibleSpace: Container(
          color: Colors.amber,
          child: SizedBox(

            width: 250.0,
            child: AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  'Registration Form',
                  textAlign: TextAlign.center,

                  textStyle: colorizeTextStyle,
                  colors: colorizeColors,
                ),
              ],
              isRepeatingAnimation: true,
            ),

          ),
        ),
      ),
      body: SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildName(),
              _buildEmail(),
              _buildPassword(),
              _buildLocation(),
              _buildGender(),
              _buildDOB(),

              SizedBox(height: 100),

              ElevatedButton(
                  onPressed:(){
                    if(_formKey.currentState.validate()){
                      _formKey.currentState.save();
                      print('Name: $_firstName');
                      print('Email: $_email');
                      print('Password: $_password');
                      print('Location: $dropdownValue');
                      print('Gender: $_gender');
                      print('DOB: $formattedDate');
                    }
                    output = '$_firstName';

                  // ds.writeDirectly(text: output, file_name: 'iqra.txt');

                  },
                  child: Text('Submit',style: TextStyle(color:Colors.black,fontSize:16,),),
              ),
              ElevatedButton(

                  onPressed: (){

                    downloadFile();
                    /*if(
                    *//*ds.writeDirectly(text: output, file_name: "iqra.txt")==true) {
                       Text('true');
                    }*/
                  },
                child: Text('Save',style: TextStyle(color:Colors.black,fontSize:16)),
              )

            ],

          ),
        ),
      ),

    ),

      );
    return Container();
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('_firstName', _firstName));
    properties.add(StringProperty('_email', _email));
    properties.add(StringProperty('_password', _password));
    properties.add(StringProperty('dropdownValue', dropdownValue));
    properties.add(StringProperty('_site', _gender));
    properties.add(EnumProperty<Gender>('_site', _gender));


  }
}
