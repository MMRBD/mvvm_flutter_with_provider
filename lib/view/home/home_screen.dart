import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/response/api_response.dart';
import 'home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel viewModel = HomeViewModel();

  @override
  void initState() {
    viewModel.fetchMoviesListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ChangeNotifierProvider<HomeViewModel>(
        create: (context) => viewModel,
        child: Consumer<HomeViewModel>(
          builder: (context, value, child) {
            switch (value.userList.status) {
              case Status.loading:
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                );
              case Status.error:
                return Center(
                  child: Text(
                    value.userList.message.toString(),
                  ),
                );
              case Status.success:
                return ListView.builder(
                    itemCount: value.userList.data?.data.length,
                    itemBuilder: (context, index) {
                      final user = value.userList.data?.data[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            //set border radius more than 50% of height and width to make circle
                          ),
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(user!.avatar!),
                                const SizedBox(width: 16),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${user.firstName} ${user.lastName}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text("${user.email}")
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });

              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
