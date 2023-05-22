import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../api/api.dart';

part 'noti_event.dart';
part 'noti_state.dart';

class NotiBloc extends Bloc<NotiEvent, NotiState> {
  final Api api;
  NotiBloc(this.api) : super(NotiInitial()) {
    on<SendNoti>((event, emit) async {
      emit(NotiSendLoading());

      try {
        var formData = {
          "to": "/topics/all_noti", // global is your topic
          "notification": {
            "body": event.body,
            "content_available": true,
            "priority": "high",
            "title": event.title
          },
          "data": {
            "body": event.body,
            "content_available": true,
            "priority": "high",
            "title": event.title
          }
        };
        Response data = await api.myDio.post("/fcm/send", data: formData);
        print("===================>");
        print(data.data);
        emit(NotiSendSuccess());
      } on SocketException {
        emit(NotiSendError("Poor connection"));
      } catch (e) {
        if (e.runtimeType == DioError) {
          DioError dioError = e as DioError;
          if (dioError.type == DioErrorType.connectionError) {
            emit(NotiSendError("connection error "));
          } else if (dioError.type == DioErrorType.connectionTimeout ||
              dioError.type == DioErrorType.receiveTimeout ||
              dioError.type == DioErrorType.sendTimeout) {
            emit(NotiSendError("Timeout due to poor connection"));
          } else {
            emit(NotiSendError("Oops.. server is something went wrong!"));
          }
        } else {
          emit(NotiSendError(e.toString()));
        }
      }

      // }
    });
  }
}
