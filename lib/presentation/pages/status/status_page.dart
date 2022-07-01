import 'package:flutter/material.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: const Text(
                  'Log out',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
              const Text(
                'data',
                style: TextStyle(color: Colors.transparent),
              ),
              GestureDetector(
                child: const Text(
                  'My profile',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: ListView.separated(
          separatorBuilder: (context, index) {
            return const Divider(
              height: 1,
              thickness: 2,
            );
          },
          itemCount: 7,
          itemBuilder: (context, index) {
            return const ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              leading: CircleAvatar(),
              title: Text('User Name'),
            );
          },
        ),
      ),
    );
  }
}
