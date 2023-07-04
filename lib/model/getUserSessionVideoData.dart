// To parse this JSON data, do
//
//     final getUsersSessionVideosData = getUsersSessionVideosDataFromJson(jsonString);

import 'dart:convert';

List<GetUsersSessionVideosData> getUsersSessionVideosDataFromJson(String str) => List<GetUsersSessionVideosData>.from(json.decode(str).map((x) => GetUsersSessionVideosData.fromJson(x)));

String getUsersSessionVideosDataToJson(List<GetUsersSessionVideosData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetUsersSessionVideosData {
    int videoId;
    String title;
    String videoLink;
    int weekId;
    int trimester;
    String instructor;
    String thambnailPath;

    GetUsersSessionVideosData({
        required this.videoId,
        required this.title,
        required this.videoLink,
        required this.weekId,
        required this.trimester,
        required this.instructor,
        required this.thambnailPath,
    });

    factory GetUsersSessionVideosData.fromJson(Map<String, dynamic> json) => GetUsersSessionVideosData(
        videoId: json["videoId"],
        title: json["title"],
        videoLink: json["videoLink"],
        weekId: json["weekId"],
        trimester: json["trimester"],
        instructor: json["instructor"]??"",
        thambnailPath: json["thambnailPath"],
    );

    Map<String, dynamic> toJson() => {
        "videoId": videoId,
        "title": title,
        "videoLink": videoLink,
        "weekId": weekId,
        "trimester": trimester,
        "instructor": instructorValues.reverse[instructor],
        "thambnailPath": thambnailPath,
    };
}

enum Instructor { TEST_ONE_TEST_ONE }

final instructorValues = EnumValues({
    "test one test one": Instructor.TEST_ONE_TEST_ONE
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
