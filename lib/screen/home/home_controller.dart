import 'dart:developer';
import 'dart:io';
import 'package:call_log/call_log.dart';
import 'package:direct_dialer/direct_dialer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';

abstract class HomeState {}

class HomeInit extends HomeState {}
class CallTextChanged extends HomeState {}

class CallLogUpdated extends HomeState {
  final CallLogEntry? callLog;
  final String? recordingPath;

  CallLogUpdated(this.callLog, {this.recordingPath});
}

class HomeController extends Cubit<HomeState> {
  final TextEditingController mobile = TextEditingController();

  HomeController() : super(HomeInit());
  FlutterSoundPlayer player = FlutterSoundPlayer();

  void onChanged(String value) {
    emit(CallTextChanged());
  }

  Future<void> dial() async {
    final dialer = await DirectDialer.instance;
    await dialer.dial(mobile.text);

    log('Dialed $mobile. Waiting for call to end...');

    await Future.delayed(const Duration(seconds: 5));

    await updateCallLogAndRecording(mobile.text);
  }

  Future<void> updateCallLogAndRecording(String mobile) async {
    Iterable<CallLogEntry> entries = await CallLog.get();

    CallLogEntry? latestCall = entries.firstWhere(
          (entry) => entry.number == mobile,
      orElse: () => CallLogEntry(number: mobile, duration: 0),
    );

    log('Call Log:: ${latestCall.number}, Duration:: ${latestCall.duration}');

    String? recordingPath;
    recordingPath = await findCallRecording(mobile, latestCall.name ?? '');
    log('Recording Path: $recordingPath');

    emit(CallLogUpdated(latestCall, recordingPath: recordingPath));
  }

  Future<String?> findCallRecording(String phoneNumber, String name) async {
    final possibleDirs = [
      '/storage/emulated/0/Call',
      '/storage/emulated/0/MIUI/sound_recorder/call_rec',
      '/storage/emulated/0/Samsung/Call',
      '/storage/emulated/0/Recordings/Call',
    ];

    for (var path in possibleDirs) {
      final dir = Directory(path);
      if (await dir.exists()) {
        final files = dir
            .listSync()
            .whereType<File>()
            // .where((file) => file.path.contains(phoneNumber) || file.path.contains(name))
            .toList();

        final filesVal = dir.listSync().whereType<File>().toList();
        for (var file in filesVal) {
          log('File Found: ${file.path}');
        }

        if (files.isNotEmpty) {
          files.sort((a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));
          return files.first.path;
        }
      }
    }
    return null;
  }

  Future<void> playRecording(String? path) async {
    log('Recorded Path :: $path');
    if (path != null) {
      await player.openPlayer();
      await player.startPlayer(
        fromURI: path,
        codec: Codec.aacADTS,
        whenFinished: () async {
          await player.closePlayer();
        },
      );
    }
  }
}