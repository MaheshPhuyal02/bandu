import 'package:auto_route/annotations.dart';
import 'package:bandu/components/padding_scaffold.dart';
import 'package:bandu/components/primary_button.dart';
import 'package:bandu/constants/ColorsConst.dart';
import 'package:bandu/ext/sizes_ext.dart';
import 'package:bandu/main.dart';
import 'package:bandu/routes/app_router.gr.dart';
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
    return PaddingScaffold(child: Consumer<Complete_profileProvider>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              10.verticalSpace,
              TextButton(
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 30.sp,
                  color: ColorsConst.BLACK,
                ),
                onPressed: () {
                  provider.exit(context);
                },
              ),
              20.verticalSpace,
              Text("Role",
                  style: TextStyle(fontSize: 34.sp, fontWeight: FontWeight.bold)),
              4.verticalSpace,
              Text(
                " Select your role",
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              30.verticalSpace,
              _buildItem(provider.selected == 0, "Freelancer", "I'm a freelancer",
                  () {
                provider.setSelected(0);
              }, "assets/illu/freelancer.svg", context),
              20.verticalSpace,
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text("OR",
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
              ),
              20.verticalSpace,
              _buildItem(provider.selected == 1, "Employee", "I work at office",
                  () {
                provider.setSelected(1);
              }, "assets/illu/office.svg", context),
              50.verticalSpace,
              PrimaryButton(
                  text: "Continue",
                  onPressed: () {
                    provider.submit();
                  }),
            ],
          ),
        );
      },
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
