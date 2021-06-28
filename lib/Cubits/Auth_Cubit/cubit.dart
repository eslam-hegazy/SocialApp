import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social/Cubits/Auth_Cubit/state.dart';
import 'package:social/models/RegisterModel.dart';

class cubit extends Cubit<state> {
  cubit() : super(InitialState());
  static cubit get(context) => BlocProvider.of(context);
  bool secure = true;
  IconData icon = Icons.visibility_off;
  void changesecure() {
    icon = secure ? Icons.visibility : Icons.visibility_off;
    secure = !secure;
    emit(changeVisabilty());
  }

  bool check = false;
  void changeBok() {
    check = !check;
    emit(changeVisabilty());
  }

  /////////////////////////////login User
  void LoginUser({@required String email, @required String password}) async {
    emit(LoadingLoginState());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(SuccessfulLoginState(value.user.uid));
      print(value.user.uid);
    }).catchError((error) {
      emit(ErrorLoginState(error.toString()));
      print(error.message.toString());
    });
  }

  RegisterModelUser model;
  void userCreate({
    @required String name,
    @required String phone,
    @required String email,
    @required String uid,
  }) async {
    emit(LoadingCreateUserState());
    model = RegisterModelUser(
      name: name,
      phone: phone,
      email: email,
      uid: uid,
      image:
          "https://image.freepik.com/free-photo/studio-shot-cheerful-religious-muslim-woman-keeps-arms-folded-smiles-broadly-has-white-teeth_273609-27065.jpg",
      cover:
          "https://image.freepik.com/free-photo/studio-shot-cheerful-religious-muslim-woman-keeps-arms-folded-smiles-broadly-has-white-teeth_273609-27065.jpg",
      bio: "bio............",
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(model.toJson())
        .then((value) {})
        .catchError((error) {
      print(error.toString());
      emit(ErrorCreateUserState(error.message.toString()));
    });
  }

  void RegisterUser({
    @required String name,
    @required String phone,
    @required String email,
    @required String password,
  }) async {
    emit(LoadingRegisterState());
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(
        name: name,
        phone: phone,
        email: email,
        uid: value.user.uid,
      );

      emit(SuccessfulCreateUserState(model));

      print(value.user.uid);
    }).catchError((error) {
      emit(ErrorCreateUserState(error.message.toString()));
      print(error.message);
    });
  }
}
