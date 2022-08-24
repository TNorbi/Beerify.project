import 'package:flutter/material.dart';
import 'package:beerify/server.dart' as server;

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final registerFormKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController secondNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String firstName = '';
  String lastName = '';
  String userName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.all(24.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Register"),
                  SizedBox(height: 16),
                  Form(
                    key: registerFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: firstNameController,
                          decoration: InputDecoration(
                            hintText: "First name",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Colors.lightGreen),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.redAccent),
                            ),
                          ),
                          validator: (String? value) {
                            if (value == '') {
                              //If we forgot to write anything in the username fields, the app warns us.
                              return "Empty field!";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            firstName = value;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: secondNameController,
                          decoration: InputDecoration(
                            hintText: "Last name",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Colors.lightGreen),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.redAccent),
                            ),
                          ),
                          validator: (String? value) {
                            if (value == '') {
                              //If we forgot to write anything in the username fields, the app warns us.
                              return "Empty field!";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            firstName = value;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            hintText: "Username",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Colors.lightGreen),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.redAccent),
                            ),
                          ),
                          validator: (String? value) {
                            if (value == '') {
                              //If we forgot to write anything in the username fields, the app warns us.
                              return "Empty field!";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            firstName = value;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            hintText: "Password",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Colors.lightGreen),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.redAccent),
                            ),
                          ),
                          validator: (String? value) {
                            if (value == '') {
                              //If we forgot to write anything in the username fields, the app warns us.
                              return "Empty field!";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            firstName = value;
                          },
                        ),
                        SizedBox(height: 32),
                        Container(
                            width: 400,
                            height: 50,
                            child: ElevatedButton(
                                child: Text("Register"),
                                onPressed: () async {
                                  if (registerFormKey.currentState!
                                      .validate()) if (await server.register(
                                          firstNameController.text.toString(),
                                          secondNameController.text.toString(),
                                          usernameController.text.toString(),
                                          passwordController.text.toString()) ==
                                      true)
                                    print('Sikeres regisztracio geeeeeecc!!');
                                  else
                                    print('Sikertelen regisztracio.');
                                }
                                /*async {
                              if(registerFormKey.currentState!.validate()) {
                                if (await server.)
                              }
                            }

                               */
                                ))
                      ],
                    ),
                  ),
                ])));
  }
}
