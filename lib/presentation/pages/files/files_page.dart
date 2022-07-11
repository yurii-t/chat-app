import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grouped_list/grouped_list.dart';

class FilesPage extends StatefulWidget {
  final List<MessageEntity> filesList;
  const FilesPage({required this.filesList, Key? key}) : super(key: key);

  @override
  State<FilesPage> createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {
  List<MessageEntity> filesItems = [];
  @override
  void initState() {
    filesItems = widget.filesList;
    super.initState();
  }

  void _searchFiles(String query) {
    List<MessageEntity> results = [];
    results = query.isEmpty
        ? widget.filesList
        : widget.filesList
            .where((item) =>
                item.docName.toLowerCase().contains(query.toLowerCase()))
            .toList();

    setState(() {
      filesItems = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14, top: 32), //12),
        child: Column(
          children: [
            TextField(
              onChanged: _searchFiles,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                filled: true,
                fillColor: AppColors.lightGrey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: const Icon(Icons.search),
                hintText: 'Search in files',
                constraints: const BoxConstraints(
                  minHeight: 35,
                  maxHeight: 35,
                ),
                helperStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.lightGreytextFieldSearchHintText,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: GroupedListView<MessageEntity, String>(
                elements: filesItems,
                groupBy: (element) => DateFormat('MMMM yyyy')
                    .format(element.time.toDate())
                    .toString(),
                groupComparator: (value1, value2) => value2.compareTo(value1),
                itemComparator: (item1, item2) =>
                    item1.docName.compareTo(item2.docName),
                order: GroupedListOrder.ASC,
                useStickyGroupSeparators: false,
                groupSeparatorBuilder: (value) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    value,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.numberPhoneTextGrey,
                    ),
                  ),
                ),
                itemBuilder: (c, element) {
                  return Card(
                    elevation: 0,
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: element.docName.contains('.doc')
                          ? SvgPicture.asset('assets/icons/doc.svg')
                          : SvgPicture.asset('assets/icons/pdf.svg'),
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                element.docName,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Text(
                              // ignore: prefer_interpolation_to_compose_strings
                              DateFormat('MMMM d, yyyy')
                                      .format(element.time.toDate()) +
                                  ' at ' +
                                  DateFormat('HH:mm')
                                      .format(element.time.toDate()),

                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.numberPhoneTextGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      subtitle: Text(
                        element.docSize,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.numberPhoneTextGrey,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
