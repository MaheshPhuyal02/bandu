import 'package:auto_route/annotations.dart';
import 'package:bandu/components/padding_scaffold.dart';
import 'package:bandu/ext/text_ext.dart';
import 'package:bandu/main.dart';
import 'package:bandu/routes/app_router.gr.dart';
import 'package:bandu/screens/forget_password/forget_password_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../components/primary_button.dart';

@RoutePage()
class ForgetPasswordPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ForgetPasswordProvider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    return PaddingScaffold(child: Consumer<ForgetPasswordProvider>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              40.verticalSpace,
              IconButton(
                  onPressed: () {
                    appRouter.maybePop();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 30.sp,
                  )),
              Text("Forget password",
                  style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
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

                          if (!value.isValidEmail()) {
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

                      PrimaryButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            provider.reset(context);
                          }
                        },
                        text: "Reset password",
                      ),
                    ],
                  )),
              30.verticalSpace,
            ],
          ),
        );
      },
    ));
  }
}
