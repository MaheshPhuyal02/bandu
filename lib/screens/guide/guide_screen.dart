import 'package:auto_route/annotations.dart';
import 'package:bandu/components/primary_button.dart';
import 'package:bandu/ext/sizes_ext.dart';
import 'package:bandu/main.dart';
import 'package:bandu/routes/app_router.gr.dart';
import 'package:bandu/services/SharedPref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';

@RoutePage()
class GuidePage extends StatefulWidget {
  const GuidePage({super.key});

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {

  @override
  Widget build(BuildContext context) {
    final bodyStyle = TextStyle(fontSize: 12.sp);

    final pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,
      infiniteAutoScroll: true,
      globalFooter: Container(
        margin: EdgeInsets.only(bottom: 20.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        width: double.infinity,
        child: PrimaryButton(
          onPressed: () => _onIntroEnd(context),
          text: "Get Started",

        ),
      ),
      pages: [
        PageViewModel(
          title: "“Stay organized,\nGet things Done!“",
          body:
          "Welcome to Task Gen AI, the ultimate tool to help you stay organized and achieve your goals with ease.",
          image: _buildImage('stay_org.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "“Plan, Track, Succed “",
          body:
          "Task Gen AI simplifies task management, allowing you to focus on what truly matters.",
          image: _buildImage('plan.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "\"Efficiently Manage, Successfully Achieve\"",
          body:
          "Whether you're planning your day, managing a project, or tracking personal goals, Task Gen AI is here to guide you every step of the way.",
          image: _buildImage('question.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip:  Text('Skip', style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor)),
      next: const Icon(Icons.arrow_forward),
      done: Text('Done', style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),

      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),

    );
  }

  void _onIntroEnd(context) {
    SharedPref.instance.setValue("showedGuide", true);
    appRouter.replace(LoginRoute());

  }
  _buildImage(String assetName) {
      return Image.asset('assets/illu/$assetName', width: 90.pW, height: 90.pW);

  }
}
