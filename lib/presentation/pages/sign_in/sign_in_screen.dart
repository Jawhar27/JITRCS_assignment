import 'package:flutter/material.dart';
import 'package:jitrcs_assignment/config/constants.dart';
import 'package:jitrcs_assignment/config/routes.dart';
import 'package:jitrcs_assignment/presentation/layouts/main_layout.dart';
import 'package:jitrcs_assignment/presentation/widgets/common_button.dart';
import 'package:jitrcs_assignment/presentation/widgets/text_field_with_label.dart';
import 'package:jitrcs_assignment/utils/alert_util.dart';
import 'package:jitrcs_assignment/utils/log_util.dart';
import 'package:jitrcs_assignment/utils/navigation_util.dart';
import 'package:jitrcs_assignment/utils/validation_util.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _loading = false;
  bool isVisible = true;

  String userName = 'Jaw@gmail.com';
  String password = 'Jaw123!';
  @override
  Widget build(BuildContext context) {
    return MainLayout(
        loading: _loading,
        appBarText: 'Sign In',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _signInForm(),
            CommonButton(
              buttonText: 'Sign in',
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  setState(() {
                    _loading = true;
                  });
                  Future.delayed(
                      const Duration(
                        seconds: 3,
                      ), () {
                    printLogs(userName.toLowerCase());
                    printLogs(_userNameController.text.trim().toLowerCase());
                    if (_userNameController.text.trim().toLowerCase() ==
                            userName.toLowerCase() &&
                        _passwordController.text == password) {
                      moveToScreen(context, ScreenRoutes.toHomeScreen);
                    } else {
                      showFailedDialog(
                          context: context,
                          message: 'Invalid credentials!',
                          onPressed: () {
                            popScreen(context);
                          });
                    }
                    setState(() {
                      _loading = false;
                    });
                  });
                } else {
                  setState(() {
                    _autoValidate = true;
                  });
                }
              },
            ),
          ],
        ));
  }

  _signInForm() {
    return Form(
      key: _formKey,
      autovalidateMode: _autoValidate ? AutovalidateMode.always : null,
      child: Column(
        children: [
          LabelTextField(
            controller: _userNameController,
            hintText: 'Email',
            validator: (email) {
              if (email?.trim().isEmpty ?? true) {
                return 'Email is required!';
              }
              if (!isValidEmail(email)) {
                return 'Please enter valid Email Address!';
              }
              return null;
            },
          ),
          SizedBox(
            height: ScreenPadding.paddingHeight24,
          ),
          LabelTextField(
            hintText: 'Password',
            controller: _passwordController,
            isPasswordField: isVisible,
            suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                child: Icon(
                  isVisible ? Icons.visibility : Icons.visibility_off,
                )),
            validator: (password) {
              if (password?.trim().isEmpty ?? true) {
                return 'Password is required!';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
