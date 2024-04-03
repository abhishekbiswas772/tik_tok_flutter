import 'package:flutter/material.dart';
import 'package:tiktok_clone/controllers/search_controllers/search_controller.dart';
import 'package:tiktok_clone/model/usermodel.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchTxtController = TextEditingController();
  final SearchControllerCustom _searchController = SearchControllerCustom();
  Stream<List<UserModel>>? userStream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: TextFormField(
          decoration: const InputDecoration(
              filled: false,
              hintText: "Search",
              hintStyle: TextStyle(
                fontSize: 18,
                color: Colors.white,
              )),
          controller: _searchTxtController,
          onFieldSubmitted: (result) {
            userStream = _searchController.getUserModel(result);
          },
        ),
      ),
      body: StreamBuilder(
          stream: userStream,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              List<UserModel> userModel = snapshot.data ?? [];
              return ListView.builder(
                  itemCount: userModel.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed("/profile",
                            arguments: {"uid": userModel[index].uid});
                      },
                      child: ListTile(
                        title: Text(
                          userModel[index].name,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        ),
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(userModel[index].profilePics),
                        ),
                      ),
                    );
                  });
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Text(
                  "Search for Users",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text(
                  "Search for Users",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
          })),
    );
  }
}
