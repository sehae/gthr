import 'package:flutter/material.dart';

class profileEdit extends StatefulWidget {
  const profileEdit({super.key});

  @override
  State<profileEdit> createState() => _profileEditState();
}

class _profileEditState extends State<profileEdit> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Edit Screen',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
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
        body: const Content(),
      ),
    );
  }
}

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  final double coverHeight = 150;
  final double profileHeight = 144;
  //var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget> [
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

  Widget buildEditCover() => Container (
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
      radius: profileHeight/2,
      backgroundColor: Colors.grey.shade800,
      backgroundImage: const NetworkImage(
          'https://cdn.britannica.com/47/188747-050-1D34E743/Bill-Gates-2011.jpg'
      ),
    ),
  );

  Widget buildForm() {
    return Form(
      //key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Name',
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
          ),
          const SizedBox(height: 20,),
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
          ),
          const SizedBox(height: 20,),
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
          ),
          ElevatedButton(
              onPressed: (){},
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



