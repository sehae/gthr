import 'package:flutter/material.dart';
import 'package:gthr/screens/ProfileScreen/profile_edit.dart';


void main() {
  runApp(const ProfilePage());
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Profile Main Screen',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Content(),
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

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              buildTop(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    buildProfileInfo(),
                    buildContent(),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget buildTop() {
    final bottom = profileHeight / 2;
    final top = coverHeight - profileHeight / 2;
    final buttonPOS = coverHeight + 10;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: buildCoverImage(),
        ),
        Positioned(
          top: top,
          left: 20,
          child: buildProfileImage(),
        ),
        Positioned(
          top: buttonPOS,
          right: 20,
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => profileEdit(),
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  return Colors.white;
                },
              ),
              side: MaterialStateProperty.resolveWith<BorderSide>(
                    (Set<MaterialState> states) {
                  return const BorderSide(
                    color: Color(0xFF1E7251),
                    width: 2.0,
                  );
                },
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Edit Profile',
                style: TextStyle(
                  color: Color(0xFF2C2C30),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCoverImage() => Container (
    child: Image.network(
      'https://betanews.com/wp-content/uploads/2015/09/Windows-10-lock-screen.jpg',
      width: double.infinity,
      height: coverHeight,
      fit: BoxFit.cover,
    ),
  );

  Widget buildProfileImage() => Container(
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

  Widget buildProfileInfo() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 8,),
      const Text(
        'Bill Gates',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      const Text(
        '@billgates',
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      const Text(
        'I am always bussing.',
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      const Row(
        children: [
          Icon(
            Icons.location_on,
            size: 20,
            color: Color(0xFF2C2C30),
          ),
          SizedBox(width: 5,),
          Text(
            'Medina, Washington',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
      Row(
        children: [
          TextButton(
            onPressed: () {
            },
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              overlayColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.transparent;
                  }
                  return Colors.transparent;
                },
              ),
              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return const Color(0xFF4E4C4C).withOpacity(0.5);
                  }
                  return const Color(0xFF4E4C4C);
                },
              ),
            ),
            child: const Row(
              children: [
                Text(
                  '69',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 4,),
                Text(
                  'Friends',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ),
          const SizedBox(width: 10,),
          TextButton(
              onPressed: () {
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                overlayColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.transparent;
                    }
                    return Colors.transparent;
                  },
                ),
                foregroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return const Color(0xFF4E4C4C).withOpacity(0.5);
                    }
                    return const Color(0xFF4E4C4C);
                  },
                ),
              ),
              child: const Row(
                children: [
                  Text(
                    '420',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 4,),
                  Text(
                    'Following',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
          ),
        ],
      ),
    ],
  );

  Widget buildContent() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildContentButton('Posts', 0),
            buildContentButton('Replies', 1),
            buildContentButton("GTHR'D", 2),
            buildContentButton('Likes', 3),
          ],
        ),
        if (selectedIndex == 0) buildPostsContent(),
        if (selectedIndex == 1) buildRepliesContent(),
        if (selectedIndex == 2) buildGthrContent(),
        if (selectedIndex == 3) buildLikesContent(),
      ],
    );
  }

  Widget buildContentButton(String text, int index) {
    final isActive = selectedIndex == index;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isActive ? const Color(0xFFFF4E1A) : Colors.transparent,
            width: 5.0,
          )
        )
      ),
      child: TextButton(
        onPressed: (){
          setState(() {
            selectedIndex = index;
          });
        },
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.transparent;
              }
              return Colors.transparent;
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return const Color(0xFF4E4C4C).withOpacity(0.5);
              }
              return isActive ? const Color(0xFF4E4C4C) : Colors.black;
            },
          ),
        ),
        child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
            )
        ),
      ),
    );
  }

  Widget buildPostsContent() => const Padding(
    padding: EdgeInsets.symmetric(vertical: 20),
    child: Column(
      children: [
        Text(
            '1'
        )
      ],
    ),
  );

  Widget buildRepliesContent() => const Padding(
    padding: EdgeInsets.symmetric(vertical: 20),
    child: Column(
      children: [
        Text(
            '2'
        )
      ],
    ),
  );

  Widget buildGthrContent() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
    child: Column(
      children: [
        Image.network(
            'https://asset-ent.abs-cbn.com/ent/entertainment/media/onemusic/lovebox.jpg?ext=.jpg'
        ),
        Image.network(
            'https://scontent.fmnl8-1.fna.fbcdn.net/v/t39.30808-6/401836757_737590591748457_5740288807220724461_n.jpg?stp=dst-jpg_p843x403&_nc_cat=106&ccb=1-7&_nc_sid=5f2048&_nc_ohc=zW3lI9lyNNkAb7qpwLC&_nc_ht=scontent.fmnl8-1.fna&cb_e2o_trans=q&oh=00_AfARb92ZkIqxiMZf_HvGqwaLlD0l7sqe-SUmUguq4gSjNQ&oe=66259EC4'
        ),
      ],
    ),
  );

  Widget buildLikesContent() => const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
    child: Column(
      children: [
        Text(
            '4'
        )
      ],
    ),
  );

}