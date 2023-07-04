// To parse this JSON data, do
//
//     final getUsersLiveVideosData = getUsersLiveVideosDataFromJson(jsonString);

import 'dart:convert';

List<GetUsersLiveVideosData> getUsersLiveVideosDataFromJson(String str) => List<GetUsersLiveVideosData>.from(json.decode(str).map((x) => GetUsersLiveVideosData.fromJson(x)));

String getUsersLiveVideosDataToJson(List<GetUsersLiveVideosData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetUsersLiveVideosData {
    int sessionId;
    String title;
    String videoLink;
    DateTime sessionTime;
    String instructor;
    String instructorPhotoPath;

    GetUsersLiveVideosData({
        required this.sessionId,
        required this.title,
        required this.videoLink,
        required this.sessionTime,
        required this.instructor,
        required this.instructorPhotoPath,
    });

    factory GetUsersLiveVideosData.fromJson(Map<String, dynamic> json) => GetUsersLiveVideosData(
        sessionId: json["sessionId"],
        title: json["title"],
        videoLink: json["videoLink"],
        sessionTime: DateTime.parse(json["sessionTime"]),
        instructor: json["instructor"],
        instructorPhotoPath: json["instructorPhotoPath"],
    );

    Map<String, dynamic> toJson() => {
        "sessionId": sessionId,
        "title": title,
        "videoLink": videoLink,
        "sessionTime": sessionTime.toIso8601String(),
        "instructor": instructor,
        "instructorPhotoPath": instructorPhotoPath,
    };
}
