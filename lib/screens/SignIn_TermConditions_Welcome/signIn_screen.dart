// ignore: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:hexcolor/hexcolor.dart';
import '../../Globals/globals.dart';
import '../BottomNavBar/bottomNavBar_screen.dart';
import 'term_and_condition.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final storage = const FlutterSecureStorage();
  bool _isObscure = true;
  bool isChecked = false;
  String? email;
  String? password;
  final GlobalKey<FormState> _form = GlobalKey();

  void _navigate(String role) {
    Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => BottomNavBar(
          role: role,
          index: null,
          i: '',
          u: '',
        ),
      ),
      (route) => false,
    );
  }

// --                                                               -- //
// --                          START                                -- //
// --                                                               -- //
  Future signIn() async {
    await EasyLoading.show(
      status: 'Processing...',
      maskType: EasyLoadingMaskType.black,
    );
    var uri = Uri.parse('${apiURL}signin');
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
    };
    var request = http.MultipartRequest(
      'POST',
      uri,
    )..headers.addAll(headers);
    request.fields['email'] = email.toString();
    request.fields['password'] = password.toString();

    var response = await request.send();
    var responseDecode = await http.Response.fromStream(response);
    // final result = jsonDecode(responseDecode.body) as Map<String, dynamic>;
    if (response.statusCode == 200) {
      final result = jsonDecode(responseDecode.body);
      await storage.write(key: "token", value: result["token"]);
      await storage.write(key: "role", value: result["data"]["role"]);
      await storage.write(key: "id", value: result["data"]["id"].toString());
      _navigate(result["data"]["role"]);
      await EasyLoading.dismiss();
    } else if (response.statusCode == 203) {
      await EasyLoading.dismiss();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            dismissDirection: DismissDirection.vertical,
            content: Text('Incorrect email or password'),
            duration: Duration(seconds: 2),
          ),
        );
      }
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
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: HexColor("#30CED9"),
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30),
              ),
            ),
            child: Form(
              key: _form,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 50.0, horizontal: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          "Sign in",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Enter your email',
                            prefixIcon: const Icon(Icons.mail),
                          ),
                          validator: (value) {
                            if (value == null || value == "") {
                              return "Please enter Email";
                            }

                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: _isObscure,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value == "") {
                              return "Please enter Password";
                            }

                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  activeColor: HexColor("#30CED9"),
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  },
                                ),
                                const Text(
                                  "Remember me",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            Text(
                              "Forgot password?",
                              style: TextStyle(color: HexColor("#30CED9")),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30.0),
                          child: SizedBox(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                primary: HexColor("#30CED9"),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              onPressed: () {
                                if (!(_form.currentState?.validate() ?? true)) {
                                  return;
                                }
                                signIn();
                              },
                              child: const Text(
                                "Sign In",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const TermAndCondition();
                              },
                            );
                          },
                          child: const Text(
                            "Terms & Conditions",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
