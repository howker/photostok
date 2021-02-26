import 'package:photostok/models/photo_list.dart';

class RelatedPhotoList {
  final int total;
  final List<Results> results;

  RelatedPhotoList({this.total, this.results});

  factory RelatedPhotoList.fromJson(Map<String, dynamic> json) {
    List<Results> results;
    json['results'].forEach((v) {
      results.add(new Results.fromJson(v));
    });

    return RelatedPhotoList(results: results);
  }
}

class Results {
  final String id;
  final String createdAt;
  final String updatedAt;
  final String promotedAt;
  final int width;
  final int height;
  final String color;
  final String blurHash;
  final String description;
  final String altDescription;
  final Urls urls;
  final Links links;
  final int likes;
  final bool likedByUser;
  final Null sponsorship;
  final User user;

  Results(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.promotedAt,
      this.width,
      this.height,
      this.color,
      this.blurHash,
      this.description,
      this.altDescription,
      this.urls,
      this.links,
      this.likes,
      this.likedByUser,
      this.sponsorship,
      this.user});

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      id: json['id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      promotedAt: json['promoted_at'],
      width: json['width'],
      height: json['height'],
      color: json['color'],
      blurHash: json['blur_hash'],
      description: json['description'],
      altDescription: json['alt_description'],
      urls: json['urls'] != null ? new Urls.fromJson(json['urls']) : null,
      links: json['links'] != null ? new Links.fromJson(json['links']) : null,
      likes: json['likes'],
      likedByUser: json['liked_by_user'],
      sponsorship: json['sponsorship'],
      user: json['user'] != null ? new User.fromJson(json['user']) : null,
    );
  }
}

class Links {
  final String self;
  final String html;
  final String download;
  final String downloadLocation;

  Links({this.self, this.html, this.download, this.downloadLocation});

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      self: json['self'],
      html: json['html'],
      download: json['download'],
      downloadLocation: json['download_location'],
    );
  }
}

class SponsorLinks {
  final String self;
  final String html;
  final String photos;
  final String likes;
  final String portfolio;
  final String following;
  final String followers;

  SponsorLinks(
      {this.self,
      this.html,
      this.photos,
      this.likes,
      this.portfolio,
      this.following,
      this.followers});

  factory SponsorLinks.fromJson(Map<String, dynamic> json) {
    return SponsorLinks(
      self: json['self'],
      html: json['html'],
      photos: json['photos'],
      likes: json['likes'],
      portfolio: json['portfolio'],
      following: json['following'],
      followers: json['followers'],
    );
  }
}

class ProfileImage {
  final String small;
  final String medium;
  final String large;

  ProfileImage({this.small, this.medium, this.large});

  factory ProfileImage.fromJson(Map<String, dynamic> json) {
    return ProfileImage(
      small: json['small'],
      medium: json['medium'],
      large: json['large'],
    );
  }
}
