import 'package:bloc/bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/Cubits/onBoardingCubit/state.dart';
import 'package:social/models/onBoardingModel.dart';

class cubit extends Cubit<state> {
  cubit() : super(InitialState());
  static cubit get(context) => BlocProvider.of(context);
  List<onBoardingModel> board = [
    onBoardingModel(
        image: "images/63570-expenses-calculation.json",
        title: "OnBoarding 1 Title",
        description: "On Board 1 Description"),
    onBoardingModel(
        image: "images/64150-express-courier-delivery.json",
        title: "OnBoarding 2 Title",
        description: "On Board 2 Description"),
    onBoardingModel(
        image: "images/50124-user-profile.json",
        title: "OnBoarding 3 Title",
        description: "On Board 3 Description"),
  ];
  bool end = false;
  void changeindex(bool index) {
    end = index;
  }
}
