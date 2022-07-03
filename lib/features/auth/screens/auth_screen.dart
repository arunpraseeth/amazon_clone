import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/utils/custom_text.dart';
import 'package:flutter/material.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final signupFormKey = GlobalKey<FormState>();
  final signinFormKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundColor,
      body: SafeArea(
        child: InkWell(
          splashFactory: NoSplash.splashFactory,
          onTap: () {
            nameFocus.unfocus();
            emailFocus.unfocus();
            passwordFocus.unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                RadioListTile(
                  value: Auth.signup,
                  groupValue: _auth,
                  activeColor: GlobalVariables.secondaryColor,
                  onChanged: (Auth? value) {
                    setState(() {
                      _auth = value!;
                    });
                  },
                  title: const Text("Create Account"),
                ),
                if (_auth == Auth.signup)
                  Form(
                    key: signupFormKey,
                    child: Column(
                      children: [
                        CustomTextField.customTextField(
                          size: size,
                          controller: name,
                          hintText: "Name",
                          focusnode: nameFocus,
                          textInputType: TextInputType.name,
                        ),
                        const SizedBox(height: 10),
                        CustomTextField.customTextField(
                          size: size,
                          controller: email,
                          hintText: "Email",
                          focusnode: emailFocus,
                          textInputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 10),
                        CustomTextField.customTextField(
                          size: size,
                          controller: password,
                          hintText: "Password",
                          focusnode: passwordFocus,
                          textInputType: TextInputType.emailAddress,
                        ),
                      ],
                    ),
                  ),
                RadioListTile(
                  value: Auth.signin,
                  activeColor: GlobalVariables.secondaryColor,
                  groupValue: _auth,
                  onChanged: (Auth? value) {
                    setState(() {
                      _auth = value!;
                    });
                  },
                  title: const Text("Sign In"),
                ),
                if (_auth == Auth.signin)
                  Form(
                    key: signupFormKey,
                    child: Column(
                      children: [
                        CustomTextField.customTextField(
                          size: size,
                          controller: email,
                          hintText: "Email",
                          textInputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 10),
                        CustomTextField.customTextField(
                          size: size,
                          controller: password,
                          hintText: "Password",
                          textInputType: TextInputType.emailAddress,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
