import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mulyankan/core/ui.dart';
import 'package:mulyankan/presentation/screens/auth/providers/signup_provider.dart';
import 'package:mulyankan/presentation/screens/auth/signin.screen.dart';
import 'package:mulyankan/presentation/screens/widgets/gap_widget.dart';
import 'package:mulyankan/presentation/screens/widgets/link_button.dart';
import 'package:mulyankan/presentation/screens/widgets/primary_button.dart';
import 'package:mulyankan/presentation/screens/widgets/primary_textfield.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  static const String routeName = 'signup';

  @override
  State<SignupScreen> createState() => _signupScreenState();
}

class _signupScreenState extends State<SignupScreen> {
  Widget build(BuildContext context) {
    final provider = Provider.of<SignupProvider>(context);
    return Scaffold(
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
            Text(
              "Create Account",
              style: TextStyles.heading2,
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
            const GapWidget(),
            PrimaryTextField(
              controller: provider.cPasswordController,
              labelText: "Confirm Password",
              obscureText: true,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Confirm your password";
                }
                if (value.trim() != provider.passwordController.text.trim()) {
                  return "Passwords do not match";
                }
                return null;
              },
            ),
            const GapWidget(),
            PrimaryButton(
              onPressed: provider.createAccount,
              text: (provider.isLoading) ? "..." : "Create Account",
            ),
            const GapWidget(),
            Row(
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(fontSize: 16),
                ),
                const GapWidget(),
                LinkButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SignInScreen.routeName);
                  },
                  text: "Log in",
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
