import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gthr/models/user.dart';
import 'package:gthr/shared/loading.dart';
import 'package:provider/provider.dart';

import '../../models/user_list.dart';
import '../../services/database.dart';

class profileEdit extends StatefulWidget {
  const profileEdit({super.key});

  @override
  State<profileEdit> createState() => _profileEditState();
}

class _profileEditState extends State<profileEdit> {
  String fname = '';
  String lname = '';
  String bio = '';
  String location = '';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<myUser?>(context);
    return StreamBuilder(
      stream: DatabaseService(uid: user?.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData? userData = snapshot.data as UserData?;
          return MaterialApp(
            title: 'Profile Edit Screen',
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.chevron_left),
                ),
                title: const Text(
                  'Edit Profile',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
              ),
              body: Content(user: user, userData: userData),
            ),
          );
        } else {
          return const Loading();
        }
      },
    );
  }
}

class Content extends StatefulWidget {
  final myUser? user;
  final UserData? userData;

  const Content({Key? key, required this.user, required this.userData}) : super(key: key);

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  String _currentfname = '';
  String _currentlname = '';
  String _currentbio = '';
  String _currentlocation = '';

  final double coverHeight = 150;
  final double profileHeight = 144;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              buildEditImage(),
              Padding(
                padding: const EdgeInsets.all(20),
                child: buildForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEditImage() {
    final bottom = profileHeight / 2;
    final top = coverHeight - profileHeight / 2;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: buildEditCover(),
        ),
        Positioned(
          top: top,
          left: 20,
          child: buildEditProfile(),
        ),
      ],
    );
  }

  Widget buildEditCover() => Container(
    child: Image.network(
      'https://betanews.com/wp-content/uploads/2015/09/Windows-10-lock-screen.jpg',
      width: double.infinity,
      height: coverHeight,
      fit: BoxFit.cover,
    ),
  );

  Widget buildEditProfile() => Container(
    padding: const EdgeInsets.all(5),
    decoration: const BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
    ),
    child: CircleAvatar(
      radius: profileHeight / 2,
      backgroundColor: Colors.grey.shade800,
      backgroundImage: const NetworkImage(
          'https://cdn.britannica.com/47/188747-050-1D34E743/Bill-Gates-2011.jpg'),
    ),
  );

  Widget buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'First Name',
              labelStyle: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
              border: InputBorder.none,
              fillColor: Colors.black12,
              filled: true,
            ),
            obscureText: false,
            maxLength: 50,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your first name';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _currentfname = value;
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Last Name',
              labelStyle: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
              border: InputBorder.none,
              fillColor: Colors.black12,
              filled: true,
            ),
            obscureText: false,
            maxLength: 50,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your last name';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _currentlname = value;
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Bio',
              labelStyle: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
              border: InputBorder.none,
              fillColor: Colors.black12,
              filled: true,
            ),
            obscureText: false,
            maxLines: 3,
            maxLength: 160,
            onChanged: (value) {
              setState(() {
                _currentbio = value;
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Location',
              labelStyle: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
              border: InputBorder.none,
              fillColor: Colors.black12,
              filled: true,
            ),
            obscureText: false,
            maxLength: 30,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your location';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _currentlocation = value;
              });
            },
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await DatabaseService(uid: widget.user!.uid).updateUserData(
                  _currentfname.isEmpty ? widget.userData!.fname : _currentfname,
                  _currentlname.isEmpty ? widget.userData!.lname : _currentlname,
                  widget.userData?.username ?? '',
                  _currentbio.isEmpty ? widget.userData!.bio : _currentbio,
                  _currentlocation.isEmpty ? widget.userData!.location : _currentlocation,
                  widget.userData?.email ?? '',
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Profile updated successfully'),
                  ),
                );
                Navigator.of(context).pop();
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  return const Color(0xFF1E7251);
                },
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
