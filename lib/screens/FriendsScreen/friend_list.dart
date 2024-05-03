import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/user_list.dart';
import '../../services/database.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Friend List Screen',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
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
  late Stream<List<UserList>> _usersStream;

  final double headerHeight = 180;

  int selectedIndex = 0;

  _ContentState() {
    selectedIndex = 0;
    _usersStream = DatabaseService().userLists;
  }

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildHeader(),
          Expanded(
            child: Padding(
            padding: const EdgeInsets.all(0),
            child: selectedIndex == 0
                ? buildFriendStream()
                : buildRequestStream(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      color: const Color(0xFF1E7251),
      height: headerHeight,
      child: Column(
        children: [
          Expanded(child: Container()),
          buildContent(),
        ],
      ),
    );
  }

  Widget buildContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildContentButton('List', 0),
        buildContentButton('Requests', 1),
      ],
    );
  }

  Widget buildContentButton(String text, int index) {
    final isActive = selectedIndex == index;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isActive ? const Color(0xFFFFDD0A) : Colors.transparent,
                width: 5,
              ),
            ),
          ),
          child: TextButton(
            onPressed: () {
              setState(() {
                selectedIndex = index;
              });
            },
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith(
                    (states) =>
                isActive ? Colors.white : Colors.white.withOpacity(0.8),
              ),
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
            child: Text(
              text,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFriendStream() {
    return StreamBuilder<List<UserList>>(
      stream: _usersStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return Column(
            children: [
              buildListSearch(),
              buildListContent(snapshot.data!),
            ],
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }

  Widget buildListSearch() {
    return Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
            child: TextField(
              controller: _controller,
              onChanged: (text) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _controller.text.isEmpty
                    ? null
                    : IconButton(onPressed: (){
                  setState(() {
                    _controller.clear();
                  });
                },
                  icon: const FaIcon(
                    FontAwesomeIcons.solidCircleXmark,
                    size: 20,
                    color: Colors.black38,
                  ),
                ),
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(color: Colors.black12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(color: Colors.black12),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(color: Colors.black12),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
                fillColor: Colors.black12,
                filled: true,
              ),
            ),
          ),
          ListTile(
            title: const Text('Sort by Default'),
            trailing: IconButton(
              icon: const Icon(Icons.filter_alt),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.horizontal_rule_rounded,
                            size: 40,
                            color: Colors.black54,
                          ),
                          Text(
                            'Sort by',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          ListTile(
                              title: const Text('Default'),
                              onTap: () {
                                Navigator.pop(context, 1);
                              },
                              trailing: const FaIcon(
                                FontAwesomeIcons.solidCircleDot,
                                color: Color(0xFF1E7251),
                                size: 25,
                              )
                          ),
                          ListTile(
                              title: const Text('Date added: latest'),
                              onTap: () {
                                Navigator.pop(context, 2);
                              },
                              trailing: const FaIcon(
                                FontAwesomeIcons.circle,
                                color: Color(0xFF1E7251),
                                size: 25,
                              )
                          ),
                          ListTile(
                              title: const Text('Dated added: earliest'),
                              onTap: () {
                                Navigator.pop(context, 3);
                              },
                              trailing: const FaIcon(
                                FontAwesomeIcons.circle,
                                color: Color(0xFF1E7251),
                                size: 25,
                              )
                          ),
                        ],
                      );
                    }
                );
              },
            ),
          ),
        ]
    );
  }

  Widget buildListContent(List<UserList> users) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Padding(
              padding: const EdgeInsets.only(bottom: 15, right: 0),
              child: ListTile(
                  title: Text(
                    '${user.fname} ${user.lname}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    '@${user.username}',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color(0xFF1E7251),
                    backgroundImage: user.icon != null
                        ? MemoryImage(base64Decode(user.icon))
                        : null,
                    child: (user.icon.isEmpty)
                        ? Text(
                      user.fname[0].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    )
                        : null,
                  ),
                  trailing: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(padding: const EdgeInsets.all(0),
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    print('Friend button pressed');
                                  });
                                },
                                child: SizedBox(
                                  width: 100,
                                  height: 30,
                                  child: Center(
                                    child: Text( 'Friend'),
                                  ),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF1E7251)),
                                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 0, horizontal: 0)),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                  ),
                                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: IconButton(
                                icon: const Icon(Icons.more_horiz),
                                onPressed: () {
                                  showModalBottomSheet<int>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          SizedBox(height: 20, width: double.infinity),
                                          CircleAvatar(
                                            radius: 40,
                                            backgroundColor: Color(0xFF1E7251),
                                            backgroundImage: user.icon != null
                                                ? MemoryImage(base64Decode(user.icon))
                                                : null,
                                            child: (user.icon != null && user.icon == '')
                                                ? Text(
                                              user.fname[0].toUpperCase() ?? '',
                                              style: TextStyle(
                                                fontSize: 30.0,
                                                color: Colors.white,
                                              ),
                                            )
                                                : null,
                                          ),
                                          SizedBox(height: 10, width: double.infinity),
                                          Text(
                                            user.username,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          ListTile(
                                              title: Center(child: const Text('Manage Notifications')),
                                              onTap: () {
                                                Navigator.pop(context, 1);
                                                showModalBottomSheet(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return notificationsContent();
                                                  },
                                                );
                                              }
                                          ),
                                          ListTile(
                                            title: Center(child: const Text('Mute')),
                                            onTap: () {
                                              Navigator.pop(context, 2);
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return muteContent();
                                                },
                                              );
                                            },
                                          ),
                                          ListTile(
                                            title: Center(child: const Text('Cancel')),
                                            onTap: () => Navigator.pop(context, 3),
                                          ),
                                        ],
                                      );
                                    },
                                  ).then((value) {
                                    if (value != null) {
                                      print('Selected value: $value');
                                    }
                                  });
                                },
                              ),
                            ),
                          ]
                      )
                  )
              )
          );
        }
    ),
    );
  }

  Widget buildRequestStream(){
    return StreamBuilder<List<UserList>>(
      stream: _usersStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return Column(
            children: [
              buildRequestSearch(),
              buildRequestContent(snapshot.data!),
            ],
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }

  Widget buildRequestSearch() {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
      child: TextField(
        controller: _controller,
        onChanged: (text) {
          setState(() {});
        },
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _controller.text.isEmpty
              ? null
              : IconButton(onPressed: (){
            setState(() {
              _controller.clear();
            });
          },
            icon: const FaIcon(
              FontAwesomeIcons.solidCircleXmark,
              size: 20,
              color: Colors.black38,
            ),
          ),
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(color: Colors.black12),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(color: Colors.black12),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(color: Colors.black12),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          fillColor: Colors.black12,
          filled: true,
        ),
      ),
    );
  }

  Widget buildRequestContent(List<UserList> users) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: ListTile(
                title: Text(
                  '${user.fname} ${user.lname}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                    '@${user.username}',
                    style: const TextStyle(
                      fontSize: 16,
                    )
                ),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Color(0xFF1E7251),
                  backgroundImage: user.icon != null
                      ? MemoryImage(base64Decode(user.icon))
                      : null,
                  child: (user.icon != null && user.icon == '')
                      ? Text(
                    user.fname[0].toUpperCase() ?? '',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  )
                      : null,
                ),
                trailing: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: (){},
                        icon: const FaIcon(
                          FontAwesomeIcons.solidCircleCheck,
                          color: Color(0xFF1E7251),
                          size: 30,
                        ),
                      ),
                      IconButton(
                        onPressed: (){},
                        icon: const FaIcon(
                          FontAwesomeIcons.circleXmark,
                          color: Color(0xFF1E7251),
                          size: 30.0,
                        ),
                      ),
                    ],
                  ),
                )
            ),
          );
        },
      ),
    );
  }

  Widget muteContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Icon(
          Icons.horizontal_rule_rounded,
          size: 40,
          color: Colors.black54,
        ),
        const SizedBox(height: 10),
        const Text(
          'Mute',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        ListTile(
          title: const Text('Posts'),
          trailing: Switch(
            value: false,
            onChanged: (value) {
              setState(() {
                print('Posts switch: $value');
                value = !value;
              });
            },
            activeColor: const Color(0xFF1E7251),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey,
          ),
        ),
        ListTile(
          title: const Text('Invites'),
          trailing: Switch(
            value: true,
            onChanged: (value) {},
            activeColor: const Color(0xFF1E7251),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "GTHR won't let them know you've muted them.",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF1E7251),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget notificationsContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Icon(
          Icons.horizontal_rule_rounded,
          size: 40,
          color: Colors.black54,
        ),
        const SizedBox(height: 10),
        const Text(
          'Notifications',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        ListTile(
          title: const Text('Posts'),
          trailing: Switch(
            value: false,
            onChanged: (value) {
              setState(() {
                print('Posts switch: $value');
                value = !value;
              });
            },
            activeColor: const Color(0xFF1E7251),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey,
          ),
        ),
        ListTile(
          title: const Text('Events'),
          trailing: Switch(
            value: true,
            onChanged: (value) {},
            activeColor: const Color(0xFF1E7251),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "Get notifications when they post or create events.",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF1E7251),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

}