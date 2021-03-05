import 'dart:io' as io;
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:path_provider/path_provider.dart';

import 'package:algodoc_app/bloc/blocs.dart';
import 'package:algodoc_app/bloc/chat_bloc.dart';
import 'package:algodoc_app/models/chat_model.dart';
import 'package:algodoc_app/models/models.dart';
import 'package:algodoc_app/services/services.dart';
import 'package:algodoc_app/widgets/widgets.dart';
import 'package:algodoc_app/utils/utils.dart';
import 'package:audio_recorder/audio_recorder.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

part 'chat_screen.dart';
part 'home_screen.dart';
part 'sign_in_screen.dart';
part 'sign_up_screen.dart';
part 'wrapper.dart';
part 'video_screen.dart';
part 'splash_screen.dart';
