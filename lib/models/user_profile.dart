class UserProfile {
  final String id;
  final String updatedAt;
  final String username;
  final String name;
  final String firstName;
  final String lastName;
  final String instagramUsername;
  final String twitterUsername;
  final String bio;
  final String location;
  final int totalLikes;
  final int totalPhotos;
  final int totalCollections;
  final bool followedByUser;
  final int followersCount;
  final int followingCount;
  final int downloads;
  final ProfileImage profileImage;
  final Badge badge;
  final Links links;
  final String portfolioUrl;

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

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      updatedAt: json['updated_at'],
      username: json['username'],
      name: json['name'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      instagramUsername: json['instagram_username'],
      twitterUsername: json['twitter_username'],
      portfolioUrl: json['portfolio_url'],
      bio: json['bio'],
      location: json['location'],
      totalLikes: json['total_likes'],
      totalPhotos: json['total_photos'],
      totalCollections: json['total_collections'],
      followedByUser: json['followed_by_user'],
      followersCount: json['followers_count'],
      followingCount: json['following_count'],
      downloads: json['downloads'],
      profileImage: json['profile_image'] != null
          ? new ProfileImage.fromJson(json['profile_image'])
          : null,
      badge: json['badge'] != null ? new Badge.fromJson(json['badge']) : null,
      links: json['links'] != null ? new Links.fromJson(json['links']) : null,
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

class Badge {
  final String title;
  final bool primary;
  final String slug;
  final String link;

  Badge({this.title, this.primary, this.slug, this.link});

  factory Badge.fromJson(Map<String, dynamic> json) {
    return Badge(
      title: json['title'],
      primary: json['primary'],
      slug: json['slug'],
      link: json['link'],
    );
  }
}

class Links {
  final String self;
  final String html;
  final String photos;
  final String likes;
  final String portfolio;

  Links({this.self, this.html, this.photos, this.likes, this.portfolio});

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      self: json['self'],
      html: json['html'],
      photos: json['photos'],
      likes: json['likes'],
      portfolio: json['portfolio'],
    );
  }
}
