part of 'screens.dart';

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  VideoPlayerController controller;
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(Get.arguments)
      ..initialize().then((_) {
        setState(() {});
      });
    controller.play();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZStack([
        Center(
          child: controller.value.initialized
              ? AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                )
              : CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(colors.bluePrimary),
                ).centered(),
        ),
        SafeArea(
          child: VxBox(
                  child: Icon(Icons.arrow_back_ios_rounded, color: Colors.white)
                      .p16())
              .withRounded(
                value: 10,
              )
              .color(Colors.white.withOpacity(.3))
              .make()
              .p16(),
        ),
        VxBox(
                child: Icon(
                        controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white)
                    .p16())
            .roundedFull
            .color(Colors.white.withOpacity(.3))
            .make()
            .objectCenter()
            .onTap(() {
          setState(() {
            controller.value.isPlaying ? controller.pause() : controller.play();
          });
        }).p16(),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            controller.value.isPlaying ? controller.pause() : controller.play();
          });
        },
        child: Icon(
          controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
