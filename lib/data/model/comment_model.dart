class CommentModel {
  String? profile;
  String? comment;
  String? userName;
  bool? isLike;
  String? like;

  CommentModel(
      {required this.profile, required this.comment, required this.userName, required this.isLike, required this.like});

  factory CommentModel.fromDoc(Map<String, dynamic> fromDoc) {
    return CommentModel(profile: fromDoc['profile'],
        comment: fromDoc['comment'],
        userName: fromDoc['userName'],
        isLike: fromDoc['isLike'],
        like: fromDoc['like']
    );
  }
  Map<String, dynamic>toDoc(){
    return {
          'profile': profile, 'comment': comment, 'userName': userName, 'isLike': isLike, 'like': like
    };
  }
}