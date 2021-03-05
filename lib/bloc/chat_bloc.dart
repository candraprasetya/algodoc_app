import 'dart:async';
import 'dart:io';

import 'package:algodoc_app/models/chat_model.dart';
import 'package:algodoc_app/models/models.dart';
import 'package:algodoc_app/services/services.dart';
import 'package:algodoc_app/utils/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:location_platform_interface/location_platform_interface.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial());

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    if (event is SendImageChat) {
      String pickedImage = await getImage(event.isGallery);
      String url = await ChatService.uploadImage(File(pickedImage));
      if (url != null) {
        ChatModel chat = ChatModel(
            dateTime: DateTime.now().millisecondsSinceEpoch,
            imageUrl: url,
            sender: event.userModel.email,
            messageType: 'image');

        ChatService.sendMessage(chat);
        yield ChatSended(chat);
      } else {
        print('No image selected.');
        yield ChatErrorGettingImage();
      }
    } else if (event is SendTextChat) {
      ChatModel chat = ChatModel(
          dateTime: DateTime.now().millisecondsSinceEpoch,
          message: event.message.text,
          sender: event.userModel.email,
          messageType: 'text');
      ChatService.sendMessage(chat);
      event.message.clear();

      yield ChatSended(chat);
    } else if (event is SendLocationChat) {
      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }

      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return;
        }
      }
      locationData = await location.getLocation();

      ChatModel chat = ChatModel(
          dateTime: DateTime.now().millisecondsSinceEpoch,
          locationLat: locationData.latitude,
          locationLong: locationData.longitude,
          sender: event.userModel.email,
          messageType: 'location');
      ChatService.sendMessage(chat);
      yield ChatSended(chat);
    } else if (event is SendVideoChat) {
      String pickedImage = await getVideo(event.isGallery);
      String url = await ChatService.uploadImage(File(pickedImage));
      if (url != null) {
        ChatModel chat = ChatModel(
            dateTime: DateTime.now().millisecondsSinceEpoch,
            videoUrl: url,
            sender: event.userModel.email,
            messageType: 'video');

        ChatService.sendMessage(chat);
        yield ChatSended(chat);
      } else {
        print('No image selected.');
        yield ChatErrorGettingImage();
      }
    } else if (event is SendVoiceChat) {
      String url = await ChatService.uploadSound(event.url);
      if (url != null) {
        ChatModel chat = ChatModel(
            dateTime: DateTime.now().millisecondsSinceEpoch,
            voiceUrl: url,
            sender: event.userModel.email,
            messageType: 'voice');

        ChatService.sendMessage(chat);
        yield ChatSended(chat);
      } else {
        print('No image selected.');
        yield ChatErrorGettingImage();
      }
    }
  }
}
