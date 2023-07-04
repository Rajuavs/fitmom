import 'dart:async' show TimeoutException;
import 'dart:convert' show Encoding, json;
import 'dart:io' show SocketException, File, InternetAddress;

import 'package:flutter/foundation.dart' show kIsWeb, debugPrint, Uint8List;

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

import 'custome_exception.dart';
import 'mothods.dart';

const String refreshUrl = "/api/Accounts/refresh-token";

String baseUrl = "https://fitmomwebapi.jaspertech.xyz";

class HttpServerHttp {
  Future<dynamic> request(
      {required String baseurl,
      required String url,
      required Method method,
      required var params,
      required int timeout,
      required String type,
      required bool auth}) async {
    String requetyType = "";

    switch (method) {
      case Method.get:
        requetyType = "GET";
        break;
      case Method.post:
        requetyType = "POST";
        break;
      case Method.put:
        requetyType = "PUT";
        break;
      case Method.delete:
        requetyType = "DELETE";
        break;
    }

    String urlPath = baseurl.isEmpty ? (baseUrl + url) : (baseurl + url);
    debugPrint("baserurl:  $urlPath $params");

    var responseJson;

    baseurl = baseurl.isEmpty ? baseUrl : baseurl;

    var headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'Access-Control-Allow-Origin': '*',
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (auth) {
      headers['Authorization'] = ' ${prefs.getString('jwtToken')}';
    }

    debugPrint("http:request  $urlPath ,  $params, $headers");
    debugPrint("http:request headers  $headers");
    var request;
    if (type == "raw") {
      var paramsdata = json.encode(params);
      request = http.Request(requetyType, Uri.parse(urlPath.toString()));
      // request.bo
      request.body = paramsdata;
      request.headers.addAll(headers);
      request.encoding = Encoding.getByName('utf-8')!;
    } else if (type == "params") {
      if (requetyType == "GET" ||
          requetyType == "POST" ||
          requetyType == "PUT" ||
          requetyType == "DELETE") {
        String parameters = "";
        params.forEach((key, value) {
          parameters += "$key=$value&";
        });
        if (parameters.isNotEmpty) {
          parameters = parameters.substring(0, parameters.length - 1);
          urlPath = "$urlPath?$parameters";
        }

        debugPrint("query parameters : $urlPath");
        if (auth) {
          var headers = {
            'Content-Type': 'application/x-www-form-urlencoded',
            "Access-Control-Allow-Origin": "*",
          };
          headers['Authorization'] = ' ${prefs.getString('jwtToken')}';
        }
      }
      var paramsdata = json.encode(params);
      request = http.Request(
        requetyType,
        Uri.parse(urlPath.toString()),
      );
    } else if (type == "fileForm") {
      debugPrint("urlpath 22222222222 : $urlPath, $params");
      request = http.MultipartRequest(requetyType, Uri.parse(urlPath));

      Map<String, String> maps = <String, String>{};
      params.forEach((key, value) {
        if (key != "file") {
          maps[key] = value!.toString();
        }
      });

      List<String> filesNames = params["file"] ?? [];
      for (var fileNameF in filesNames) {
        String fileKey = fileNameF;
        debugPrint("mapmsps123 $maps ,  fileKey $fileKey");
        List fileKeys = [];
        try {
          fileKeys = params[fileKey];
        } catch (_) {
          fileKeys = [params[fileKey]];
        }
        if (fileKey.isNotEmpty) {
          for (var fileIs in fileKeys) {
            File file; // = File(params[fileKey]);

            http.MultipartFile file1;
            if (kIsWeb) {
              final http.Response responseData =
                  await http.get(Uri.parse(fileIs)); //params[fileKey]));
              var headerscontent = responseData.headers;
              var contentTypeName = headerscontent["content-type"];
              var contentTypeIs =
                  contentTypeName.toString().replaceAll("/", ".");

              debugPrint("headerscontent : $headerscontent");

              Uint8List uint8list = responseData.bodyBytes;
              List<int> listBytes = uint8list.cast(); //toList();

              debugPrint("filepathe blob $fileIs ${params[fileKey]}");
              file1 = http.MultipartFile.fromBytes(fileKey, listBytes,
                  filename: "image.$contentTypeIs"); //"image.png");
            } else {
              file = File(fileIs);
              debugPrint("xfile $file");
              var filePath = file.path;
              debugPrint("xfile filePath $filePath");
              var fileName = file.path.split("/").last;
              print("filename........... $fileName");
              var bytes = await file.readAsBytes();
              List<int> bytes1 = bytes.cast();
              print(bytes);
              print(fileKey);

              file1 = http.MultipartFile.fromBytes(fileKey, bytes1,
                  filename: fileName);
            }
            request.files.add(file1);
          }
        }
      }
      debugPrint("mapsmaps $maps");
      headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
      };
      // headers['Authorization'] = ' ${prefs.getString('jwtToken')}';
      headers["Access-Control-Allow-Origin"] = "*";

      debugPrint("myHeaders $headers");
      request.fields.addAll(maps);
      debugPrint("request parameterssss $maps");

      request.headers.addAll(headers);
    } else if (type == "getfile") {
      final http.Response responseData =
          await http.get(Uri.parse(url)); //params[fileKey]));
      var headerscontent = responseData.headers;
      var contentTypeName = headerscontent["content-type"];
      var contentTypeIs = contentTypeName.toString().replaceAll("/", ".");

      debugPrint("headerscontent : $headerscontent");

      Uint8List uint8list = responseData.bodyBytes;

      if (responseData.statusCode == 200) {
        return {
          "headerscontent": headerscontent,
          "listBytes": uint8list,
        };
      } else {
        return {"error": responseData.reasonPhrase.toString()};
      }
    }

    try {
      http.StreamedResponse response1 =
          await request.send().timeout(Duration(seconds: timeout));

      responseJson = await _response(response1);

      debugPrint("http:response $responseJson");
      return responseJson;
    } on SocketException catch (e) {
      debugPrint("http_server: SocketException => $e");

      throw SocketExceptionss(e.toString());
    } on TimeoutException catch (e) {
      debugPrint(e.toString());
      debugPrint("Connection Timeout 222222222222 $e");
      throw ConnectionTimeOut("Connection Time Out. Please try again1.");
    } on FormatException catch (e) {
      debugPrint("http_server: FormatException => $e");
      throw FormatExceptions(e.toString());
    } on HttpConnectionClosed {
    } on Error catch (e) {
      debugPrint("http_server:  Error[${e.toString()}]");

      throw e.toString();
    }
  }

  Future<dynamic> requestParams(
      {required String baseurl,
      required String url,
      required Method method,
      required var params,
      required int timeout,
      required String type,
      required bool auth}) async {
    try {
      final httpconnect = await InternetAddress.lookup('google.com');
      if (httpconnect.isNotEmpty && httpconnect[0].rawAddress.isNotEmpty) {}
    } on SocketException catch (_) {
      throw SocketExceptionss("Please check your internet connection");
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    debugPrint("request : $url, $params");
    http.Response? restult1;
    try {
      switch (method) {
        case Method.get:
          var uri = Uri.https("app.jsportsfootball.com", url, params);

          restult1 = await http.get(
            uri,
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${prefs.getString('jwtToken')}",
            },
          ).timeout(Duration(seconds: timeout));
          debugPrint("restult1: ${restult1.body}");
          break;
        case Method.post:
          break;
        case Method.put:
          break;
        case Method.delete:
          break;
      }
      var jsonResponse = _responseI(restult1);
      return jsonResponse;
    } on SocketException catch (e) {
      debugPrint("http_server: SocketException => $e");

      throw SocketExceptionss(e.toString());
    } on TimeoutException catch (e) {
      debugPrint("error: ${e.message}");
      throw ConnectionTimeOut(
          "Connection Timeout: Unable to connect to server");
    } on FormatException catch (e) {
      debugPrint("http_server: FormatException => $e");
      throw FormatExceptions(e.toString());
    } on Error catch (e) {
      debugPrint("http_server:  Error[${e.toString()}]");

      throw e.toString();
    }
  }

  _response(http.StreamedResponse response) async {
    var outputBody = await response.stream.bytesToString();
    debugPrint(
        "http_service r1 output :  $outputBody , statuscode ${response.statusCode}");
    switch (response.statusCode) {
      case 200:
        return outputBody;
      case 400:
        throw ErrorException(outputBody);
      case 404:
        throw NotFoundExceptions(outputBody);
      case 500:
        throw InternalServerError(response.reasonPhrase);
      case 503:
        throw SomethingWendWrong(response.reasonPhrase);
      default:
        throw throw SomethingWendWrong(outputBody);
    }
  }

  _responseI(http.Response? response) async {
    var outputBody = response!.body;
    debugPrint(
        "http_service output :  $outputBody , statuscode ${response.statusCode}");
    switch (response.statusCode) {
      case 200:
        return outputBody;
      case 500:
        throw throw InternalServerError(response.reasonPhrase);
      default:
        throw throw SomethingWendWrong(outputBody);
    }
  }
}
