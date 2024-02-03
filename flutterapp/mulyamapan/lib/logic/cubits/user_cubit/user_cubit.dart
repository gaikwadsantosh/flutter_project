import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mulyankan/data/models/user/user_model.dart';
import 'package:mulyankan/data/repositories/user_repository.dart';
import 'package:mulyankan/logic/cubits/user_cubit/user_state.dart';
import 'package:mulyankan/logic/services/preferences.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitialState()) {
    _initialize();
  }

  final UserRepository _userRepository = UserRepository();

  void _initialize() async {
    final userDetails = await Preferences.fetchUserDetails();
    String? email = userDetails["email"];
    String? password = userDetails["password"];
    if (email == null || password == null) {
      emit(UserLoggedOutState());
    } else {
      singIn(email: email, password: password);
    }
  }

  void _emitLoggedInState(
      {required UserModel userModel,
      required String email,
      required String password}) async {
    await Preferences.saveuserDetails(email, password);
    emit(UserLoggedInState(userModel));
  }

  void singIn({required String email, required String password}) async {
    //print("user cubit called");
    emit(UserLoadingState());
    try {
      UserModel userModel =
          await _userRepository.signIn(email: email, password: password);
      _emitLoggedInState(
          userModel: userModel, email: email, password: password);
    } catch (ex) {
      emit(UserErrorState(ex.toString()));
    }
  }

  void createAccount({required String email, required String password}) async {
    //print("user cubit called");
    emit(UserInitialState());
    try {
      UserModel userModel =
          await _userRepository.createAccount(email: email, password: password);
      _emitLoggedInState(
          userModel: userModel, email: email, password: password);
    } catch (ex) {
      emit(UserErrorState(ex.toString()));
    }
  }

  void saveProfile(UserModel userModel) async {
    print("user cubit : update profile called");
    //emit(UserInitialState());
    try {
      await _userRepository.saveProfile(userModel);
      emit(UserLoggedInState(userModel));
    } catch (ex) {
      emit(UserErrorState(ex.toString()));
    }
  }

  void googleSingIn(
      {required String email,
      required String? fullName,
      required String? phoneNumber}) async {
    //print("user cubit called : google sign in");
    emit(UserLoadingState());
    try {
      //check if email alreay exists, then skip else save profile.
      UserModel userModel;
      userModel = await _userRepository.signIn(email: email, password: "");
      if (userModel == null) {
        userModel = UserModel(
            email: email,
            password: "",
            fullName: fullName,
            phoneNumber: phoneNumber);
        saveProfile(userModel);
      }
      _emitLoggedInState(userModel: userModel, email: email, password: "");
    } catch (ex) {
      emit(UserErrorState(ex.toString()));
    }
  }

  void singOut() async {
    //print("signout: user cubit called");
    try {
      await Preferences.clear();
      emit(UserLoggedOutState());
    } catch (ex) {
      emit(UserErrorState(ex.toString()));
    }
  }
}
