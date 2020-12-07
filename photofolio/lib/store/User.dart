class User{
  String userEmail;
  String userPassword;
  String userNickName;
  String userImageSrc;
  // Image userImageSrc;

  String getUserEmail()=> userEmail;
  String getUserNickName() => userNickName;
  String getUserImageSrc() => userImageSrc;

  static infoPrint(User user){
    print('email '+user.userEmail);
    print('password '+user.userPassword);
    print('nick '+user.userNickName);
    // print('profileSrc'+user.userImageSrc);
  }

}