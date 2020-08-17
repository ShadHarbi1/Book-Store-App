class Post {
  final String title;
  final String article; //the article content
  final String catagory;
  final String picture;
  final String createdAt;

  Post({this.article, this.catagory, this.picture, this.createdAt, this.title});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        title: json['title'] as String,
        article: json['article'] as String,
        catagory: json['catagory'] as String,
        picture: json['picture'] as String,
        createdAt: json['createdAt'] as String);
  }
}
