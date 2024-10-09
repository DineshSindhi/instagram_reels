class ReelsModel {
  String? url;
  String? profile;
  String? userName;
  int? likes;
  bool isLike;
  String? description;

  ReelsModel(
      {required this.url,
      required this.userName,
       this.isLike=false,
      required this.profile,
      required this.description,
         this.likes=0
      });

  factory ReelsModel.fromDoc(Map<String, dynamic> fromDoc) {
    return ReelsModel(
        url: fromDoc['url'],
        userName: fromDoc['userName'],
        isLike: fromDoc['isLike'],
      profile: fromDoc['profile'],
        description:fromDoc['description'],
        likes:fromDoc['likes'],
    );
  }
}
