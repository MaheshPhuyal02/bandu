import 'package:auto_route/annotations.dart';
import 'package:bandu/components/padding_scaffold.dart';
import 'package:bandu/components/primary_button.dart';
import 'package:bandu/constants/ColorsConst.dart';
import 'package:bandu/ext/sizes_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'complete_profile_provider.dart';

@RoutePage()
class Complete_profilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => Complete_profileProvider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final provider = context.read<Complete_profileProvider>();

    return PaddingScaffold(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        30.verticalSpace,
        Text("Role",
            style: TextStyle(fontSize: 34.sp, fontWeight: FontWeight.bold)),
        4.verticalSpace,
        Text(
          " Select your role",
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.labelSmall,
        ),
        30.verticalSpace,
        _buildItem(false, "Freelancer", "I'm a freelancer", () {},
            "assets/illu/freelancer.svg", context),
        20.verticalSpace,
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: Text("OR",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
        ),
        20.verticalSpace,
        _buildItem(false, "Employee", "I'm work at office", () {},
            "assets/illu/office.svg", context),
        1.flex,
        PrimaryButton(text: "Continue", onPressed: () {}),
      ],
    ));
  }

  _buildItem(bool selected, String title, String des, Function onTap,
      String svg, BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          color: ColorsConst.WHITE_SHADOW,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? ColorsConst.PRIMARY : ColorsConst.WHITE_SHADOW,
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              svg,
              width: 70.w,
              height: 70.h,
            ),
            20.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 20.sp, fontWeight: FontWeight.bold)),
                4.verticalSpace,
                Text(
                  des,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
