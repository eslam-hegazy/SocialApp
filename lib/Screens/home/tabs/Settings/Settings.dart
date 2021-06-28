import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social/Cubits/HomeCubit/cubitApp.dart';
import 'package:social/Cubits/HomeCubit/stateApp.dart';
import 'package:social/Screens/home/tabs/Settings/UpDate.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubitApp, stateApp>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = cubitApp.get(context).model;
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.31,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        height: MediaQuery.of(context).size.height * 0.24,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          image: DecorationImage(
                            image: model.cover == ""
                                ? NetworkImage(
                                    "https://image.freepik.com/free-photo/studio-shot-cheerful-religious-muslim-woman-keeps-arms-folded-smiles-broadly-has-white-teeth_273609-27065.jpg")
                                : NetworkImage(model.cover),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 53,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: model.cover == ""
                                ? NetworkImage(
                                    "https://image.freepik.com/free-photo/studio-shot-cheerful-religious-muslim-woman-keeps-arms-folded-smiles-broadly-has-white-teeth_273609-27065.jpg")
                                : NetworkImage(model.cover),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  model.name,
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(height: 5),
                Text(
                  model.bio,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontFamily: "FredokaOne",
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            "100",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          Text(
                            "Posts",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontFamily: "FredokaOne",
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "100",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          Text(
                            "Photos",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontFamily: "FredokaOne",
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "100",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          Text(
                            "Followers",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontFamily: "FredokaOne",
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "100",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          Text(
                            "Following",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontFamily: "FredokaOne",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: FlatButton(
                        height: 45,
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        color: Color(0xFF18191a),
                        child: Text(
                          "Add Photos",
                          style: TextStyle(
                              color: Colors.blue,
                              fontFamily: "PermanentMarker"),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    FlatButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return UpDate(model);
                        }));
                      },
                      height: 45,
                      color: Color(0xFF18191a),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
