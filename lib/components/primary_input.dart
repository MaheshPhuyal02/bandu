
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/ColorsConst.dart';
import '../constants/SizesConst.dart';

class PrimaryInput extends StatefulWidget {
  final String hint;
  final VoidCallback onLastIconClick;
  final ValueChanged<String>? onChange;
  final String iconPath;
  final TextInputType type;
  final bool isPassword;
  final TextEditingController? controller;


  const PrimaryInput(
      {super.key,
      required this.hint,
      required this.onLastIconClick,
      required this.iconPath,
      required this.type,
      required this.isPassword,
        this.onChange,
        this.controller
      });

  @override
  State<StatefulWidget> createState() =>
      _PrimaryInputState(hint, onLastIconClick, iconPath, type);
}

class _PrimaryInputState extends State<PrimaryInput> {
  final String hint;
  final VoidCallback onLastIconClick;
  final String iconPath;
  String? lastIconPath = "assets/icons_general/eye_slash.svg";
  final TextInputType type;

  _PrimaryInputState(this.hint, this.onLastIconClick, this.iconPath,
       this.type);

  bool visiblePassword = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {



    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Text(
            hint,
            style: TextStyle(
              fontSize: 17,
              color: ColorsConst.WHITE,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          child: TextFormField(
            cursorColor: ColorsConst.PRIMARY,

            keyboardType: type,
            style: TextStyle(
              fontSize: 17,
              color: ColorsConst.WHITE,
            ),
            obscureText: !visiblePassword && widget.isPassword,
            onChanged: widget.onChange,
            controller: widget.controller,
            decoration: InputDecoration(
              fillColor: ColorsConst.TRANS_BACK,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(SizesConst.DEFAULT_RADIUS),
                borderSide:
                    const BorderSide(color: ColorsConst.PRIMARY, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(SizesConst.DEFAULT_RADIUS),
                borderSide:
                    const BorderSide(color: ColorsConst.TRANS_BACK, width: 1),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 50, vertical: 19),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  iconPath,
                  color: ColorsConst.WHITE,
                  height: 14,
                  width: 14,
                ),
              ),
              // if lastIconPath is null, then the suffixIcon will be null

              suffixIcon: widget.isPassword == true
                  ? GestureDetector(
                      onTap: (){
                        setState(() {
                          visiblePassword = !visiblePassword;
                        });
                        setState(() {
                          if(visiblePassword){
                            lastIconPath = "assets/icons_general/eye.svg";
                          } else {
                            lastIconPath = "assets/icons_general/eye_slash.svg";
                          }

                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          lastIconPath!,
                          color: ColorsConst.ICON_SECONDARY,
                          height: 14,
                          width: 14,
                        ),
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
