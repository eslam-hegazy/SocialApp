import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social/Cubits/HomeCubit/cubitApp.dart';
import 'package:social/Cubits/HomeCubit/stateApp.dart';
import 'package:social/widgets/add_thing.dart';

class Add_Posts extends StatelessWidget {
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<cubitApp>(
      create: (BuildContext context) => cubitApp()..getUserDate(),
      child: BlocConsumer<cubitApp, stateApp>(
        listener: (context, state) {
          if (state is SuccessfulUpDatePost) {
            Navigator.pop(context);
            cubitApp.get(context).removePostImage();
            cubitApp.get(context).getPost();
            print(cubitApp.get(context).PostImage);
          }
        },
        builder: (context, state) {
          var cubit = cubitApp.get(context);
          var model = cubitApp.get(context).model;
          return Scaffold(
            appBar: AppBar(
              title: Text("Create Post",
                  style: Theme.of(context).textTheme.headline2),
              actions: [
                FlatButton(
                  onPressed: () {
                    var now = DateTime.now();
                    if (cubit.PostImage != null) {
                      cubit.UploadpostImageUser(
                          dateTime: now.toString(), text: textController.text);
                    } else {
                      cubit.Createpost(
                          dataTime: now.toString(), text: textController.text);
                    }
                  },
                  child: Text(
                    "POST",
                    style:
                        TextStyle(color: Colors.blue, fontFamily: "FredokaOne"),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(11),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (state is LoadingUpdatePost) LinearProgressIndicator(),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: model.cover == ""
                              ? NetworkImage(
                                  "https://image.freepik.com/free-photo/studio-shot-cheerful-religious-muslim-woman-keeps-arms-folded-smiles-broadly-has-white-teeth_273609-27065.jpg")
                              : NetworkImage(model.cover),
                        ),
                        SizedBox(width: 15),
                        Text(
                          model.name,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: TextFormField(
                        maxLines: 50,
                        controller: textController,
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 18,
                          fontFamily: "FredokaOne",
                        ),
                        decoration: InputDecoration(
                          hintText: "What Is On Your Mind .... ",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontFamily: "FredokaOne",
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    if (cubit.PostImage != null)
                      Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: double.infinity,
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.35,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: FileImage(cubit.PostImage),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5000),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: IconButton(
                                    onPressed: () {
                                      cubit.removePostImage();
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            cubit.getImagePost();
                          },
                          child: Add_Thing(
                            Icons.photo,
                            "add photo",
                          ),
                        ),
                        Text(
                          "|",
                          style: TextStyle(color: Colors.grey, fontSize: 25),
                        ),
                        Add_Thing(
                          Icons.video_call,
                          "add video",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
