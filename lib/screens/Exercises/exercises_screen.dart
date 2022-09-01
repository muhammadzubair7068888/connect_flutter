import 'dart:convert';
import 'dart:io';

import 'package:connect/screens/Exercises/edit_exercise_screen.dart';
import 'package:connect/screens/Exercises/view_exercise_screen.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../Globals/globals.dart';
import 'package:http/http.dart' as http;
import 'new_exercise_screen.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  final storage = const FlutterSecureStorage();
  List<DataRow> rowsAdd = [];

  List data = [];
  List search = [];
  bool loading = false;
  final Dio dio = Dio();
  double progress = 0;
  PlatformFile? file;
  String name = "";
  TextEditingController controller = TextEditingController();

// --                                                               -- //
// --                          START                                -- //
// --                                                               -- //
  // Future<bool> saveFile(String url, String filename) async {
  //   Directory directory;
  //   try {
  //     if (Platform.isAndroid) {
  //       if (await _requestPermission(Permission.storage) &&
  //           // access media location needed for android 10/Q
  //           await _requestPermission(Permission.accessMediaLocation) &&
  //           // manage external storage needed for android 11/R
  //           await _requestPermission(Permission.manageExternalStorage)) {
  //         directory = (await getExternalStorageDirectory())!;
  //         // print(directory.path);
  //         String newPath = "";
  //         List<String> folders = directory.path.split("/");
  //         for (int x = 1; x < folders.length; x++) {
  //           String folder = folders[x];
  //           if (folder != "Android") {
  //             newPath += "/$folder";
  //           } else {
  //             break;
  //           }
  //         }
  //         newPath = "$newPath/ConnectApp";
  //         directory = Directory(newPath);
  //         // print(directory.path);
  //       } else {
  //         return false;
  //       }
  //     } else {
  //       //
  //       if (await _requestPermission(Permission.photos)) {
  //         directory = await getTemporaryDirectory();
  //       } else {
  //         return false;
  //       }
  //     }
  //     if (!await directory.exists()) {
  //       await directory.create(recursive: true);
  //     }
  //     if (await directory.exists()) {
  //       File saveFile = File("${directory.path}/$filename");
  //       // print(url);
  //       // print(saveFile.path);
  //       await dio.download(url, saveFile.path,
  //           onReceiveProgress: (downloaded, totalSize) {
  //         setState(() {
  //           progress = downloaded / totalSize;
  //         });
  //       });
  //       if (Platform.isIOS) {
  //         await ImageGallerySaver.saveFile(saveFile.path,
  //             isReturnPathOfIOS: true);
  //       }
  //       return true;
  //     }
  //   } catch (e) {
  //     // print(e);
  //   }
  //   return false;
  // }

  // Future<bool> _requestPermission(Permission permission) async {
  //   if (await permission.isGranted) {
  //     return true;
  //   } else {
  //     var result = await permission.request();
  //     if (result == PermissionStatus.granted) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   }
  // }

  // downloadFile(String url, String filename) async {
  //   setState(() {
  //     loading = true;
  //   });
  //   bool downloaded = await saveFile(url, filename);
  //   if (downloaded) {
  //     print("File Downloaded");
  //   } else {
  //     print("Problem Downloading File");
  //   }

  //   setState(() {
  //     loading = false;
  //   });
  // }

  Future<bool> saveFile(String url, String fileName) async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = (await getExternalStorageDirectory())!;
          String newPath = "";
          // print("directory");
          // print(directory);
          List<String> paths = directory.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/$folder";
            } else {
              break;
            }
          }
          newPath = "$newPath/ConnectApp";
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
        File saveFile = File("${directory.path}/$fileName");
        // print("url");
        // print(url);
        // print("saveFile.path");
        // print(saveFile.path);
        await dio.download(url, saveFile.path,
            onReceiveProgress: (value1, value2) {
          setState(() {
            progress = value1 / value2;
          });
        });
        if (Platform.isIOS) {
          await ImageGallerySaver.saveFile(saveFile.path,
              isReturnPathOfIOS: true);
        }
        return true;
      }
      return false;
    } catch (e) {
      // print("e");
      // print(e);
      return false;
    }
  }

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
    bool downloaded = await saveFile(
      "${publicUrl}demo/import_file_demo.csv",
      "import_file_demo.csv",
    );
    if (downloaded) {
      // print("File Downloaded");
    } else {
      // print("Problem Downloading File");
    }
    setState(() {
      loading = false;
    });
  }

  onSearch(String text) async {
    search.clear();
    if (text.isEmpty) {
      getExercises();
    }

    for (var f in data) {
      if (f["name"].contains(text) ||
          f['exercise_type']['name'].contains(text) ||
          f['description'].contains(text)) {
        search.add(f);
      }
    }
    setState(() {
      if (search.isNotEmpty) {
        rowsAdd = [];
        for (var i = 0; i < search.length; i++) {
          rowsAdd.add(
            DataRow(
              cells: [
                DataCell(Text(search[i]['name'])),
                DataCell(Text(search[i]['exercise_type']['name'])),
                DataCell(Text(search[i]['description'])),
                DataCell(
                  Wrap(
                    alignment: WrapAlignment.start,
                    children: [
                      SizedBox(
                        width: 30,
                        child: IconButton(
                          icon: const Icon(Icons.remove_red_eye),
                          iconSize: 18,
                          color: HexColor("#30CED9"),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewExerciseScreen(
                                  id: search[i]['id'],
                                  description: search[i]['description'],
                                  title: search[i]['name'],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        width: 30,
                        child: IconButton(
                          icon: const Icon(Icons.edit_outlined),
                          iconSize: 18,
                          color: HexColor("#30CED9"),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditExercise(
                                  id: search[i]['id'],
                                  description: search[i]['description'],
                                  title: search[i]['name'],
                                  type: search[i]['exercise_type']['name'],
                                ),
                              ),
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
                                        image: AssetImage("images/delete.png"),
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
                                        delete(search[i]['id']);
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
                )
              ],
            ),
          );
        }
      }
    });
  }

  Future delete(int id) async {
    var uri = Uri.parse('${apiURL}exercises/del');
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
    request.fields['exercise_id'] = id.toString();
    var response = await request.send();
    // var responseDecode = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      // final result = jsonDecode(responseDecode.body);
      // final result = jsonDecode(responseDecode.body) as Map<String, dynamic>;
      getExercises();
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

  Future getExercises() async {
    await EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    var url = Uri.parse('${apiURL}exercises/index');
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
          data = jsonData['data'];
          rowsAdd = [];
          for (var i = 0; i < jsonData['data'].length; i++) {
            rowsAdd.add(
              DataRow(
                cells: [
                  DataCell(Text(jsonData['data'][i]['name'])),
                  DataCell(Text(jsonData['data'][i]['exercise_type']['name'])),
                  DataCell(Text(jsonData['data'][i]['description'])),
                  DataCell(
                    Wrap(
                      alignment: WrapAlignment.start,
                      children: [
                        SizedBox(
                          width: 30,
                          child: IconButton(
                            icon: const Icon(Icons.remove_red_eye),
                            iconSize: 18,
                            color: HexColor("#30CED9"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewExerciseScreen(
                                    id: jsonData['data'][i]['id'],
                                    description: jsonData['data'][i]
                                        ['description'],
                                    title: jsonData['data'][i]['name'],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: 30,
                          child: IconButton(
                            icon: const Icon(Icons.edit_outlined),
                            iconSize: 18,
                            color: HexColor("#30CED9"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditExercise(
                                    id: jsonData['data'][i]['id'],
                                    description: jsonData['data'][i]
                                        ['description'],
                                    title: jsonData['data'][i]['name'],
                                    type: jsonData['data'][i]['exercise_type']
                                        ['name'],
                                  ),
                                ),
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
                  )
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

  Future uploadCsv() async {
    // print(file!.path);
    var uri = Uri.parse('${apiURL}exercises/csv');
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
    var response = await request.send();
    // var responseDecode = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      // final result = jsonDecode(responseDecode.body);
      // final result = jsonDecode(responseDecode.body) as Map<String, dynamic>;
      FocusManager.instance.primaryFocus?.unfocus();
      // _resetForm();
      getExercises();
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
      FocusManager.instance.primaryFocus?.unfocus();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            dismissDirection: DismissDirection.vertical,
            content: Text("Error importing this file"),
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
    getExercises();
  }

  @override
  Widget build(BuildContext context) {
    String downloadingprogress = (progress * 100).toInt().toString();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            maximumSize: const Size(150, 50),
                            minimumSize: const Size(150, 50),
                            primary: HexColor("#31D858"),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const NewExercise(),
                              ),
                            );
                          },
                          child: const Text("Add New"),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            maximumSize: const Size(150, 50),
                            minimumSize: const Size(150, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: () async {
                            final result = await FilePicker.platform
                                .pickFiles(type: FileType.any);
                            if (result == null) return;
                            setState(() {
                              file = result.files.first;
                              name = file!.name;
                            });
                            uploadCsv();
                          },
                          child: const Text("Import CSV"),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      // Expanded(
                      //   child: ElevatedButton(
                      //     style: ElevatedButton.styleFrom(
                      //       maximumSize: const Size(150, 50),
                      //       minimumSize: const Size(150, 50),
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(10.0),
                      //       ),
                      //     ),
                      //     onPressed: () {
                      //       downloadFile();
                      //     },
                      //     child: const Text("Demo CSV"),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: TextField(
                              controller: controller,
                              onChanged: onSearch,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                label: const Text("Search"),
                              ),
                              // onChanged: searchBook,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: MaterialStateColor.resolveWith(
                        (states) => HexColor("#30CED9")),
                    sortColumnIndex: 0,
                    sortAscending: true,
                    columns: const [
                      DataColumn(
                        label: Text("Name"),
                      ),
                      DataColumn(
                        label: Text("Type"),
                      ),
                      DataColumn(
                        label: Text("Description"),
                      ),
                      DataColumn(
                        label: Text("   Action"),
                      ),
                    ],
                    rows: rowsAdd,
                  ),
                ),
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
}
