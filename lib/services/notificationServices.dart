import 'package:dio/dio.dart';

class NotificationServices {
  // 'token', 'new dog', 'message', {}
  static sendNotificationsTopic(topic, title, body, json) async {
    try {
      await Dio().post('https://fcm.googleapis.com/fcm/send',
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAAoOMSK5c:APA91bH6EAfIZLuiNEc7Kr8OHTzVBHE8iwgpo7Zmvj0dVNXVsAm2Qg8H3IFh9-8zm-8F9bKxnJvn5wxY_EY-UPr_10DezXwj0M_BghHMkl3wbHEF19KSOVtOtgBVm4MDYD-BCuepkUdH'
          }),
          data: {
            'to': '/topics/$topic',
            "notification": {'body': body, 'title': title},
            "data": json
          });
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        print(e.response?.statusMessage);
      } else {
        print(e.response?.statusCode);
      }
    }
  }
}

// Title can be for now: What's Up this week? (Tuesdays); What's Up this weekend (Fridays).
// Body: "________ has an event and special offer announcement.
// Brought to you by Nightly App because you follow _________."