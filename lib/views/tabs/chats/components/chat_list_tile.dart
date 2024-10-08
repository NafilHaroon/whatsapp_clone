import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:whatsapp_clone/pods.dart';
import 'package:whatsapp_clone/res/colors.dart';
import 'package:whatsapp_clone/res/extensions.dart';
import 'package:whatsapp_clone/models/chat_model/chat_model.dart';
import 'package:whatsapp_clone/views/components/custom_tile.dart';

class ChatListTile extends CustomTile<ChatModel> {
  const ChatListTile({
    Key? key,
    required this.user,
    VoidCallback? onTap,
    VoidCallback? onLongTap,
  }) : super(key: key, model: user, onLongTap: onLongTap, onTap: onTap);

  final ChatModel user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      onLongPress: onLongTap,
      leading: Stack(
        children: [
          CircleAvatar(child: Image.asset(user.profileImage)),
          Consumer(
            child: Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: kPrimaryColor,
                ),
                child: const Icon(Icons.done, size: 15, color: kWhiteColor),
              ),
            ),
            builder: (context, ref, child) {
              return ref
                      .watch(chatTabItemController)
                      .selectedItems
                      .contains(user)
                  ? child!
                  : const SizedBox();
            },
          ),
        ],
      ),
      title: Text(user.senderName, maxLines: 1),
      subtitle: Text(
        user.senderName + ': ' + user.msg,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: SizedBox(
        width: 80, // Set an appropriate width to avoid overflow
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              user.time,
              style: context.style.titleMedium?.copyWith(
                color: kLightDarkGrey,
                fontSize: 12,
              ),
            ),
            user.isRead ? const UnReadMsgCountWidget() : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class UnReadMsgCountWidget extends StatelessWidget {
  const UnReadMsgCountWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      margin: const EdgeInsets.only(right: 4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.secondaryColor,
      ),
      child: Text(
        "25",
        style: context.style.bodyMedium?.copyWith(
          color: kWhiteColor,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
