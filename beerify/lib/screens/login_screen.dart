import 'package:beerify/core/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:beerify/server.dart' as server;

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _isHiddenPassword = true;
  String email = '';
  String password = '';
  final loginFormKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Login Screen",
              style: TextStyle(color: Colors.greenAccent))),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Sign In Text
            Text("Login Screen"),
            SizedBox(height: 16),
            //Container, in which I write Username above Username TextFormField
            Container(
              child: Text("Username"),
            ),
            SizedBox(height: 8),
            //Form, which contains Username, and Password TextFormFields,
            //On every character press, it calls both TextFormFields validator through his onChanged method
            Form(
              key: loginFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_circle_rounded),
                      hintText: "Please, enter a username!",
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.lightGreen),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.redAccent),
                      ),
                    ),
                    //the validator not allows empty username fields
                    controller: userNameController,
                    validator: (String? value) {
                      if (value == '') {
                        //If we forgot to write anything in the username fields, the app warns us.
                        return "Empty field!";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  SizedBox(height: 8),
                  //Password text above Password TextFormField
                  Text("Password field"),
                  SizedBox(height: 8),
                  TextFormField(
                    obscureText: _isHiddenPassword,
                    decoration: InputDecoration(
                      hintText: "Enter a password!",
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: InkWell(
                        onTap: _togglePasswordView,
                        child: _isHiddenPassword
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.redAccent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.redAccent),
                      ),
                      //Hides the text in the Form
                    ),
                    //the validator not allows empty username fields
                    controller: passwordController,
                    validator: (String? value) {
                      if (value == '') {
                        //If we forgot to write anything in password fields, the app warns us.
                        return "Password field is empty!";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  SizedBox(height: 16),
                  //The button which allows to sign in your app.
                  //It is only visible, when both Username, and Password fields are not empty
                  Container(
                      width: 400,
                      height: 60,
                      child: ElevatedButton(
                          child: Text(
                            "Login",
                          ),
                          onPressed: () async {
                            if (loginFormKey.currentState!.validate()) {
                              if (await server.login(userNameController.text.toString(), passwordController.text.toString()) == true) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login successfully!')));
                                Navigator.pushNamed(context, RoutePaths.navigationRoute);
                                print('Yeaahboyyy');
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('The user, or password is not correct.')));
                                print('Noope');
                              }
                            }
                          }),
                  ),
                  SizedBox(height: 8),
                  //Button, which navigates to RegisterScreen, if the user wants to make an account.
                  TextButton(
                      child: Text(
                        "Register an account!",
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, RoutePaths.registerRoute);
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }
}
