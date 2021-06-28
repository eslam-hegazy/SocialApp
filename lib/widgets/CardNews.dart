import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:line_icons/line_icons.dart';
import 'package:social/Cubits/HomeCubit/cubitApp.dart';
import 'package:social/models/PostModel.dart';

class CardNews extends StatelessWidget {
  var comment = 0;
  final PostModel model;
  final int index;
  CardNews(this.model, this.index);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        color: Color(0xFF18191a).withOpacity(0.9),
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(model.profileImage),
                    ),
                    SizedBox(width: 13),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              model.name,
                              style: Theme.of(context).textTheme.headline1,
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          model.dataTime,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontFamily: "FredokaOne",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_horiz),
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(
              color: Colors.grey,
            ),
            SizedBox(height: 5),
            Text(
              model.text,
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(height: 10),
            if (model.postimage != '')
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(model.postimage),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            if (model.postimage != '') SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 15,
                    ),
                    SizedBox(width: 3),
                    Text(
                      cubitApp.get(context).likes[index] == 0
                          ? '0'
                          : "${cubitApp.get(context).likes[index]}",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontFamily: "FredokaOne",
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.comment,
                      color: Colors.red,
                      size: 15,
                    ),
                    SizedBox(width: 3),
                    Text(
                      "10",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontFamily: "FredokaOne",
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    cubitApp
                        .get(context)
                        .PostLike(cubitApp.get(context).postsId[index]);
                  },
                  child: Row(
                    children: [
                      cubitApp.get(context).likes[index] > 0
                          ? Icon(
                              Icons.favorite_outlined,
                              color: Colors.red,
                            )
                          : Icon(
                              Icons.favorite_outlined,
                              color: Colors.grey,
                            ),
                      SizedBox(width: 7),
                      Text(
                        "Love",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            LineIcons.commentAlt,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 7),
                          Text(
                            "Commments",
                            style: Theme.of(context).textTheme.headline2,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(color: Colors.grey),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      model.profileImage,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Enter Your Comment .....",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
