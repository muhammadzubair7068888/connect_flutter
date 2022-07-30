import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../Globals/globals.dart';

class FileScreen extends StatefulWidget {
  final String role;
  const FileScreen({
    Key? key,
    required this.role,
  }) : super(key: key);

  @override
  State<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  final GlobalKey<FormState> _form = GlobalKey();
  final storage = const FlutterSecureStorage();
  PlatformFile? file;
  String name = "";
  String title = "";
  bool visible = false;
  var users = [];
  String user = '';
  List<DataRow> rowsAdd = [];

  bool loading = false;
  final Dio dio = Dio();
  double progress = 0.0;

// --                                                               -- //
// --                          START                                -- //
// --                                                               -- //
  Future<bool> saveFile(String url, String filename) async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage) &&
            // access media location needed for android 10/Q
            await _requestPermission(Permission.accessMediaLocation) &&
            // manage external storage needed for android 11/R
            await _requestPermission(Permission.manageExternalStorage)) {
          directory = (await getExternalStorageDirectory())!;
          // print(directory.path);
          String newPath = "";
          List<String> folders = directory.path.split("/");
          for (int x = 1; x < folders.length; x++) {
            String folder = folders[x];
            if (folder != "Android") {
              newPath += "/$folder";
            } else {
              break;
            }
          }
          newPath = "$newPath/ConnectApp";
          directory = Directory(newPath);
          // print(directory.path);
        } else {
          return false;
        }
      } else {
        //
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
        File saveFile = File("${directory.path}/$filename");
        // print(url);
        // print(saveFile.path);
        await dio.download(url, saveFile.path,
            onReceiveProgress: (downloaded, totalSize) {
          setState(() {
            progress = downloaded / totalSize;
          });
        });
        if (Platform.isIOS) {
          await ImageGallerySaver.saveFile(saveFile.path,
              isReturnPathOfIOS: true);
        }
        return true;
      }
    } catch (e) {
      // print(e);
    }
    return false;
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  downloadFile(String url, String filename) async {
    setState(() {
      loading = true;
    });
    bool downloaded = await saveFile(url, filename);
    if (downloaded) {
      // print("File Downloaded");
    } else {
      // print("Problem Downloading File");
    }

    setState(() {
      loading = false;
    });
  }

  Future delete(int id) async {
    var uri = Uri.parse('${apiURL}files/delete');
    String? token = await storage.read(key: "token");
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var request = http.MultipartRequest(
      'POST',
      uri,
    )..headers.addAll(headers);
    request.fields['file_id'] = id.toString();
    var response = await request.send();
    // var responseDecode = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      // final result = jsonDecode(responseDecode.body);
      // final result = jsonDecode(responseDecode.body) as Map<String, dynamic>;
      getFiles();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: HexColor("#30CED9"),
            dismissDirection: DismissDirection.vertical,
            content: const Text('Deleted successfully'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            dismissDirection: DismissDirection.vertical,
            content: Text('Server Error'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future uploadFile() async {
    var uri = Uri.parse('${apiURL}files/index');
    String? token = await storage.read(key: "token");
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var request = http.MultipartRequest(
      'POST',
      uri,
    )..headers.addAll(headers);
    if (file != null) {
      request.files.add(await http.MultipartFile.fromPath('file', file!.path!));
    }
    request.fields['title'] = title;
    request.fields['id'] = user;
    var response = await request.send();
    var responseDecode = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      // final result = jsonDecode(responseDecode.body);
      // final result = jsonDecode(responseDecode.body) as Map<String, dynamic>;
      setState(() {
        visible = false;
      });
      FocusManager.instance.primaryFocus?.unfocus();
      // _resetForm();
      getFiles();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: HexColor("#30CED9"),
            dismissDirection: DismissDirection.vertical,
            content: const Text('Added successfully'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } else {
      final result = jsonDecode(responseDecode.body);
      // print(result);
      // await EasyLoading.dismiss();
      FocusManager.instance.primaryFocus?.unfocus();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            dismissDirection: DismissDirection.vertical,
            content: Text("${result["message"]}"),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future getUsers() async {
    // await EasyLoading.show(
    //   status: 'Loading...',
    //   maskType: EasyLoadingMaskType.black,
    // );
    var url = Uri.parse('${apiURL}users');
    String? token = await storage.read(key: "token");
    String? id = await storage.read(key: "id");
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      var jsonBody = response.body;
      var jsonData = jsonDecode(jsonBody);
      if (mounted) {
        setState(() {
          users = jsonData['data'];
          var uId =
              jsonData['data'].where((o) => o['id'] == int.parse(id!)).toList();
          user = uId[0]['name'];
        });
      }
      await EasyLoading.dismiss();
    } else {
      await EasyLoading.dismiss();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            dismissDirection: DismissDirection.vertical,
            content: Text('Server Error'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future getFiles() async {
    await EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    var url = Uri.parse('${apiURL}files/index/$user');
    String? token = await storage.read(key: "token");
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      var jsonBody = response.body;
      var jsonData = jsonDecode(jsonBody);
      if (mounted) {
        setState(() {
          rowsAdd = [];
          for (var i = 0; i < jsonData['data'].length; i++) {
            rowsAdd.add(
              DataRow(
                cells: [
                  DataCell(Text(jsonData['data'][i]['title'])),
                  DataCell(
                    Text(
                      jsonData['data'][i]['name'] == null
                          ? ""
                          : "${jsonData['data'][i]['name']}",
                    ),
                  ),
                  DataCell(
                    Wrap(
                      alignment: WrapAlignment.start,
                      children: [
                        SizedBox(
                          width: 30,
                          child: IconButton(
                            icon: const Icon(Icons.download),
                            iconSize: 18,
                            color: Colors.black,
                            onPressed: () {
                              // showDialog(
                              //   context: context,
                              //   builder: (BuildContext context) =>
                              //       DownloadingDialog(
                              //     fileName: jsonData['data'][i]['file'],
                              //   ),
                              // );
                              downloadFile(
                                // "$downloadUrl${jsonData['data'][i]['file']}",
                                jsonData['data'][i]['file'],
                                jsonData['data'][i]['name'],
                                // "${publicUrl}demo/import_file_demo.csv",
                                // "CSV"
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: 30,
                          child: IconButton(
                            icon: const Icon(Icons.delete),
                            iconSize: 18,
                            color: Colors.red,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    actionsAlignment: MainAxisAlignment.center,
                                    title: Column(
                                      children: const [
                                        Image(
                                          image:
                                              AssetImage("images/delete.png"),
                                          width: 30,
                                          height: 30,
                                        ),
                                      ],
                                    ),
                                    content: const Text(
                                      "Are you sure want to delete?",
                                      textAlign: TextAlign.center,
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        onPressed: () {
                                          delete(jsonData['data'][i]['id']);
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Yes"),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("No"),
                                      ),
                                    ],
                                    elevation: 24,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        });
      }
      await EasyLoading.dismiss();
    } else {
      await EasyLoading.dismiss();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            dismissDirection: DismissDirection.vertical,
            content: Text('Server Error'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }
// --                                                               -- //
// --                           END                                 -- //
// --                                                               -- //

  @override
  void initState() {
    super.initState();
    getUsers();
    getFiles();
  }

  @override
  Widget build(BuildContext context) {
    String downloadingprogress = (progress * 100).toInt().toString();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Files",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Visibility(
                        visible: visible,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(10),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelText: "Title",
                                    ),
                                    onChanged: (value) {
                                      title = value;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(10),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelText: "File Name",
                                    ),
                                    enabled: false,
                                    initialValue: name,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              final result = await FilePicker.platform
                                  .pickFiles(type: FileType.any);
                              if (result == null) return;
                              setState(() {
                                file = result.files.first;
                                name = file!.name;
                                visible = true;
                              });
                              // print(file!.path);
                            },
                            style: ElevatedButton.styleFrom(
                              maximumSize: const Size(150, 50),
                              minimumSize: const Size(150, 50),
                              primary: HexColor("#13D13F"),
                            ),
                            child: const Text("Select File"),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Visibility(
                            visible: visible,
                            child: ElevatedButton(
                              onPressed: () {
                                if (!(_form.currentState?.validate() ?? true)) {
                                  return;
                                }
                                uploadFile();
                              },
                              style: ElevatedButton.styleFrom(
                                maximumSize: const Size(150, 50),
                                minimumSize: const Size(150, 50),
                              ),
                              child: const Text("Upload File"),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        child: widget.role != "user"
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Uploaded Files",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      color: HexColor("#222222"),
                                    ),
                                  ),
                                ],
                              )
                            : null,
                      ),
                      SizedBox(
                        child: widget.role != "user"
                            ? Form(
                                key: _form,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 20, 0, 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 2.0,
                                            spreadRadius: 0.4)
                                      ],
                                    ),
                                    child: DropdownSearch<String>(
                                      dropdownDecoratorProps:
                                          const DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          hintStyle:
                                              TextStyle(color: Colors.black),
                                          errorStyle: TextStyle(
                                              color: Colors.redAccent),
                                          border: InputBorder.none,
                                          suffixIcon:
                                              Icon(Icons.arrow_drop_down_sharp),
                                          contentPadding: EdgeInsets.only(
                                              left: 20, top: 10, bottom: 10),
                                          labelStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                          labelText: 'Select User',
                                        ),
                                      ),
                                      popupProps: const PopupProps.menu(
                                        showSelectedItems: true,
                                        // disabledItemFn: (String s) => s.startsWith('I'),
                                      ),
                                      items: (users)
                                          .map((e) => e["name"] as String)
                                          .toList(),
                                      selectedItem: user,
                                      validator: (value) {
                                        if (value == null || value == "") {
                                          return "Please select user";
                                        }

                                        return null;
                                      },
                                      onChanged: (value) {
                                        user = value!;
                                        getFiles();
                                      },
                                    ),
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width *
                          1, // minimum width
                    ),
                    child: DataTable(
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => HexColor("#30CED9")),
                      sortColumnIndex: 0,
                      sortAscending: true,
                      columns: const [
                        DataColumn(
                          label: Text("Title"),
                        ),
                        DataColumn(
                          label: Text("Filename"),
                        ),
                        DataColumn(
                          label: Text("  Action"),
                        ),
                      ],
                      rows: rowsAdd,
                    ),
                  ),
                )
              ],
            ),
            loading
                ? Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                      AlertDialog(
                        backgroundColor: Colors.black,
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CircularProgressIndicator.adaptive(),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Downloading: $downloadingprogress%",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  void dropdownCallback(int? selectedValue) {
    if (selectedValue is int) {
      setState(() {});
      // print(selectedValue);
    }
  }
}

// The "soruce" of the table
