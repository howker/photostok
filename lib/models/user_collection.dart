class UserCollectionList {
  final List<UserCollection> userCollectionList;

  UserCollectionList({this.userCollectionList});

  factory UserCollectionList.fromJson(List<dynamic> json) {
    List<UserCollection> userCollectionList;
    json.forEach((value) {
      userCollectionList
          .add(UserCollection.fromJson(value as Map<String, dynamic>));
    });

    return UserCollectionList(userCollectionList: userCollectionList);
  }
}

class UserCollection {
  final String id;
  final String title;
  final String description;
  final String publishedAt;
  final String lastCollectedAt;
  final String updatedAt;
  final bool curated;
  final bool featured;
  final int totalPhotos;
  final bool private;
  final String shareKey;
  final Links links;
  final User user;
  final CoverPhoto coverPhoto;

  UserCollection({
    this.id,
    this.title,
    this.description,
    this.publishedAt,
    this.lastCollectedAt,
    this.updatedAt,
    this.curated,
    this.featured,
    this.totalPhotos,
    this.private,
    this.shareKey,
    this.links,
    this.user,
    this.coverPhoto,
  });

  factory UserCollection.fromJson(Map<String, dynamic> json) {
    return UserCollection(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      publishedAt: json['published_at'],
      lastCollectedAt: json['last_collected_at'],
      updatedAt: json['updated_at'],
      curated: json['curated'],
      featured: json['featured'],
      totalPhotos: json['total_photos'],
      private: json['private'],
      shareKey: json['share_key'],
      links: json['links'] != null ? new Links.fromJson(json['links']) : null,
      user: json['user'] != null ? new User.fromJson(json['user']) : null,
      coverPhoto: json['cover_photo'] != null
          ? new CoverPhoto.fromJson(json['cover_photo'])
          : null,
    );
  }
}

class Links {
  final String self;
  final String html;
  final String photos;
  final String related;

  Links({this.self, this.html, this.photos, this.related});

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      self: json['self'],
      html: json['html'],
      photos: json['photos'],
      related: json['related'],
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

class CoverPhoto {
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
  final List currentUserCollections;
  final User user;

  CoverPhoto(
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
      this.currentUserCollections,
      this.user});

  factory CoverPhoto.fromJson(Map<String, dynamic> json) {
    return CoverPhoto(
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

class PreviewPhotos {
  final String id;
  final String createdAt;
  final String updatedAt;
  final String blurHash;
  final Urls urls;

  PreviewPhotos(
      {this.id, this.createdAt, this.updatedAt, this.blurHash, this.urls});

  factory PreviewPhotos.fromJson(Map<String, dynamic> json) {
    return PreviewPhotos(
      id: json['id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      blurHash: json['blur_hash'],
      urls: json['urls'] != null ? new Urls.fromJson(json['urls']) : null,
    );
  }
}
