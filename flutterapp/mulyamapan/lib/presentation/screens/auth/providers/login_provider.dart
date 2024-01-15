import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mulyankan/logic/cubits/user_cubit/user_cubit.dart';
import 'package:mulyankan/logic/cubits/user_cubit/user_state.dart';

class LoginProvider with ChangeNotifier {
  final BuildContext context;

  LoginProvider(this.context) {
    print("login provider called");
    _listenToUserCubit();
  }

  bool isLoading = false;
  String error = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  StreamSubscription? _userSubscription;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void _listenToUserCubit() {
    //print("listening to userstate");

    _userSubscription =
        BlocProvider.of<UserCubit>(context).stream.listen((userState) {
      if (userState is UserLoadingState) {
        isLoading = true;
        error = "";
        notifyListeners();
      } else if (userState is UserErrorState) {
        isLoading = false;
        error = userState.message;
        notifyListeners();
      } else {
        isLoading = false;
        error = "";
        notifyListeners();
      }
    });
  }

  void login() async {
    //print("login provider called");
    if (!formKey.currentState!.validate()) return;
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    BlocProvider.of<UserCubit>(context)
        .singIn(email: email, password: password);
  }

  void loginWithCredentials(String email, String password) async {
    BlocProvider.of<UserCubit>(context)
        .singIn(email: email, password: password);
  }

  void logout() async {
    //print("logout provider called");
    BlocProvider.of<UserCubit>(context).singOut();
  }

  void googleLogin() async {
    //print("Google login provider called");

    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(authCredential);

        final _email = userCredential?.user?.email;
        final _fullName = userCredential?.user?.displayName;
        final _phoneNumber = userCredential?.user?.phoneNumber;

        if (_email == null) return;
        BlocProvider.of<UserCubit>(context).googleSingIn(
            email: _email, fullName: _fullName, phoneNumber: _phoneNumber);
      }
    } catch (ex) {
      throw ex;
    }
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }
}
