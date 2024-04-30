import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/user.dart';
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
  List<bool>? isFriendList;
  late Stream<List<UserList>> _usersStream;

  final double headerHeight = 180;

  int selectedIndex = 0;

  _ContentState() {
    selectedIndex = 0;
    _usersStream = DatabaseService().userLists;
  }

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                buildHeader(),
                if (selectedIndex == 0) buildListContent(),
                if (selectedIndex == 1) buildRequestContent(),
              ],
            ),
          )
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      color: const Color(0xFF1E7251),
      height: headerHeight,
      child: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: buildContent(),
          ),
        ],
      ),
    );
  }

  Widget buildContent(){
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildContentButton('List', 0),
          buildContentButton('Requests', 1),
        ],
      ),
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
                      return Colors.white.withOpacity(0.8);
                    }
                    return isActive ? Colors.white : Colors.white;
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
          ),
        )
    );
  }

  Widget buildListContent(){
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
          populateFriend(),
        ]
    );
  }

  Widget muteContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.horizontal_rule_rounded,
          size: 40,
          color: Colors.black54,
        ),
        SizedBox(height: 10),
        Text(
          'Mute',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        ListTile(
          title: Text('Posts'),
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
          title: Text('Invites'),
          trailing: Switch(
            value: true,
            onChanged: (value) {},
            activeColor: const Color(0xFF1E7251),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "GTHR won't let them know you've muted them.",
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF1E7251),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget notificationsContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.horizontal_rule_rounded,
          size: 40,
          color: Colors.black54,
        ),
        SizedBox(height: 10),
        Text(
          'Notifications',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        ListTile(
          title: Text('Posts'),
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
          title: Text('Events'),
          trailing: Switch(
            value: true,
            onChanged: (value) {},
            activeColor: const Color(0xFF1E7251),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Get notifications when they post or create events.",
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF1E7251),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget populateFriend() {
    return StreamBuilder<List<UserList>>(
      stream: _usersStream,
      builder: (context, snapshot) {
        print('StreamBuilder snapshot: $snapshot');
        if (snapshot.hasData) {
          print('Snapshot data: ${snapshot.data}');
          if (isFriendList == null) {
            isFriendList = List.filled(snapshot.data!.length, true);
          }
          return ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              UserList user = snapshot.data![index];
              return Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: ListTile(
                  title: Text(
                    '${snapshot.data![index].fname} ${snapshot.data![index].lname}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                      '@${snapshot.data![index].username}',
                      style: const TextStyle(
                        fontSize: 16,
                      )
                  ),
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0xFF1E7251),
                    backgroundImage: snapshot.data![index].icon != null
                        ? MemoryImage(base64Decode(snapshot.data![index].icon))
                        : null,
                    child: (snapshot.data![index].icon != null && snapshot.data![index].icon == '')
                        ? Text(
                      snapshot.data![index].fname[0].toUpperCase() ?? '',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    )
                        : null,
                  ),
                  trailing: Padding(
                    padding: EdgeInsets.all(0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              print('Friend button pressed');
                              isFriendList?[index] = !isFriendList![index];
                            });
                          },
                          child: SizedBox(
                            width: 100,
                            height: 30,
                            child: Center(
                              child: Text(isFriendList![index] ? 'Friend' : 'Add Friend'),
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(isFriendList![index] ? Color(0xFF1E7251) : Color(0xFFFFDD0A)),
                            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 0, horizontal: 0)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          ),
                        ),
                        IconButton(
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
                                      backgroundImage: snapshot.data![index].icon != null
                                          ? MemoryImage(base64Decode(snapshot.data![index].icon))
                                          : null,
                                      child: (snapshot.data![index].icon != null && snapshot.data![index].icon == '')
                                          ? Text(
                                        snapshot.data![index].fname[0].toUpperCase() ?? '',
                                        style: TextStyle(
                                          fontSize: 30.0,
                                          color: Colors.white,
                                        ),
                                      )
                                          : null,
                                    ),
                                    SizedBox(height: 10, width: double.infinity),
                                    Text(
                                      snapshot.data![index].username,
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
                      ],
                    ),
                  )
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
          return Text('Error: ${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Widget buildRequestContent(){
    return Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
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
          populateRequests(),
        ]
    );
  }

  Widget populateRequests() {
    return StreamBuilder<List<UserList>>(
      stream: _usersStream,
      builder: (context, snapshot) {
        print('StreamBuilder snapshot: $snapshot');
        if (snapshot.hasData) {
          print('Snapshot data: ${snapshot.data}');
          if (isFriendList == null) {
            isFriendList = List.filled(snapshot.data!.length, true);
          }
          return ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              UserList user = snapshot.data![index];
              return Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: ListTile(
                    title: Text(
                      '${snapshot.data![index].fname} ${snapshot.data![index].lname}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                        '@${snapshot.data![index].username}',
                        style: const TextStyle(
                          fontSize: 16,
                        )
                    ),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xFF1E7251),
                      backgroundImage: snapshot.data![index].icon != null
                          ? MemoryImage(base64Decode(snapshot.data![index].icon))
                          : null,
                      child: (snapshot.data![index].icon != null && snapshot.data![index].icon == '')
                          ? Text(
                        snapshot.data![index].fname[0].toUpperCase() ?? '',
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
          );
        } else if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
          return Text('Error: ${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}