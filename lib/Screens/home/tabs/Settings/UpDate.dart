import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social/Cubits/HomeCubit/cubitApp.dart';
import 'package:social/Cubits/HomeCubit/stateApp.dart';
import 'package:social/models/RegisterModel.dart';

import 'package:social/widgets/defaultTextForm.dart';

class UpDate extends StatelessWidget {
  var nameContoller = TextEditingController();
  var bioContoller = TextEditingController();
  var phoneContoller = TextEditingController();

  var _formKey = GlobalKey<FormState>();
  final RegisterModelUser model;

  UpDate(this.model);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<cubitApp>(
      create: (BuildContext context) => cubitApp(),
      child: BlocConsumer<cubitApp, stateApp>(
        listener: (context, state) {
          if (state is SuccessfulUpdateProfile) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          nameContoller.text = model.name;
          bioContoller.text = model.bio;
          phoneContoller.text = model.phone;
          return Scaffold(
            appBar: AppBar(
              actions: [
                FlatButton(
                  onPressed: () {
                    cubitApp.get(context).UpDateProfileDate(
                          name: nameContoller.text,
                          bio: bioContoller.text,
                          phone: phoneContoller.text,
                          email: model.email,
                        );
                  },
                  child: Text(
                    "UPDATE",
                    style:
                        TextStyle(color: Colors.blue, fontFamily: "FredokaOne"),
                  ),
                ),
              ],
              title: Text("Edit Profile",
                  style: Theme.of(context).textTheme.headline2),
            ),
            body: Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      if (state is LoadingUpdateProfile)
                        LinearProgressIndicator(),
                      SizedBox(height: 10),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.31,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Container(
                                    alignment: Alignment.topCenter,
                                    height: MediaQuery.of(context).size.height *
                                        0.24,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      image: DecorationImage(
                                        image:
                                            cubitApp.get(context).CoverUser ==
                                                    null
                                                ? NetworkImage(model.cover)
                                                : FileImage(cubitApp
                                                    .get(context)
                                                    .CoverUser),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      cubitApp.get(context).getCoverUser();
                                    },
                                    icon: CircleAvatar(
                                        child:
                                            Icon(Icons.add_a_photo_outlined)),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 53,
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: cubitApp
                                                  .get(context)
                                                  .ImageUser ==
                                              null
                                          ? NetworkImage(model.image)
                                          : FileImage(
                                              cubitApp.get(context).ImageUser),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: -3,
                                    right: -5,
                                    child: IconButton(
                                      onPressed: () {
                                        cubitApp.get(context).getImageUser();
                                      },
                                      icon: CircleAvatar(
                                          child:
                                              Icon(Icons.add_a_photo_outlined)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      defaultTextForm(
                        Icons.info_outline_rounded,
                        "Name",
                        "Enter Name",
                        nameContoller,
                        (value) {
                          if (value == null) {
                            return "Please Enter Your New Name";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      defaultTextForm(
                        Icons.info_outline_rounded,
                        "Bio",
                        "Enter Bio",
                        bioContoller,
                        (value) {
                          if (value == null) {
                            return "Please Enter Your New Bio";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      defaultTextForm(
                        Icons.phone,
                        "Phone",
                        "Enter Phone Number",
                        phoneContoller,
                        (value) {
                          if (value == null) {
                            return "Please Enter Your New Phone";
                          }
                          return null;
                        },
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
