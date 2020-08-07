class Post {
  final String title;
  final String article; //the article content
  final String catagory;
  final String picture;
  final String publishedDate;

  Post(
      {this.article,
      this.catagory,
      this.picture,
      this.publishedDate,
      this.title});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        title: json['title'] as String,
        article: json['article'] as String,
        catagory: json['catagory'] as String,
        picture: json['picture'] as String,
        publishedDate: json['publishedDate'] as String);
  }
}
