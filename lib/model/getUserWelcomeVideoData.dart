// To parse this JSON data, do
//
//     final getUsersWelcomeVideosData = getUsersWelcomeVideosDataFromJson(jsonString);

import 'dart:convert';

List<GetUsersWelcomeVideosData> getUsersWelcomeVideosDataFromJson(String str) => List<GetUsersWelcomeVideosData>.from(json.decode(str).map((x) => GetUsersWelcomeVideosData.fromJson(x)));

String getUsersWelcomeVideosDataToJson(List<GetUsersWelcomeVideosData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetUsersWelcomeVideosData {
    int videoId;
    String title;
    String videoLink;
    String instructor;
    String thambnailPath;

    GetUsersWelcomeVideosData({
        required this.videoId,
        required this.title,
        required this.videoLink,
        required this.instructor,
        required this.thambnailPath,
    });

    factory GetUsersWelcomeVideosData.fromJson(Map<String, dynamic> json) => GetUsersWelcomeVideosData(
        videoId: json["videoId"],
        title: json["title"],
        videoLink: json["videoLink"],
        instructor: json["instructor"],
        thambnailPath: json["thambnailPath"],
    );

    Map<String, dynamic> toJson() => {
        "videoId": videoId,
        "title": title,
        "videoLink": videoLink,
        "instructor": instructor,
        "thambnailPath": thambnailPath,
    };
}
