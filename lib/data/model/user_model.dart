class UserModel{
  String? uid;
  String? email;
  String? pass;

  String? name;
  String? userName;

  UserModel({required this.email, required this.pass,required this.name,required this.uid,required this.userName});
  factory UserModel.fromDoc(Map<String,dynamic>doc){
    return UserModel(
      email: doc['email'],
      pass: doc['pass'],
      name: doc['name'],
      uid: doc['uid'],
      userName: doc['userName'],
    );
  }

  Map<String,dynamic>toDoc(){
    return {
      'email':email,
      'pass':pass,
      'name':name,
      'uid':uid,
      'userName':userName,
    };
  }
}