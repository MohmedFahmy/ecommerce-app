import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_api/core/styles/text_style.dart';
import 'package:get_api/core/widget/text_filed_custom_widget.dart';
import 'package:get_api/features/auth/cubit/auth_cubit.dart';
import 'package:get_api/features/auth/cubit/auth_state.dart';
import 'package:get_api/features/auth/view/screen/login_screen.dart';

import '../../../../core/validator/validator.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[200],
          centerTitle: true,
          title: Text('Registeration'),
        ),
        body: SingleChildScrollView(
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) async {
              if (state is AuthSuccess) {
                final response = state.userData;
                final userData = jsonDecode(response.toString());
                if (userData['status'] == 'error') {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(userData['message'])));
                }
                if (userData['status'] == 'success') {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(userData['message'])));
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  SizedBox(height: 20),
                  context.read<AuthCubit>().image != null
                      ? CircleAvatar(
                          radius: 100,
                          backgroundImage:
                              FileImage(context.read<AuthCubit>().image!),
                        )
                      : TextButton.icon(
                          label: Text('Please Upload Image'),
                          onPressed: () {
                            context
                                .read<AuthCubit>()
                                .saveImage(context: context);
                          },
                          icon: Icon(Icons.camera),
                        ),
                  SizedBox(height: 20),
                  CustomTextField(
                      controller: nameController,
                      textInputType: TextInputType.text,
                      validator: (value) {
                        return MyValidators.displayNameValidator(value);
                      },
                      label: 'Name',
                      hintText: 'Enter your Name'),
                  CustomTextField(
                      controller: emailController,
                      textInputType: TextInputType.text,
                      validator: (value) {
                        return MyValidators.emailValidator(value);
                      },
                      label: 'Email',
                      hintText: 'Enter your Email'),
                  CustomTextField(
                      controller: phoneController,
                      textInputType: TextInputType.text,
                      validator: (value) {
                        return MyValidators.phoneValidator(value);
                      },
                      label: 'Phone',
                      hintText: 'Enter your Phone '),
                  CustomTextField(
                      controller: passwordController,
                      textInputType: TextInputType.text,
                      validator: (value) {
                        return MyValidators.passwordValidator(value);
                      },
                      label: 'Password',
                      hintText: 'Enter your Password'),
                  CustomTextField(
                      controller: genderController,
                      textInputType: TextInputType.text,
                      validator: (value) {
                        return MyValidators.genderValidator(value: value);
                      },
                      label: 'Gender',
                      hintText: 'Enter your Gender'),
                  CustomTextField(
                      controller: nationalityController,
                      textInputType: TextInputType.text,
                      validator: (value) {
                        return MyValidators.nationalIdValidator(value);
                      },
                      label: 'Nationality Id',
                      hintText: 'Enter your Nationality Id'),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[200],
                      ),
                      label: Text(
                        'Register',
                        style: mySecondStyle.copyWith(color: Colors.black),
                      ),
                      onPressed: () {
                        context.read<AuthCubit>().registerCubit(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            nationalId: nationalityController.text,
                            gender: genderController.text,
                            password: passwordController.text,
                            context: context);
                      },
                      icon: Icon(
                        Icons.login,
                        color: Colors.black,
                      )),
                  SizedBox(height: 20),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Text(
                        'i have an acount',
                        style: myStyle.copyWith(color: Colors.blue),
                      ))
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
