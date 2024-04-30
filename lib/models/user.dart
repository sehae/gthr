class myUser {
  final String? uid;

  myUser({ required this.uid });

}

class UserData {
  final String? uid;
  final String fname;
  final String lname;
  final String username;
  final String bio;
  final String location;
  final String icon;
  final String header;
  final String email;

  UserData({
    required this.uid,
    required this.fname,
    required this.lname,
    required this.username,
    required this.bio,
    required this.location,
    required this.icon,
    required this.header,
    required this.email
  });
}