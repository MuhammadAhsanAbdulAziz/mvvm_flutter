import 'package:flutter/material.dart';
import 'package:mvvm_flutter/res/components/round_button.dart';
import 'package:mvvm_flutter/utils/utils.dart';
import 'package:mvvm_flutter/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode _emailFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _obscurePassword.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final authViewModel = Provider.of<AuthViewModel>(context);
    void _submit() {
      if (_emailController.text.isEmpty) {
        Utils.flushbarErrorMessage('Please enter Email', context);
        return;
      }
      if (_passwordController.text.isEmpty) {
        Utils.flushbarErrorMessage('Please enter Password', context);
        return;
      }
      if (_passwordController.text.length < 6) {
        Utils.flushbarErrorMessage(
            'Password should be greater than 6', context);
        return;
      }
      Map data = {
        'email': _emailController.text.trim(),
        'password': _passwordController.text.trim(),
      };
      authViewModel.loginApi(data, context);
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              focusNode: _emailFocus,
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                icon: Icon(
                  Icons.alternate_email,
                ),
              ),
              onFieldSubmitted: (val) {
                Utils.changeFocus(context, _emailFocus, _passwordFocus);
              },
            ),
            ValueListenableBuilder(
              valueListenable: _obscurePassword,
              builder: (context, value, child) {
                return TextFormField(
                  focusNode: _passwordFocus,
                  controller: _passwordController,
                  obscureText: value,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    icon: Icon(
                      Icons.lock,
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          _obscurePassword.value = !_obscurePassword.value;
                        },
                        icon: value
                            ? Icon(Icons.visibility_off_outlined)
                            : Icon(Icons.visibility_outlined)),
                  ),
                );
              },
            ),
            SizedBox(
              height: height * 0.1,
            ),
            RoundButton(
              title: 'Login',
              loading: authViewModel.loading,
              onPress: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
