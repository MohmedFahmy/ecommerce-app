import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_api/core/styles/text_style.dart';
import 'package:get_api/core/widget/text_filed_custom_widget.dart';
import 'package:get_api/features/auth/cubit/auth_cubit.dart';
import 'package:get_api/features/auth/cubit/auth_state.dart';
import 'package:get_api/features/auth/view/screen/register_screen.dart';
import 'package:get_api/features/home/view/screens/home.dart';

import '../../../../core/validator/validator.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[200],
          title: Text('Login'),
          centerTitle: true,
        ),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              final response = state.userData;
              final userData = jsonDecode(response.toString());
              if (userData['status'] == 'error') {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(userData['message'])));
              }
              if (userData['status'] == 'success') {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(userData['message'])));
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Home()));
              }
            }
          },
          builder: (context, state) {
            return Center(
                child: Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[300],
              ),
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  CustomTextField(
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      validator: (value) {
                        return MyValidators.emailValidator(value);
                      },
                      label: 'Email',
                      hintText: 'Enter email address'),
                  CustomTextField(
                      controller: passwordController,
                      textInputType: TextInputType.emailAddress,
                      validator: (value) {
                        return MyValidators.passwordValidator(value);
                      },
                      label: 'Password',
                      hintText: 'Enter password'),
                  SizedBox(height: 20),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[200],
                      ),
                      onPressed: () {
                        AuthCubit.get(context).loginCubit(
                            email: emailController.text,
                            password: passwordController.text);
                      },
                      child: Text(
                        'Login',
                        style: mySecondStyle,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
                      },
                      child: Text(
                        'i dont have an acount',
                        style: myStyle.copyWith(color: Colors.blue),
                      ))
                ],
              ),
            ));
          },
        ),
      ),
    );
  }
}
