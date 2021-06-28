import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:lottie/lottie.dart';
import 'package:social/Cubits/Auth_Cubit/cubit.dart';
import 'package:social/Cubits/Auth_Cubit/state.dart';

import 'package:social/Screens/Register/Register.dart';
import 'package:social/Screens/home/home_Screen.dart';
import 'package:social/network/local/CacheHelper.dart';
import 'package:social/widgets/defaultButton.dart';
import 'package:social/widgets/defaultTextForm.dart';

class login extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<cubit>(
      create: (BuildContext context) => cubit(),
      child: BlocConsumer<cubit, state>(
        listener: (context, state) {
          if (state is ErrorLoginState) {
            Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else if (state is SuccessfulLoginState) {
            Cachehelper.setDate(key: 'token', value: state.mess).then((value) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) {
                return HomeScreen();
              }));
            });
          }
        },
        builder: (context, state) {
          var data = cubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(right: 18, left: 18),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height * 0.30,
                          child: Lottie.asset("images/53395-login.json")),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Login !",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "FredokaOne",
                            fontSize: 27,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Login Now To Browse Our Hot Offers !",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "BalsamiqSans",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      defaultTextForm(
                        Icons.email,
                        "Email",
                        "Email Address",
                        emailController,
                        (value) {
                          if (value.isEmpty) {
                            return "Please Enter Your Name";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please Enter Your Password";
                          }
                          return null;
                        },
                        controller: passwordController,
                        obscureText: data.secure,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color(0xFF18191a),
                          ),
                          labelText: "Password",
                          hintText: "Password",
                          suffixIcon: IconButton(
                            onPressed: () {
                              data.changesecure();
                            },
                            icon: Icon(data.icon, color: Color(0xFF18191a)),
                          ),
                          hintStyle: TextStyle(
                              fontFamily: "BalsamiqSans",
                              fontWeight: FontWeight.bold),
                          labelStyle: TextStyle(fontFamily: "FredokaOne"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: data.check,
                            onChanged: (value) {
                              data.changeBok();
                            },
                          ),
                          Text(
                            "Remember Me",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ],
                      ),
                      SizedBox(height: 13),
                      ConditionalBuilder(
                        condition: state is! LoadingLoginState,
                        builder: (context) => InkWell(
                          onTap: () {
                            if (_formkey.currentState.validate()) {
                              data.LoginUser(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          child: defaultBotton("Login"),
                        ),
                        fallback: (context) => Center(
                          child: Lottie.asset("images/60109-loading-50.json",
                              height: 40),
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't Have An Account ? ",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (_) {
                                return Register();
                              }));
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontFamily: "FredokaOne",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class LoginUser {}
