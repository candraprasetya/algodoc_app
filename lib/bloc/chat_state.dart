part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatErrorGettingImage extends ChatState {}

class ChatSended extends ChatState {
  final ChatModel chatModel;

  ChatSended(this.chatModel);

  @override
  List<Object> get props => [chatModel];
}
