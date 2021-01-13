import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:photostok/models/auth_model.dart';

class PhotoRepository {
  static String authToken = "";
  static const String _accessKey =
      'sODtHjHP_KttQh2UDFqy-OuSBci_2nrw1i7pDRob29U'; //app access key from console
  static const String _secretKey =
      'G4r7fwE8vIoWU_Ocje2yTdxm7zcl62wKZEh-tUckwZE'; //app secrey key from console
  static const String authUrl =
      'https://unsplash.com/oauth/authorize?client_id=$_accessKey&redirect_uri=urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob&response_type=code&scope=public+write_likes'; //authorize url from https://unsplash.com/oauth/applications/{your_app_id}

  Future<Auth> doLogin({String oneTimeCode}) async {
    var response = await http.post('https://unsplash.com/oauth/token',
        headers: {
          'Content-Type': 'application/json',
        },
        body:
            '{"client_id":"$_accessKey","client_secret":"$_secretKey","redirect_uri":"urn:ietf:wg:oauth:2.0:oob","code":"$oneTimeCode","grant_type":"authorization_code"}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return Auth.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  // static Future<PhotoList> getPhotos(int page, int perPage) async {
  //   var response = await http.get(
  //       'https://api.unsplash.com/photos?page=$page&per_page=$perPage',
  //       headers: {'Authorization': 'Bearer $authToken'});

  //   if (response.statusCode >= 200 && response.statusCode < 300) {
  //     return PhotoList.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Error: ${response.reasonPhrase}');
  //   }
  // }

  // static Future<Photo> getRandomPhoto() async {
  //   var response = await http.get('https://api.unsplash.com/photos/random',
  //       headers: {'Authorization': 'Bearer $authToken'});

  //   if (response.statusCode >= 200 && response.statusCode < 300) {
  //     return Photo.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Error: ${response.reasonPhrase}');
  //   }
  // }

  // static Future<bool> likePhoto(String photoId) async {
  //   var response = await http
  //       .post('https://api.unsplash.com/photos/$photoId/like', headers: {
  //     'Authorization': 'Bearer $authToken',
  //   });

  //   print(response.body);
  //   print(response.reasonPhrase);

  //   if (response.statusCode >= 200 && response.statusCode < 300) {
  //     return true; //returns 201 - Created
  //   } else {
  //     throw Exception('Error: ${response.reasonPhrase}');
  //   }
  // }

  // static Future<bool> unlikePhoto(String photoId) async {
  //   var response = await http
  //       .delete('https://api.unsplash.com/photos/$photoId/like', headers: {
  //     'Authorization': 'Bearer $authToken',
  //   });

  //   if (response.statusCode >= 200 && response.statusCode < 300) {
  //     return true; //returns 201 - Created
  //   } else {
  //     throw Exception('Error: ${response.reasonPhrase}');
  //   }
  // }
}
