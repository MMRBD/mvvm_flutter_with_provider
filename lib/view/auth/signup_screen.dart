import "package:flutter/material.dart";
import 'package:mvvm_provider_flutter/res/widgets/custom_button.dart';
import "package:provider/provider.dart";
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/routes/routes_names.dart';
import '../../utils/utils.dart';
import 'auth_view_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final ValueNotifier<bool> _obSecureNotifier = ValueNotifier<bool>(false);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(
          title: const Text("Sign up"),
          centerTitle: true,
          automaticallyImplyLeading: false),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: 200,
                    width: 200,
                    child: SvgPicture.asset("assets/images/ic_login.svg")),
                TextFormField(
                  controller: _emailController,
                  focusNode: _emailFocus,
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (value) {
                    Utils.changeNodeFocus(context,
                        current: _emailFocus, next: _passwordFocus);
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    label: const Text("Email"),
                    hintText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ValueListenableBuilder(
                  valueListenable: _obSecureNotifier,
                  builder: ((context, value, child) {
                    return TextFormField(
                      controller: _passwordController,
                      focusNode: _passwordFocus,
                      obscureText: _obSecureNotifier.value,
                      obscuringCharacter: "*",
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: InkWell(
                          onTap: () {
                            _obSecureNotifier.value = !_obSecureNotifier.value;
                          },
                          child: _obSecureNotifier.value
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        ),
                        label: const Text("Password"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 30),
                CustomButton(
                    title: "Sign Up",
                    loading: authViewModel.signupLoading,
                    onPress: () {
                      _passwordFocus.unfocus();

                      if (_emailController.text.isEmpty &&
                          _passwordController.text.isEmpty) {
                        Utils.flushBarErrorMessage(
                            "email aur password de bhai", context);
                      } else if (_passwordController.text.isEmpty) {
                        Utils.flushBarErrorMessage(
                            "Password is empty!", context);
                      } else if (_emailController.text.isEmpty) {
                        Utils.flushBarErrorMessage("Email is empty!", context);
                      } else {
                        Map data = {
                          "email": _emailController.text.toString(),
                          "password": _passwordController.text.toString()
                        };

                        authViewModel.apiSignUp(data, context);
                      }
                    }),
                const SizedBox(height: 30),
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.login);
                    },
                    child: const Text("Already have an account? Login!"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _emailFocus.dispose();
    _passwordController.dispose();
    _passwordFocus.dispose();
  }
}
