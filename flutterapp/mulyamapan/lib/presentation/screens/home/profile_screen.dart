import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mulyankan/logic/cubits/user_cubit/user_cubit.dart';
import 'package:mulyankan/logic/cubits/user_cubit/user_state.dart';
import 'package:mulyankan/presentation/screens/home/providers/profile_provider.dart';
import 'package:mulyankan/presentation/screens/widgets/gap_widget.dart';
import 'package:mulyankan/presentation/screens/widgets/primary_button.dart';
import 'package:mulyankan/presentation/screens/widgets/primary_textfield.dart';
import 'package:mulyankan/presentation/screens/widgets/searchbox_widget.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = "profile";
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context);
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {},
      child: Scaffold(
        appBar: AppBar(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
              Expanded(
                child: SearchBoxWidget(
                  hintText: "Search Products ...",
                  showDrawer: false,
                ),
              ),
            ])),
        body: SafeArea(
          child: Form(
              key: provider.formKey,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const GapWidget(),
                      const Text(
                        "Your Profile ",
                        style: TextStyle(fontSize: 25),
                      ),
                      const GapWidget(),
                      PrimaryTextField(
                          labelText: "Full Name",
                          controller: provider.fullNameController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "please enter full name";
                            }
                            return null;
                          }),
                      const GapWidget(),
                      //Address
                      PrimaryTextField(
                        labelText: "Address",
                        controller: provider.addressController,
                      ),
                      const GapWidget(),
                      //State
                      PrimaryTextField(
                        labelText: "State",
                        controller: provider.stateController,
                      ),
                      const GapWidget(),
                      //City
                      PrimaryTextField(
                        labelText: "City",
                        controller: provider.cityController,
                      ),
                      const GapWidget(),
                      //Mobile
                      PrimaryTextField(
                        labelText: "Mobile",
                        controller: provider.moibileController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "please enter contact number";
                          }
                          RegExp regExp = RegExp(r'^[0-9]{10}$');
                          if (!regExp.hasMatch(value ?? '')) {
                            return "please enter valid mobile number";
                          }
                          return null;
                        },
                      ),
                      const GapWidget(),
                      //Email
                      PrimaryTextField(
                        labelText: "email",
                        controller: provider.emailController,
                        enabledText: false,
                      ),
                      const GapWidget(),
                      // Buttons
                      PrimaryButton(
                        onPressed: provider.saveProfile,
                        text: ' Save',
                        iconData: FontAwesomeIcons.floppyDisk,
                      ),
                      const GapWidget(),
                      Text(
                        provider.ResultText,
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              )
              //FullName
              ),
        ),
      ),
    );
  }
}
