import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:flutter/material.dart';

class MediaPage extends StatelessWidget {
  final List<MessageEntity> imagesList;
  const MediaPage({
    required this.imagesList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemCount: imagesList.length,
          itemBuilder: (ctx, index) {
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                      image: NetworkImage(
                        imagesList[index].message,
                      ),
                      fit: BoxFit
                          .fill) //Image.network(imagesList[index].message,)
                  ),
              // child: Image.network(
              //   fit: BoxFit.fill,
              //   imagesList[index].message,
              // ),
            );
          },
        ),
      ),
    );
  }
}
