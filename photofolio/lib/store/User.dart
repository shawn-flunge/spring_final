class User{
  String userEmail;
  String userPassword;
  String userNickName;
  String userImageSrc;

  static infoPrint(User user){
    print('email '+user.userEmail);
    print('password '+user.userPassword);
    print('nick '+user.userNickName);
    // print('profileSrc'+user.userImageSrc);
  }

}