class PhotoList {
  final List<Photo> photos;

  PhotoList({this.photos});

  factory PhotoList.fromJson(List<dynamic> json) {
    List<Photo> photos = [];
    json.forEach((value) {
      photos.add(Photo.fromJson(value as Map<String, dynamic>));
    });

    return PhotoList(photos: photos);
  }
}

class Photo {
  final String id;
  final String createdAt;
  final String updatedAt;
  final String promotedAt;
  final int width;
  final int height;
  final String color;
  final String description;
  final String altDescription;
  final Urls urls;
  final Links links;
  final int likes;
  final bool likedByUser;
  final Sponsorship sponsorship;
  final User user;

  Photo({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.promotedAt,
    this.width,
    this.height,
    this.color,
    this.description,
    this.altDescription,
    this.urls,
    this.links,
    this.likes,
    this.likedByUser,
    this.sponsorship,
    this.user,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      promotedAt: json['promoted_at'],
      width: json['width'],
      height: json['height'],
      color: json['color'],
      description: json['description'],
      altDescription: json['alt_description'] ?? '',
      urls: json['urls'] != null ? new Urls.fromJson(json['urls']) : null,
      links: json['links'] != null ? new Links.fromJson(json['links']) : null,
      likes: json['likes'],
      likedByUser: json['liked_by_user'] ?? false,
      sponsorship: json['sponsorship'] != null
          ? new Sponsorship.fromJson(json['sponsorship'])
          : null,
      user: json['user'] != null ? new User.fromJson(json['user']) : null,
    );
  }
}

class Urls {
  final String raw;
  final String full;
  final String regular;
  final String small;
  final String thumb;

  Urls({this.raw, this.full, this.regular, this.small, this.thumb});

  factory Urls.fromJson(Map<String, dynamic> json) {
    return Urls(
      raw: json['raw'],
      full: json['full'],
      regular: json['regular'],
      small: json['small'],
      thumb: json['thumb'],
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

class Sponsorship {
  final List<String> impressionUrls;
  final String tagline;
  final String taglineUrl;
  final User sponsor;

  Sponsorship(
      {this.impressionUrls, this.tagline, this.taglineUrl, this.sponsor});

  factory Sponsorship.fromJson(Map<String, dynamic> json) {
    return Sponsorship(
      impressionUrls: json['impression_urls'].cast<String>(),
      tagline: json['tagline'],
      taglineUrl: json['tagline_url'],
      sponsor:
          json['sponsor'] != null ? new User.fromJson(json['sponsor']) : null,
    );
  }
}

class User {
  final String id;
  final String updatedAt;
  final String username;
  final String name;
  final String firstName;
  final String lastName;
  final String twitterUsername;
  final String portfolioUrl;
  final String bio;
  final String location;
  final Links links;
  final ProfileImage profileImage;
  final String instagramUsername;
  final int totalCollections;
  final int totalLikes;
  final int totalPhotos;
  final bool acceptedTos;

  User(
      {this.id,
      this.updatedAt,
      this.username,
      this.name,
      this.firstName,
      this.lastName,
      this.twitterUsername,
      this.portfolioUrl,
      this.bio,
      this.location,
      this.links,
      this.profileImage,
      this.instagramUsername,
      this.totalCollections,
      this.totalLikes,
      this.totalPhotos,
      this.acceptedTos});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      updatedAt: json['updated_at'],
      username: json['username'],
      name: json['name'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      twitterUsername: json['twitter_username'],
      portfolioUrl: json['portfolio_url'],
      bio: json['bio'],
      location: json['location'],
      links: json['links'] != null ? new Links.fromJson(json['links']) : null,
      profileImage: json['profile_image'] != null
          ? new ProfileImage.fromJson(json['profile_image'])
          : null,
      instagramUsername: json['instagram_username'],
      totalCollections: json['total_collections'],
      totalLikes: json['total_likes'],
      totalPhotos: json['total_photos'],
      acceptedTos: json['accepted_tos'],
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
