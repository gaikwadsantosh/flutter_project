import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mulyankan/data/models/user/user_model.dart';
import 'package:mulyankan/logic/cubits/user_cubit/user_cubit.dart';
import 'package:mulyankan/logic/cubits/user_cubit/user_state.dart';

class ProfileProvider with ChangeNotifier {
  final BuildContext context;
  final formKey = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController moibileController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String _resultText = "";

  String get ResultText => _resultText;

  ProfileProvider(this.context) {
    _prefillUserStateData();
  }

  void _prefillUserStateData() {
    final UserState userState = BlocProvider.of<UserCubit>(context).state;
    if (userState is UserLoggedInState) {
      fullNameController.text = userState.userModel.fullName ?? '';
      addressController.text = userState.userModel.address ?? '';
      stateController.text = userState.userModel.state ?? '';
      cityController.text = userState.userModel.city ?? '';
      moibileController.text = userState.userModel.phoneNumber ?? '';
      emailController.text = userState.userModel.email ?? '';
    }
  }

  void saveProfile() async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }
      UserModel userModel = UserModel();
      userModel.email = emailController.text.trim();
      userModel.fullName = fullNameController.text.trim();
      userModel.address = addressController.text.trim();
      userModel.city = cityController.text.trim();
      userModel.state = stateController.text.trim();
      userModel.phoneNumber = moibileController.text.trim();
      BlocProvider.of<UserCubit>(context).saveProfile(userModel);
      _resultText = "Successfully updated profile !!";
      notifyListeners();
    } catch (e) {
      _resultText = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
