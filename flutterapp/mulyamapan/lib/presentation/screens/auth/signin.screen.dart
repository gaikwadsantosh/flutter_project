import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mulyankan/core/ui.dart';
import 'package:mulyankan/logic/cubits/user_cubit/user_cubit.dart';
import 'package:mulyankan/logic/cubits/user_cubit/user_state.dart';
import 'package:mulyankan/logic/services/preferences.dart';
import 'package:mulyankan/presentation/screens/auth/providers/login_provider.dart';
import 'package:mulyankan/presentation/screens/auth/signup.screen.dart';
import 'package:mulyankan/presentation/screens/home/home_screen.dart';
import 'package:mulyankan/presentation/screens/widgets/gap_widget.dart';
import 'package:mulyankan/presentation/screens/widgets/link_button.dart';
import 'package:mulyankan/presentation/screens/widgets/primary_button.dart';
import 'package:mulyankan/presentation/screens/widgets/primary_textfield.dart';
import 'package:provider/provider.dart';
//enable google signup
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String routeName = "login";

  @override
  State<SignInScreen> createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  @override
  void initState() {
    super.initState();

    Preferences.fetchUserDetails().then((value) {
      String email = value['email'] ?? "";
      String password = value['password'] ?? "";
      if (email != null || password != null) {
        if (email != "") {
          Future.delayed(Duration.zero, () {
            var loginProvider =
                Provider.of<LoginProvider>(context, listen: false);
            loginProvider.loginWithCredentials(email, password);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);

    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLoggedInState) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text("Mulyankan app"),
        ),
        body: SafeArea(
            child: Form(
          key: provider.formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const GapWidget(),
              PrimaryButton(
                onPressed: provider.googleLogin,
                iconData: FontAwesomeIcons.google,
                text: (provider.isLoading) ? "..." : " Continue with Google",
              ),
              const GapWidget(),
              const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Or"),
              ]),
              Text(
                "Sign in",
                style: TextStyles.heading3,
              ),
              const GapWidget(),
              (provider.error != "")
                  ? Text(
                      provider.error,
                      style: const TextStyle(color: Colors.red),
                    )
                  : const SizedBox(),
              const GapWidget(),
              PrimaryTextField(
                controller: provider.emailController,
                labelText: "Email Address",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "email address is requried";
                  }
                  if (!EmailValidator.validate(value.trim())) {
                    return "invalid email address";
                  }
                  return null;
                },
              ),
              const GapWidget(),
              PrimaryTextField(
                controller: provider.passwordController,
                labelText: "Password",
                obscureText: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "password is requried";
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LinkButton(
                    text: "forgot password?",
                    onPressed: () {},
                  ),
                ],
              ),
              const GapWidget(),
              PrimaryButton(
                onPressed: provider.login,
                text: (provider.isLoading) ? "..." : "Log in",
              ),
              const GapWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Dont have an account?",
                  ),
                  const GapWidget(),
                  LinkButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignupScreen.routeName);
                    },
                    text: "Sign up",
                  ),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
