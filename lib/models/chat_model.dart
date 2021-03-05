class ChatModel {
  final int dateTime;
  final String message;
  final String imageUrl;
  final double locationLat;
  final double locationLong;
  final String videoUrl;
  final String voiceUrl;
  final String messageType;
  final String sender;

  ChatModel(
      {this.dateTime,
      this.message,
      this.sender,
      this.imageUrl,
      this.locationLat,
      this.locationLong,
      this.videoUrl,
      this.voiceUrl,
      this.messageType});
}
