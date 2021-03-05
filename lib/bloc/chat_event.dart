part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class SendImageChat extends ChatEvent {
  final bool isGallery;
  final UserModel userModel;

  SendImageChat({this.isGallery, this.userModel});
}

class SendVideoChat extends ChatEvent {
  final bool isGallery;
  final UserModel userModel;

  SendVideoChat({this.isGallery, this.userModel});
}

class SendTextChat extends ChatEvent {
  final TextEditingController message;
  final UserModel userModel;

  SendTextChat({this.message, this.userModel});
}

class SendVoiceChat extends ChatEvent {
  final String url;
  final UserModel userModel;
  SendVoiceChat({this.url, this.userModel});
}

class SendLocationChat extends ChatEvent {
  final UserModel userModel;

  SendLocationChat({this.userModel});
}
