import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const FriendsPage());
}

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
  final double headerHeight = 180;

  int selectedIndex = 0;

  _ContentState() {
    selectedIndex = 0;
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
          child: Column(
            children: [
              buildHeader(),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    if (selectedIndex == 0) buildListContent(),
                    if (selectedIndex == 1) buildRequestContent(),
                  ],
                ),
              )
            ],
          ),
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
          TextField(
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
        ]
    );
  }

  Widget buildRequestContent(){
    return Column(
        children: [
          TextField(
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
        ]
    );
  }
}