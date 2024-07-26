import 'package:auto_route/annotations.dart';
import 'package:bandu/components/padding_scaffold.dart';
import 'package:bandu/ext/text_ext.dart';
import 'package:bandu/main.dart';
import 'package:bandu/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../components/primary_button.dart';
import 'login_provider.dart';

@RoutePage()
class LoginPage extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => LoginProvider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    return PaddingScaffold(child: Consumer<LoginProvider>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              40.verticalSpace,
              Text("Welcome Back",
                  style: TextStyle(fontSize: 34.sp, fontWeight: FontWeight.bold)),
              Text(
                "Login to your account",
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              20.verticalSpace,
              Form(
                  key: _formKey,
                  child: Column(
                children: [
                  TextFormField(

                    onChanged: (value) {
                      provider.email = value;
                    },

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      }

                      if(!value.isValidEmail()){
                        return "Please enter a valid email";
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter your email",
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                  ),
                  10.verticalSpace,
                  TextFormField(
                    onChanged: (value) {
                      provider.password = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      if(value.length < 6){
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                    obscureText: !provider.showPassword,
                    decoration: InputDecoration(
                        hintText: "Enter your password",
                        prefixIcon: Icon(Icons.lock_outlined),
                        suffixIcon: TextButton(
                            onPressed: () {
                              provider.toggleShowPassword();
                            },
                            child: Icon(
                              provider.showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ))),
                  ),
                  10.verticalSpace,
                  Container(
                    width: double.infinity,
                    alignment: Alignment.topRight,
                    child: Text(
                      "Forgot Password?",
                    ),
                  ),
                  20.verticalSpace,
                  PrimaryButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        provider.login(context);
                      }
                    },
                    text: "Login",
                  ),
                ],
              )),
              30.verticalSpace,
              Container(
                  alignment: Alignment.center, child: Text("or continue with")),
              30.verticalSpace,
              InkWell(
                onTap: () {
                  provider.loginWithGoogle(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Theme.of(context).primaryColor,
                        style: BorderStyle.solid,
                        width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/google.svg",
                        width: 20.w,
                        height: 20.w,
                      ),
                      12.horizontalSpace,
                      Text(
                        "Continue with Google",
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              5.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      appRouter.push(RegisterRoute());
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ));
  }
}
