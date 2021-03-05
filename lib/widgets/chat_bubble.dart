part of 'widgets.dart';

class ChatBubble extends StatefulWidget {
  final ChatModel chatModel;
  final bool me;

  const ChatBubble({Key key, this.chatModel, this.me}) : super(key: key);

  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  AudioPlayer audioPlayer = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    var date = DateTime.fromMillisecondsSinceEpoch(widget.chatModel.dateTime);
    var formattedDate = DateFormat.yMd().format(date); // Apr 8, 2020
    return VxBox(
            child: VStack(
      [
        widget.chatModel.sender.text.xs.make(),
        formattedDate.text.xs.gray600.make(),
        4.heightBox,
        VxBox(
                child: (widget.chatModel.messageType == 'image')
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: VxBox(
                          child: Image.network(
                            widget.chatModel.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ).size(120, 120).make(),
                      )
                    : (widget.chatModel.messageType == 'video')
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: VxBox(
                                child: Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white,
                            )).size(120, 120).make(),
                          ).onTap(() {
                            Get.toNamed('/video',
                                arguments: widget.chatModel.videoUrl);
                          })
                        : (widget.chatModel.messageType == 'location')
                            ? 'Location (click to get direction)'
                                .text
                                .color(
                                    (widget.me) ? Colors.white : Colors.black)
                                .make()
                                .pSymmetric(h: 20, v: 10)
                                .onTap(() async {
                                String googleMapslocationUrl =
                                    "https://www.google.com/maps/search/?api=1&query=${widget.chatModel.locationLat},${widget.chatModel.locationLong}";

                                final String encodedURl =
                                    Uri.encodeFull(googleMapslocationUrl);

                                if (await canLaunch(encodedURl)) {
                                  await launch(encodedURl);
                                } else {
                                  print('Could not launch $encodedURl');
                                  throw 'Could not launch $encodedURl';
                                }
                              })
                            : (widget.chatModel.messageType == 'voice')
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: VxBox(
                                        child: Icon(
                                      Icons.mic,
                                      color: Colors.white,
                                    )).size(120, 120).make(),
                                  ).onTap(() async {
                                    await audioPlayer
                                        .play(widget.chatModel.voiceUrl);
                                  })
                                : widget.chatModel.message.text
                                    .color((widget.me)
                                        ? Colors.white
                                        : Colors.black)
                                    .make()
                                    .pSymmetric(h: 20, v: 10))
            .color((widget.me) ? colors.bluePrimary : colors.greyNatural)
            .withShadow([
              BoxShadow(
                  blurRadius: 10,
                  offset: Offset(4, 4),
                  color: (widget.chatModel.messageType == 'text')
                      ? colors.bluePrimary.withOpacity(.2)
                      : colors.greyNatural)
            ])
            .rounded
            .make()
      ],
      crossAlignment:
          widget.me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    ).p16())
        .make()
        .wFull(context);
  }
}
