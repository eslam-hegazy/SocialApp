import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social/Cubits/HomeCubit/stateApp.dart';

import 'package:social/Screens/home/tabs/Chats/Chats.dart';
import 'package:social/Screens/home/tabs/Favorite/Favorite.dart';

import 'package:social/Screens/home/tabs/Home/Home.dart';
import 'package:social/Screens/home/tabs/Settings/Settings.dart';
import 'package:social/main.dart';
import 'package:social/models/PostModel.dart';
import 'package:social/models/RegisterModel.dart';

class cubitApp extends Cubit<stateApp> {
  cubitApp() : super(INitialState());
  static cubitApp get(context) => BlocProvider.of(context);
  int index = 0;
  void changeIndex(int number) {
    if (number == 0) {
      getUserDate();
    }
    index = number;
    emit(ChangeIndex());
  }

  List title = [
    'Home',
    'Chats',
    'Users',
    'Settings',
  ];
  List<dynamic> screen = [
    Home(),
    Chats(),
    Favorite(),
    Setting(),
  ];
  RegisterModelUser model;
  void getUserDate() {
    emit(LoadingGetDateUser());
    FirebaseFirestore.instance
        .collection('users')
        .doc(token)
        .get()
        .then((value) {
      model = RegisterModelUser.fromJson(value.data());
      print(model.image);
      emit(SuccessfulGetDateUser());
      print(value.toString());
    }).catchError((error) {
      emit(ErrorGetDateUser());
    });
  }

  //////////////////////////////images

  ///////////////////////ImageUser
  File ImageUser;
  final picker1 = ImagePicker();

  Future getImageUser() async {
    final pickedFile = await picker1.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      ImageUser = File(pickedFile.path);
      print(pickedFile.path);
      emit(SuccessfulImageUser());
      UploadImageUser();
    } else {
      print('No image selected.');
      emit(ErrorImageUser());
    }
  }

  String ImageUrl = "";
  void UploadImageUser() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(ImageUser.path).pathSegments.last}')
        .putFile(ImageUser)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SuccessfulImageUser());
        ImageUrl = value;
        print(value);
      }).catchError((error) {
        print(value);
        emit(ErrorImageUser());
      });
    }).catchError((error) {});
  }

  //////////////////////CoverUser
  File CoverUser;
  final picker2 = ImagePicker();

  Future getCoverUser() async {
    final pickedFile = await picker2.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      CoverUser = File(pickedFile.path);
      emit(SuccessfulCoverUser());
      UploadCoverUser();
    } else {
      print('No image selected.');
      emit(ErrorCoverUser());
    }
  }

  String CoverUrl = "";
  void UploadCoverUser() async {
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(CoverUser.path).pathSegments.last}')
        .putFile(CoverUser)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        CoverUrl = value;
        print(CoverUrl);
        emit(SuccessfulCoverUser());
      }).catchError((error) {
        print(value);
        emit(ErrorCoverUser());
      });
    }).catchError((error) {});
  }

  void UpDateProfileDate(
      {@required String name,
      @required String bio,
      @required String phone,
      @required String email}) {
    emit(LoadingUpdateProfile());
    if (ImageUrl != null) {
      UploadImageUser();
      UpDateUser(name: name, bio: bio, phone: phone, email: email);
    } else if (CoverUrl != null) {
      UploadCoverUser();
      UpDateUser(name: name, bio: bio, phone: phone, email: email);
    } else if (ImageUrl != null && CoverUrl != null) {
      UpDateUser(
        name: name,
        bio: bio,
        phone: phone,
        email: email,
      );
    }
  }

  void UpDateUser({
    @required String name,
    @required String bio,
    @required String phone,
    @required String email,
  }) {
    RegisterModelUser update = RegisterModelUser(
      name: name,
      phone: phone,
      email: email,
      uid: token,
      image: ImageUrl == "" ? model.image : ImageUrl,
      cover: CoverUrl == "" ? model.cover : CoverUrl,
      bio: bio,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(token)
        .update(update.toJson())
        .then((value) {
      getUserDate();
      emit(SuccessfulUpdateProfile());
    }).catchError((error) {
      print(error);
      emit(ErrorUpdateProfile());
      print(error.toString());
    });
  }

  ////////////////////////posts
  File PostImage;
  final picker3 = ImagePicker();

  Future getImagePost() async {
    final pickedFile = await picker3.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      PostImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SuccessfulGetImagePost());
      UploadImageUser();
    } else {
      print('No image selected.');
      emit(ErrorGetImagePost());
    }
  }

  void UploadpostImageUser({
    @required String dateTime,
    @required String text,
  }) async {
    emit(LoadingUpdatePost());
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Posts/${Uri.file(PostImage.path).pathSegments.last}')
        .putFile(PostImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        Createpost(dataTime: dateTime, image: value, text: text);

        emit(SuccessfulUpDatePost());
      }).catchError((error) {
        print(value);

        emit(ErrorUpdatePost());
      });
    }).catchError((error) {});
  }

  PostModel postModel;
  void Createpost({
    @required String dataTime,
    String image,
    @required String text,
  }) async {
    emit(LoadingUpdatePost());
    postModel = PostModel(
      name: model.name,
      profileImage: model.image,
      dataTime: dataTime,
      postimage: image ?? '',
      text: text,
      uid: token,
    );
    await FirebaseFirestore.instance
        .collection('Posts')
        .add(postModel.toJson())
        .then((value) {
      emit(SuccessfulUpDatePost());
    }).catchError((error) {
      print(error.toString());
      emit(SuccessfulUpDatePost());
    });
  }

  void removePostImage() {
    PostImage = null;
    emit(RemovePostImage());
  }

  List<PostModel> post = [];
  List<String> postsId = [];
  List<int> likes = [];
  void getPost() {
    emit(LoadinGetPost());
    if (post.length == 0) {
      FirebaseFirestore.instance.collection('Posts').get().then((value) {
        value.docs.forEach((element) {
          element.reference.collection('likes').get().then((value) {
            likes.add(value.docs.length);
          }).catchError((error) {});
          postsId.add(element.id);
          post.add(PostModel.fromJson(element.data()));
        });
        emit(SuccessfulGetPost());
      }).catchError((error) {
        emit(ErrorGetPost());
      });
    }
  }

  void PostLike(String postId) {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('likes')
        .doc(token)
        .set({
      'like': true,
    }).then((value) {
      emit(SuccessfulLikePost());
    }).catchError((error) {
      emit(ErrorLikePost());
    });
  }

  List<RegisterModelUser> users = [];
  void getUsers() {
    emit(LoadinGetPost());
    if (users.length == 0) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uid'] != token) {
            users.add(RegisterModelUser.fromJson(element.data()));
          }
        });
        emit(SuccessfulGetPost());
      }).catchError((error) {
        emit(ErrorGetPost());
      });
    }
  }
}
