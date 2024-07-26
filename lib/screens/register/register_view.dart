import 'package:auto_route/annotations.dart';
import 'package:bandu/components/padding_scaffold.dart';
import 'package:bandu/main.dart';
import 'package:bandu/routes/app_router.gr.dart';
import 'package:bandu/screens/register/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../components/primary_button.dart';

@RoutePage()
class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => RegisterProvider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final provider = context.read<RegisterProvider>();

    return PaddingScaffold(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            40.verticalSpace,
            Text("Sign Up",
                style: TextStyle(fontSize: 34.sp, fontWeight: FontWeight.bold)),
            Text(
              "Create your account",
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            20.verticalSpace,
            Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Full name",
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    10.verticalSpace,
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter your email",
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    ),
                    10.verticalSpace,
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "Enter password",
                          prefixIcon: Icon(Icons.lock_outlined),
                          suffixIcon: Icon(Icons.visibility_off_outlined)),
                    ),
                    10.verticalSpace,
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "Confirm password",
                          prefixIcon: Icon(Icons.lock_outlined),
                          suffixIcon: Icon(Icons.visibility_off_outlined)),
                    ),

                    20.verticalSpace,
                    PrimaryButton(
                      onPressed: () {},
                      text: "Register",
                    ),
                  ],
                )),
            30.verticalSpace,
            Text("or continue with"),
            30.verticalSpace,
            Container(
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
            5.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    appRouter.maybePop();
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
