class UserProfile {
  String id;
  String updatedAt;
  String username;
  String name;
  String firstName;
  String lastName;
  String instagramUsername;
  String twitterUsername;
  String bio;
  String location;
  int totalLikes;
  int totalPhotos;
  int totalCollections;
  bool followedByUser;
  int followersCount;
  int followingCount;
  int downloads;
  ProfileImage profileImage;
  Badge badge;
  Links links;
  String portfolioUrl;

  UserProfile({
    this.id,
    this.updatedAt,
    this.username,
    this.name,
    this.firstName,
    this.lastName,
    this.instagramUsername,
    this.twitterUsername,
    this.bio,
    this.location,
    this.totalLikes,
    this.totalPhotos,
    this.totalCollections,
    this.followedByUser,
    this.followersCount,
    this.followingCount,
    this.downloads,
    this.profileImage,
    this.badge,
    this.links,
    this.portfolioUrl,
  });

  UserProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    updatedAt = json['updated_at'];
    username = json['username'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    instagramUsername = json['instagram_username'];
    twitterUsername = json['twitter_username'];
    portfolioUrl = json['portfolio_url'];
    bio = json['bio'];
    location = json['location'];
    totalLikes = json['total_likes'];
    totalPhotos = json['total_photos'];
    totalCollections = json['total_collections'];
    followedByUser = json['followed_by_user'];
    followersCount = json['followers_count'];
    followingCount = json['following_count'];
    downloads = json['downloads'];
    profileImage = json['profile_image'] != null
        ? new ProfileImage.fromJson(json['profile_image'])
        : null;
    badge = json['badge'] != null ? new Badge.fromJson(json['badge']) : null;
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['updated_at'] = this.updatedAt;
    data['username'] = this.username;
    data['name'] = this.name;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['instagram_username'] = this.instagramUsername;
    data['twitter_username'] = this.twitterUsername;
    data['portfolio_url'] = this.portfolioUrl;
    data['bio'] = this.bio;
    data['location'] = this.location;
    data['total_likes'] = this.totalLikes;
    data['total_photos'] = this.totalPhotos;
    data['total_collections'] = this.totalCollections;
    data['followed_by_user'] = this.followedByUser;
    data['followers_count'] = this.followersCount;
    data['following_count'] = this.followingCount;
    data['downloads'] = this.downloads;
    if (this.profileImage != null) {
      data['profile_image'] = this.profileImage.toJson();
    }
    if (this.badge != null) {
      data['badge'] = this.badge.toJson();
    }
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
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

class Badge {
  String title;
  bool primary;
  String slug;
  String link;

  Badge({this.title, this.primary, this.slug, this.link});

  Badge.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    primary = json['primary'];
    slug = json['slug'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['primary'] = this.primary;
    data['slug'] = this.slug;
    data['link'] = this.link;
    return data;
  }
}

class Links {
  String self;
  String html;
  String photos;
  String likes;
  String portfolio;

  Links({this.self, this.html, this.photos, this.likes, this.portfolio});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'];
    html = json['html'];
    photos = json['photos'];
    likes = json['likes'];
    portfolio = json['portfolio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['self'] = this.self;
    data['html'] = this.html;
    data['photos'] = this.photos;
    data['likes'] = this.likes;
    data['portfolio'] = this.portfolio;
    return data;
  }
}
