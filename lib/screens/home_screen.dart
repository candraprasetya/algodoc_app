part of 'screens.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  Recording recording = new Recording();
  bool isRecording = false;
  Random random = new Random();
  TextEditingController controller = new TextEditingController();
  LocalFileSystem localFileSystem = LocalFileSystem();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          return Scaffold(
              body: SafeArea(
                  child: VStack(
            [
              userProfile(state.userModel),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: ChatService.chatCollection
                      .orderBy("dateTime", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return 'No Chat'.text.makeCentered();
                    }
                    if (snapshot.hasData) {
                      List<DocumentSnapshot> docs = snapshot.data.docs;
                      List<Widget> message = docs
                          .map((doc) => ChatBubble(
                                chatModel: ChatModel(
                                  dateTime: doc.data()['dateTime'],
                                  imageUrl: doc.data()['imageUrl'],
                                  message: doc.data()['message'],
                                  messageType: doc.data()['messageType'],
                                  locationLat: doc.data()['locationLat'],
                                  locationLong: doc.data()['locationLong'],
                                  videoUrl: doc.data()['videoUrl'],
                                  voiceUrl: doc.data()['voiceUrl'],
                                  sender: doc.data()['sender'],
                                ),
                                me: state.userModel.email ==
                                    doc.data()['sender'],
                              ))
                          .toList();
                      return ListView(
                        controller: scrollController,
                        reverse: true,
                        physics: BouncingScrollPhysics(),
                        children: [
                          ...message,
                        ],
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
              VxBox(
                  child: HStack([
                Icon(Icons.add).p12().onTap(() {
                  Get.bottomSheet(
                    VxBox(
                            child: HStack(
                      [
                        iconButton(
                            title: 'Image Gallery',
                            icon: Icons.photo,
                            function: () {
                              context.read<ChatBloc>().add(SendImageChat(
                                  userModel: state.userModel, isGallery: true));
                              Get.back();
                            }),
                        iconButton(
                            title: 'Image Camera',
                            icon: Icons.camera,
                            function: () {
                              context.read<ChatBloc>().add(SendImageChat(
                                  userModel: state.userModel,
                                  isGallery: false));
                              Get.back();
                            }),
                        iconButton(
                            title: 'Video Gallery',
                            icon: Icons.video_collection,
                            function: () {
                              context.read<ChatBloc>().add(SendVideoChat(
                                  userModel: state.userModel, isGallery: true));
                              Get.back();
                            }),
                        iconButton(
                            title: 'Video Camera',
                            icon: Icons.video_call_rounded,
                            function: () {
                              context.read<ChatBloc>().add(SendVideoChat(
                                  userModel: state.userModel,
                                  isGallery: false));
                              Get.back();
                            }),
                        iconButton(
                            title: 'Location',
                            icon: Icons.map,
                            function: () {
                              context.read<ChatBloc>().add(
                                  SendLocationChat(userModel: state.userModel));
                              Get.back();
                            }),
                      ],
                      alignment: MainAxisAlignment.spaceBetween,
                    ).pSymmetric(h: 16, v: 16).scrollHorizontal(
                                physics: BouncingScrollPhysics()))
                        .white
                        .make()
                        .wFull(context),
                  );
                }),
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Enter a message'),
                    onSubmitted: (value) => {
                      context.read<ChatBloc>().add(SendTextChat(
                          message: messageController,
                          userModel: state.userModel))
                    },
                  ),
                ),
                (isRecording)
                    ? Icon(
                        Icons.stop_circle,
                      ).onTap(() {
                        setState(() {
                          isRecording = !isRecording;
                          _stop(state.userModel);
                        });
                      })
                    : Icon(
                        Icons.keyboard_voice,
                      ).onTap(() {
                        setState(() {
                          isRecording = !isRecording;
                          _start();
                        });
                      }),
                sendButton(
                    text: 'Send',
                    callback: () {
                      scrollController.animateTo(
                          scrollController.position.maxScrollExtent,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 300));
                      context.read<ChatBloc>().add(SendTextChat(
                          message: messageController,
                          userModel: state.userModel));
                    })
              ])).make()
            ],
          ).whFull(context)));
        }
        return CircularProgressIndicator().centered();
      },
    );
  }

  Widget iconButton(
      {String title, IconData icon, Function function, Color color}) {
    return VStack(
      [
        Icon(
          icon,
          color: color ?? Vx.gray700,
          size: context.percentHeight * 4,
        ),
        4.heightBox,
        title.text.center.xs.make()
      ],
      crossAlignment: CrossAxisAlignment.center,
    ).onTap(function).p16();
  }

  Widget sendButton({String text, VoidCallback callback}) {
    return ElevatedButton(
      style:
          ElevatedButton.styleFrom(elevation: 0.0, primary: Colors.transparent),
      child: HStack([
        text.text.blue500.make(),
        10.widthBox,
        Icon(
          Icons.send_rounded,
          color: Vx.blue500,
        )
      ]),
      onPressed: callback,
    );
  }

  Widget userProfile(UserModel userModel) {
    return VxBox(
      child: HStack(
        [
          HStack(
            [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  userModel.photoUrl,
                  scale: 2,
                ),
              ),
              10.widthBox,
              VStack([
                userModel.username.text.xl2.bold.make(),
                userModel.email.text.xs.make(),
              ]),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0.0,
                primary: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                )),
            child: 'SignOut'.text.white.make(),
            onPressed: () {
              context.read<UserBloc>().add(SignOutUser());
            },
          )
        ],
        alignment: MainAxisAlignment.spaceBetween,
      ).p16(),
    )
        .color(Colors.white)
        .withShadow([
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
          )
        ])
        .make()
        .wFull(context);
  }

  _start() async {
    try {
      if (await AudioRecorder.hasPermissions) {
        if (controller.text != null && controller.text != "") {
          String path = controller.text;
          if (!controller.text.contains('/')) {
            io.Directory appDocDirectory =
                await getApplicationDocumentsDirectory();
            path = appDocDirectory.path + '/' + controller.text;
          }
          print("Start recording: $path");
          await AudioRecorder.start(
              path: path, audioOutputFormat: AudioOutputFormat.AAC);
        } else {
          await AudioRecorder.start();
        }
        bool isRecording = await AudioRecorder.isRecording;
        setState(() {
          recording = new Recording(duration: new Duration(), path: "");
          isRecording = isRecording;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            new SnackBar(content: new Text("You must accept permissions")));
      }
    } catch (e) {
      print(e);
    }
  }

  _stop<String>(UserModel userModel) async {
    var recording = await AudioRecorder.stop();
    print("Stop recording: ${recording.path}");
    bool isRecording = await AudioRecorder.isRecording;
    File file = localFileSystem.file(recording.path);
    print("  File length: ${await file.length()}");
    setState(() {
      recording = recording;
      isRecording = isRecording;
    });
    controller.text = recording.path;
    context
        .read<ChatBloc>()
        .add(SendVoiceChat(userModel: userModel, url: recording.path));
    return recording.path;
  }
}
