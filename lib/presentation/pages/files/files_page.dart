import 'package:chat_app/presentation/widgets/custom_appbar.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grouped_list/grouped_list.dart';

class FilesPage extends StatefulWidget {
  const FilesPage({Key? key}) : super(key: key);

  @override
  State<FilesPage> createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {
  List<Map<String, String>> _elements = [
    {'name': 'Doc1', 'date': 'June 2022'},
    {'name': 'Doc123', 'date': 'June 2022'},
    {'name': 'ddocu', 'date': 'May 2022'},
    {'name': 'Dddassd', 'date': 'May 2022'},
    {'name': 'Eeasd', 'date': 'May 2022'},
    {'name': 'Ffdasd', 'date': 'April 2022'},
    {'name': 'Fsd', 'date': 'April 2022'},
    {'name': 'Ffda', 'date': 'April 2022'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14, top: 32), //12),
        child: Column(
          children: [
            TextField(
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
              child: GroupedListView<dynamic, String>(
                elements: _elements,
                groupBy: (dynamic element) => element['date'] as String,
                groupComparator: (value1, value2) => value2.compareTo(value1),
                itemComparator: (dynamic item1, dynamic item2) =>
                    item1['name'].compareTo(item2['name']) as int,
                order: GroupedListOrder.ASC,
                useStickyGroupSeparators: false,
                groupSeparatorBuilder: (String value) => Padding(
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
                itemBuilder: (c, dynamic element) {
                  return Card(
                    elevation: 0,
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: SvgPicture.asset('assets/icons/doc.svg'),
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                element['name'] as String,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const Text(
                              'June 7 2022 at 13:00',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.numberPhoneTextGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      subtitle: const Text(
                        '12,3 MB',
                        style: TextStyle(
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
