import 'package:bandu/ext/sizes_ext.dart';
import 'package:bandu/models/chat/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:response_parser/gpt_markdown.dart';

import '../../constants/ColorsConst.dart';
import '../../constants/Options.dart';
import 'ai_chat_provider.dart';

class Ai_chatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => Ai_chatProvider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Consumer<Ai_chatProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: EdgeInsets.all(11.sp),
          child: Column(
            children: [
              Expanded(
                child: _buildList(context, provider.messageList),
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
                          child: PopupMenuButton<String>(
                            padding: EdgeInsets.all(0),
                            icon: provider.selectedPrompt.isEmpty
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
                                      provider.selectedPrompt.substring(1),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ),
                            onSelected: (String item) {
                              provider.setSelectedPrompt(item);
                            },
                            itemBuilder: (BuildContext context) {
                              return Options.promptOptions.map((String choice) {
                                return PopupMenuItem<String>(
                                  value: choice,
                                  child: Text(choice),
                                );
                              }).toList();
                            },
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(
                            maxHeight: 50.pH,
                          ),
                          child: TextFormField(
                            controller: provider.messageController,
                            maxLines: null,
                            style: TextStyle(
                              color: Colors.black,
                            ),

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
                      ],
                    ),
                  ),
                  5.horizontalSpace,
                  IconButton(
                    onPressed: () {
                      provider.sendMessage();
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

  _buildList(BuildContext context, List<Message> messageList) {
    return ListView.builder(
      itemCount: messageList.length,
      itemBuilder: (context, index) {
        final message = messageList[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            10.verticalSpace,
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
                child: Text(message.request, style: TextStyle(color: Colors.white)),
              ),
            ),
            10.verticalSpace,
            message.loading!
                ? Container(
                    child: CircularProgressIndicator(),
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
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
          ],
        );
      },
    );
  }
}
