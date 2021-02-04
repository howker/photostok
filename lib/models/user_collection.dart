class UserCollectionList {
  List<UserCollection> userCollectionList;

  UserCollectionList({this.userCollectionList});

  UserCollectionList.fromJson(List<dynamic> json) {
    userCollectionList = List<UserCollection>();
    json.forEach((value) {
      userCollectionList
          .add(UserCollection.fromJson(value as Map<String, dynamic>));
    });
  }

  List<dynamic> toJson() {
    List<dynamic> result = List<dynamic>();

    userCollectionList.forEach((element) {
      result.add(element.toJson());
    });

    return result;
  }
}

class UserCollection {
  String id;
  String title;
  String description;
  String publishedAt;
  String lastCollectedAt;
  String updatedAt;
  bool curated;
  bool featured;
  int totalPhotos;
  bool private;
  String shareKey;
  List<Tags> tags;
  Links links;
  User user;
  CoverPhoto coverPhoto;
  List<PreviewPhotos> previewPhotos;

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
    this.tags,
    this.links,
    this.user,
    this.coverPhoto,
    this.previewPhotos,
  });

  UserCollection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    publishedAt = json['published_at'];
    lastCollectedAt = json['last_collected_at'];
    updatedAt = json['updated_at'];
    curated = json['curated'];
    featured = json['featured'];
    totalPhotos = json['total_photos'];
    private = json['private'];
    shareKey = json['share_key'];
    if (json['tags'] != null) {
      tags = new List<Tags>();
      json['tags'].forEach((v) {
        tags.add(new Tags.fromJson(v));
      });
    }
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    coverPhoto = json['cover_photo'] != null
        ? new CoverPhoto.fromJson(json['cover_photo'])
        : null;
    if (json['preview_photos'] != null) {
      previewPhotos = new List<PreviewPhotos>();
      json['preview_photos'].forEach((v) {
        previewPhotos.add(new PreviewPhotos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['published_at'] = this.publishedAt;
    data['last_collected_at'] = this.lastCollectedAt;
    data['updated_at'] = this.updatedAt;
    data['curated'] = this.curated;
    data['featured'] = this.featured;
    data['total_photos'] = this.totalPhotos;
    data['private'] = this.private;
    data['share_key'] = this.shareKey;
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.coverPhoto != null) {
      data['cover_photo'] = this.coverPhoto.toJson();
    }
    if (this.previewPhotos != null) {
      data['preview_photos'] =
          this.previewPhotos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tags {
  String type;
  String title;

  Tags({this.type, this.title});

  Tags.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['title'] = this.title;
    return data;
  }
}

class Links {
  String self;
  String html;
  String photos;
  String related;

  Links({this.self, this.html, this.photos, this.related});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'];
    html = json['html'];
    photos = json['photos'];
    related = json['related'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['self'] = this.self;
    data['html'] = this.html;
    data['photos'] = this.photos;
    data['related'] = this.related;
    return data;
  }
}

class User {
  String id;
  String updatedAt;
  String username;
  String name;
  String firstName;
  String lastName;
  String twitterUsername;
  String portfolioUrl;
  String bio;
  String location;
  Links links;
  ProfileImage profileImage;
  String instagramUsername;
  int totalCollections;
  int totalLikes;
  int totalPhotos;
  bool acceptedTos;

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

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    updatedAt = json['updated_at'];
    username = json['username'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    twitterUsername = json['twitter_username'];
    portfolioUrl = json['portfolio_url'];
    bio = json['bio'];
    location = json['location'];
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    profileImage = json['profile_image'] != null
        ? new ProfileImage.fromJson(json['profile_image'])
        : null;
    instagramUsername = json['instagram_username'];
    totalCollections = json['total_collections'];
    totalLikes = json['total_likes'];
    totalPhotos = json['total_photos'];
    acceptedTos = json['accepted_tos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['updated_at'] = this.updatedAt;
    data['username'] = this.username;
    data['name'] = this.name;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['twitter_username'] = this.twitterUsername;
    data['portfolio_url'] = this.portfolioUrl;
    data['bio'] = this.bio;
    data['location'] = this.location;
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    if (this.profileImage != null) {
      data['profile_image'] = this.profileImage.toJson();
    }
    data['instagram_username'] = this.instagramUsername;
    data['total_collections'] = this.totalCollections;
    data['total_likes'] = this.totalLikes;
    data['total_photos'] = this.totalPhotos;
    data['accepted_tos'] = this.acceptedTos;
    return data;
  }
}

class ProfileImage {
  String small;
  String medium;
  String large;

  ProfileImage({this.small, this.medium, this.large});

  ProfileImage.fromJson(Map<String, dynamic> json) {
    small = json['small'];
    medium = json['medium'];
    large = json['large'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['small'] = this.small;
    data['medium'] = this.medium;
    data['large'] = this.large;
    return data;
  }
}

class CoverPhoto {
  String id;
  String createdAt;
  String updatedAt;
  String promotedAt;
  int width;
  int height;
  String color;
  String blurHash;
  String description;
  String altDescription;
  Urls urls;
  Links links;
  List categories;
  int likes;
  bool likedByUser;
  List currentUserCollections;
  Null sponsorship;
  User user;

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
      this.categories,
      this.likes,
      this.likedByUser,
      this.currentUserCollections,
      this.sponsorship,
      this.user});

  CoverPhoto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    promotedAt = json['promoted_at'];
    width = json['width'];
    height = json['height'];
    color = json['color'];
    blurHash = json['blur_hash'];
    description = json['description'];
    altDescription = json['alt_description'];
    urls = json['urls'] != null ? new Urls.fromJson(json['urls']) : null;
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;

    likes = json['likes'];
    likedByUser = json['liked_by_user'];

    sponsorship = json['sponsorship'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['promoted_at'] = this.promotedAt;
    data['width'] = this.width;
    data['height'] = this.height;
    data['color'] = this.color;
    data['blur_hash'] = this.blurHash;
    data['description'] = this.description;
    data['alt_description'] = this.altDescription;
    if (this.urls != null) {
      data['urls'] = this.urls.toJson();
    }
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }

    data['likes'] = this.likes;
    data['liked_by_user'] = this.likedByUser;

    data['sponsorship'] = this.sponsorship;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class Urls {
  String raw;
  String full;
  String regular;
  String small;
  String thumb;

  Urls({this.raw, this.full, this.regular, this.small, this.thumb});

  Urls.fromJson(Map<String, dynamic> json) {
    raw = json['raw'];
    full = json['full'];
    regular = json['regular'];
    small = json['small'];
    thumb = json['thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['raw'] = this.raw;
    data['full'] = this.full;
    data['regular'] = this.regular;
    data['small'] = this.small;
    data['thumb'] = this.thumb;
    return data;
  }
}

class PreviewPhotos {
  String id;
  String createdAt;
  String updatedAt;
  String blurHash;
  Urls urls;

  PreviewPhotos(
      {this.id, this.createdAt, this.updatedAt, this.blurHash, this.urls});

  PreviewPhotos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    blurHash = json['blur_hash'];
    urls = json['urls'] != null ? new Urls.fromJson(json['urls']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['blur_hash'] = this.blurHash;
    if (this.urls != null) {
      data['urls'] = this.urls.toJson();
    }
    return data;
  }
}
