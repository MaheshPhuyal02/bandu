import 'package:bandu/ext/sizes_ext.dart';
import 'package:bandu/models/chat/message.dart';
import 'package:bandu/models/prompt/prompt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:response_parser/gpt_markdown.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/ColorsConst.dart';
import '../../constants/Options.dart';
import 'ai_chat_provider.dart';

class Ai_chatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildPage(context);
  }

  static final _formKey = GlobalKey<FormState>();

  Widget _buildPage(BuildContext context) {
    return Consumer<Ai_chatProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: EdgeInsets.all(11.sp),
          child: Column(
            children: [
              Expanded(
                child: _buildList(context, provider.messageList, provider),
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF3EFEF),
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                    width: 100.pW - 14.pW,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: PopupMenuButton<Prompt>(
                            padding: EdgeInsets.all(0),
                            icon: provider.selectedPrompt == null
                                ? SvgPicture.asset(
                                    "assets/icons/side_line.svg",
                                    width: 20.sp,
                                    height: 20.sp,
                                    color: Colors.black,
                                  )
                                : Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5.sp,
                                    ),
                                    margin: EdgeInsets.only(left: 8.sp.sp),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF7E9CDF),
                                    ),
                                    child: Text(
                                      provider.selectedPrompt == null?"":provider.selectedPrompt!.name,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ),
                            onSelected: (Prompt item) {
                              provider.setSelectedPrompt(item);

                            },
                            itemBuilder: (BuildContext context) {
                              return provider.prompts.map((Prompt choice) {
                                return PopupMenuItem<Prompt>(
                                  value: choice,
                                  child: Text(choice.name),
                                );
                              }).toList();
                            },
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(
                            maxHeight: 20.pH,
                          ),
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: provider.messageController,
                              maxLines: null,
                              enabled: provider.enableEditing,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              keyboardAppearance: Brightness.light,
                              autofocus: false,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                hintText: 'Enter prompt',
                                focusedBorder: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  5.horizontalSpace,
                  IconButton(
                    onPressed: () {
                      provider.sendMessage(context);
                    },
                    icon: SvgPicture.asset(
                      "assets/icons/send.svg",
                      width: 25.sp,
                      height: 25.sp,
                      color: ColorsConst.PRIMARY,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  _buildList(BuildContext context, List<Message> messageList, Ai_chatProvider prov) {
    return ListView.builder(
      itemCount: messageList.length,
      controller: prov.scrollController,
      itemBuilder: (context, index) {
        final message = messageList[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.bottomRight,
              child: Container(
                padding: EdgeInsets.all(10.sp),
                constraints: BoxConstraints(
                  maxWidth: 80.pW,
                ),
                decoration: BoxDecoration(
                  color: ColorsConst.PRIMARY,
                  borderRadius: BorderRadius.circular(10.sp),
                ),
                child: Text(message.request,
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            10.verticalSpace,
            message.loading!
                ? Shimmer(
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(10.sp),
                              constraints: BoxConstraints(
                                maxWidth: 80.pW,
                                minHeight: 10.pW,
                                maxHeight: 10.pW
                              ),
                              decoration: BoxDecoration(
                                color: ColorsConst.WHITE_SHADOW,
                                borderRadius: BorderRadius.circular(10.sp),
                              ),
                              child: TexMarkdown(
                                message.request!,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          10.verticalSpace,
                          Container(
                            width: double.infinity,
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(10.sp),
                              constraints: BoxConstraints(
                                maxWidth: 60.pW,
                                maxHeight: 10.pW,
                              ),
                              decoration: BoxDecoration(
                                color: ColorsConst.WHITE_SHADOW,
                                borderRadius: BorderRadius.circular(8.sp),
                              ),
                              child: TexMarkdown(
                                message.request!,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          10.verticalSpace,
                          Container(
                            width: double.infinity,
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(10.sp),
                              constraints: BoxConstraints(
                                maxWidth: 40.pW,
                                maxHeight: 7.pW,
                              ),
                              decoration: BoxDecoration(
                                color: ColorsConst.WHITE_SHADOW,
                                borderRadius: BorderRadius.circular(6.sp),
                              ),
                              child: TexMarkdown(
                                message.request!,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    gradient: ColorsConst.shimmerGradient,
                  )
                : Container(
                    width: double.infinity,
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: EdgeInsets.all(10.sp),
                      constraints: BoxConstraints(
                        maxWidth: 80.pW,
                      ),
                      decoration: BoxDecoration(
                        color: ColorsConst.WHITE_SHADOW,
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      child: TexMarkdown(
                        message.response!,

                        onLinkTab: (url, title) async {
                          if(await canLaunchUrl(Uri.parse(url))){
                            launchUrl(Uri.parse(url));
                          }
                        },
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
            10.verticalSpace
          ],
        );
      },
    );
  }
}
