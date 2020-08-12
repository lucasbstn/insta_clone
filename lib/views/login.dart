import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

import 'package:insta_clone/controllers/user_controller.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool showPwd = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool enableSubmit1 = false;
  bool enableSubmit2 = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: Get.height,
              child: Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Instagram',
                        style: TextStyle(
                                fontFamily: 'Billabong', color: Colors.black)
                            .copyWith(fontSize: 70),
                      ),
                      SizedBox(height: 24),
                      SizedBox(
                        width: Get.width * 0.9,
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Email address',
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey[400],
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (!GetUtils.isEmail(value)) {
                              return 'Enter a valid email.';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              setState(() => enableSubmit1 = true);
                            } else {
                              setState(() => enableSubmit1 = false);
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 14),
                      SizedBox(
                        width: Get.width * 0.9,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            TextFormField(
                              obscureText: !showPwd,
                              controller: pwdController,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey[400],
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (!GetUtils.isLengthGreaterOrEqual(
                                    value, 6)) {
                                  return 'Password must be longer than 6 characters';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  setState(() => enableSubmit2 = true);
                                } else {
                                  setState(() => enableSubmit2 = false);
                                }
                              },
                            ),
                            Positioned(
                              right: 3,
                              child: IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: () =>
                                    setState(() => showPwd = !showPwd),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 14),
                      SizedBox(
                        width: Get.width * 0.9,
                        child: RaisedButton(
                          child: Text(
                            'Log In',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                          disabledColor: Colors.blue[200],
                          onPressed: enableSubmit1 && enableSubmit2
                              ? () => logIn()
                              : null,
                        ),
                      ),
                      SizedBox(height: 14),
                      RichText(
                        text: TextSpan(
                          text: 'Forgotten your login details?',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          children: [
                            TextSpan(
                              text: 'Get help with signing in.',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              indent: Get.width * 0.04,
                              endIndent: Get.width * 0.01,
                              thickness: 1.3,
                            ),
                          ),
                          Text(
                            'OR',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              endIndent: Get.width * 0.04,
                              indent: Get.width * 0.01,
                              thickness: 1.3,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Entypo.facebook_with_circle,
                                color: Colors.blue,
                              ),
                              Text(
                                ' Log In With Facebook',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                          onTap: () => null //TODO ROUTE log in with fb
                          ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              child: GestureDetector(
                  child: Column(
                    children: [
                      Divider(thickness: 1.3, color: Colors.black),
                      RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account? ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          children: [
                            TextSpan(
                              text: 'Sign up.',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  onTap: () => null //TODO route to register page
                  ),
            ),
          ],
        ),
      ),
    );
  }

  logIn() {
    if (_formKey.currentState.validate()) {
      UserController userController = Get.find<UserController>();
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: pwdController.text)
          .then((res) => userController.signIn(res.user));
    }
  }
}
