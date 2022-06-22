import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:chat_app/presentation/bloc/user/bloc/user_bloc.dart';
import 'package:chat_app/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                onTap: () => context.router.push(MyProfileRoute()),
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
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserError) {
              print(state.error);
            }
            if (state is UserLoading) {
              return const Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (state is UserLoaded) {
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 1,
                    thickness: 2,
                  );
                },
                itemCount: state.allUsers.length, //7,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () => context.router.push(ChatRoute()),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    leading: CircleAvatar(
                        // backgroundImage:
                        //     NetworkImage(state.allUsers[index].userImage) ?? null,
                        ),
                    title: Text(state.allUsers[index].userName),
                  );
                },
              );
            }

            return const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
