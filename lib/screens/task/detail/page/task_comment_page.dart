import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';
import 'package:mobile_rhm/data/chat/theme.dart';
import 'package:mobile_rhm/data/model/response/task/chat_info.dart';

class TaskCommentPage extends StatelessWidget {
  final ChatInfo chatInfo;
  final Function? onAddComment;
  final Function? onUnSentMessage;
  final ChatController chatController;
  final ChatTheme theme = LightTheme();
  final bool isDarkTheme = false;

  TaskCommentPage({super.key, required this.chatInfo, this.onAddComment, this.onUnSentMessage, required this.chatController});

  void _onSendTap(
    String message,
    ReplyMessage replyMessage,
    MessageType messageType,
  ) {
    onAddComment?.call(message, replyMessage);
  }

  @override
  Widget build(BuildContext context) {
    Widget chatPage = Scaffold(
      body: ChatView(
        chatController: chatController,
        onSendTap: _onSendTap,
        featureActiveConfig: FeatureActiveConfig(
            lastSeenAgoBuilderVisibility: false,
            receiptsBuilderVisibility: false,
            enableCurrentUserProfileAvatar: false,
            enableDoubleTapToLike: false,
            enableReplySnackBar: onAddComment != null,
            enableOtherUserProfileAvatar: false,
            enableReactionPopup: false,
            enableSwipeToSeeTime: false,
            enableTextField: onAddComment != null),
        chatViewState: ChatViewState.hasMessages,
        chatViewStateConfig: ChatViewStateConfiguration(
          loadingWidgetConfig: ChatViewStateWidgetConfiguration(
            loadingIndicatorColor: theme.outgoingChatBubbleColor,
          ),
          onReloadButtonTap: () {},
        ),
        chatBackgroundConfig: ChatBackgroundConfiguration(
          messageTimeIconColor: theme.messageTimeIconColor,
          messageTimeTextStyle: TextStyle(color: theme.messageTimeTextColor),
          defaultGroupSeparatorConfig: DefaultGroupSeparatorConfiguration(
            textStyle: TextStyle(
              color: theme.chatHeaderColor,
              fontSize: 17,
            ),
          ),
          backgroundColor: theme.backgroundColor,
        ),
        chatBubbleConfig: ChatBubbleConfiguration(
          outgoingChatBubbleConfig: ChatBubble(
            linkPreviewConfig: LinkPreviewConfiguration(
              backgroundColor: theme.linkPreviewOutgoingChatColor,
              bodyStyle: theme.outgoingChatLinkBodyStyle,
              titleStyle: theme.outgoingChatLinkTitleStyle,
            ),
            receiptsWidgetConfig: const ReceiptsWidgetConfig(showReceiptsIn: ShowReceiptsIn.all),
            color: theme.outgoingChatBubbleColor,
          ),
          inComingChatBubbleConfig: ChatBubble(
            linkPreviewConfig: LinkPreviewConfiguration(
              linkStyle: TextStyle(
                color: theme.inComingChatBubbleTextColor,
                decoration: TextDecoration.underline,
              ),
              backgroundColor: theme.linkPreviewIncomingChatColor,
              bodyStyle: theme.incomingChatLinkBodyStyle,
              titleStyle: theme.incomingChatLinkTitleStyle,
            ),
            textStyle: TextStyle(color: theme.inComingChatBubbleTextColor),
            onMessageRead: (message) {},
            senderNameTextStyle: TextStyle(color: theme.inComingChatBubbleTextColor),
            color: theme.inComingChatBubbleColor,
          ),
        ),
        messageConfig: MessageConfiguration(
          messageReactionConfig: MessageReactionConfiguration(
            backgroundColor: theme.messageReactionBackGroundColor,
            borderColor: theme.messageReactionBackGroundColor,
          ),
        ),
        repliedMessageConfig: RepliedMessageConfiguration(
          backgroundColor: theme.repliedMessageColor,
          verticalBarColor: theme.verticalBarColor,
          repliedMsgAutoScrollConfig: RepliedMsgAutoScrollConfig(
            enableHighlightRepliedMsg: true,
            highlightColor: Colors.lightBlueAccent.shade100,
            highlightScale: 1.1,
          ),
          textStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.25,
          ),
          replyTitleTextStyle: TextStyle(color: theme.repliedTitleTextColor),
        ),
        sendMessageConfig: SendMessageConfiguration(
          allowRecordingVoice: false,
          enableCameraImagePicker: false,
          enableGalleryImagePicker: false,
          replyMessageColor: theme.replyMessageColor,
          defaultSendButtonColor: theme.sendButtonColor,
          replyDialogColor: theme.replyDialogColor,
          replyTitleColor: theme.replyTitleColor,
          textFieldBackgroundColor: theme.textFieldBackgroundColor,
          closeIconColor: theme.closeIconColor,
          textFieldConfig: TextFieldConfiguration(
            onMessageTyping: (status) {
              /// Do with status
              debugPrint(status.toString());
            },
            compositionThresholdTime: const Duration(seconds: 1),
            textStyle: TextStyle(color: theme.textFieldTextColor),
          ),
        ),
        replyPopupConfig: ReplyPopupConfiguration(
            backgroundColor: theme.replyPopupColor,
            buttonTextStyle: TextStyle(color: theme.replyPopupButtonColor),
            topBorderColor: theme.replyPopupTopBorderColor,
            onReplyTap: (message) {
              LogUtils.logE(message: 'OnClick onReplyTap');
            },
            onUnsendTap: (message) {
              LogUtils.logE(message: 'OnClick onUnsendTap');
              onUnSentMessage?.call(message);
            },
            onMoreTap: null),
      ),
    );

    return chatPage;
  }
}
