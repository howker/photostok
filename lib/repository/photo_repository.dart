import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:photostok/models/auth_model.dart';
import 'package:photostok/models/photo_list.dart';
import 'package:photostok/models/related_photo_list.dart';
import 'package:photostok/models/user_profile.dart';

class PhotoRepository {
  static const String authUrl =
      'https://unsplash.com/oauth/authorize?client_id=$_accessKey&redirect_uri=urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob&response_type=code&scope=public+write_likes';
  static String authToken = "_qHJDsz517URgu6HrcQv4NLLw7shIOzD9j6QOvtd8h0";
  static const String _accessKey =
      'sODtHjHP_KttQh2UDFqy-OuSBci_2nrw1i7pDRob29U';
  static const String _secretKey =
      'G4r7fwE8vIoWU_Ocje2yTdxm7zcl62wKZEh-tUckwZE';

  Future<Auth> doLogin() async {
    var response = await http.post('https://unsplash.com/oauth/token',
        headers: {
          'Content-Type': 'application/json',
        },
        body:
            '{"client_id":"$_accessKey","client_secret":"$_secretKey","redirect_uri":"urn:ietf:wg:oauth:2.0:oob","code":"$authToken","grant_type":"authorization_code"}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return Auth.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  Future<PhotoList> getPhotos(int page, int perPage) async {
    var response = await http.get(
        'https://api.unsplash.com/photos?page=$page&per_page=$perPage',
        headers: {'Authorization': 'Bearer $authToken'});

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return PhotoList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  static Future<RelatedPhotoList> getRelatedPhotos(String photoId) async {
    var response = await http.get(
        'https://api.unsplash.com/photos/$photoId/related',
        headers: {'Authorization': 'Bearer $authToken'});

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return RelatedPhotoList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  Future<RelatedPhotoList> getSearchPhotos(
      int page, int perPage, String query) async {
    var response = await http.get(
        'https://api.unsplash.com/search/photos?page=$page&per_page=$perPage&query=$query',
        headers: {'Authorization': 'Bearer $authToken'});

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return RelatedPhotoList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  Future<UserProfile> getUserProfile(String userName) async {
    var response = await http.get('https://api.unsplash.com/users/$userName',
        headers: {'Authorization': 'Bearer $authToken'});

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return UserProfile.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  static Future<bool> likePhoto(String photoId) async {
    var response = await http
        .post('https://api.unsplash.com/photos/$photoId/like', headers: {
      'Authorization': 'Bearer $authToken',
    });

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true; //returns 201 - Created
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  static Future<bool> unlikePhoto(String photoId) async {
    var response = await http
        .delete('https://api.unsplash.com/photos/$photoId/like', headers: {
      'Authorization': 'Bearer $authToken',
    });

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true; //returns 201 - Created
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  static Future<Photo> getPhotoById(String photoId) async {
    var response = await http.get('https://api.unsplash.com//photos/$photoId',
        headers: {'Authorization': 'Bearer $authToken'});

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return Photo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }
}
