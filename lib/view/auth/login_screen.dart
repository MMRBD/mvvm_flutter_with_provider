import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../res/widgets/custom_button.dart';
import '../../utils/routes/routes_names.dart';
import '../../utils/utils.dart';
import 'auth_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ValueNotifier<bool> _obsecureNotifier = ValueNotifier<bool>(true);
  final TextEditingController _emailController =
      TextEditingController(text: "eve.holt@reqres.in");
  final TextEditingController _passwordController =
      TextEditingController(text: "cityslicka");

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Login"), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
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
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ValueListenableBuilder(
                  valueListenable: _obsecureNotifier,
                  builder: ((context, value, child) {
                    return TextFormField(
                      controller: _passwordController,
                      focusNode: _passwordFocus,
                      obscureText: _obsecureNotifier.value,
                      obscuringCharacter: "*",
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: InkWell(
                          onTap: () {
                            _obsecureNotifier.value = !_obsecureNotifier.value;
                          },
                          child: _obsecureNotifier.value
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        ),
                        label: const Text("Password"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 30),
                CustomButton(
                    title: "Login",
                    loading: authViewModel.loading,
                    onPress: () {
                      if (_emailController.text.isEmpty &&
                          _passwordController.text.isEmpty) {
                        Utils.flushBarErrorMessage(
                            "Email and password is empty!", context);
                      } else if (_passwordController.text.isEmpty) {
                        Utils.flushBarErrorMessage(
                            "Password is empty!", context);
                      } else if (_emailController.text.isEmpty) {
                        Utils.flushBarErrorMessage("Email empty!", context);
                      } else {
                        Map data = {
                          "email": _emailController.text.toString(),
                          "password": _passwordController.text.toString()
                        };
                        authViewModel.login(data, context);
                      }
                    }),
                const SizedBox(height: 30),
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.signupScreen);
                    },
                    child: const Text("Don't have an account yet? Sign Up!"))
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
