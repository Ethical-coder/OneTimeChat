import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/cardWidget.dart';
import '../Provider/info_data_provider.dart';
import '../Provider/services_data.dart';

class Chats extends StatelessWidget {
  // ignore: non_constant_identifier_names
  late var newObj;

  @override
  Widget build(BuildContext context) {
    var ref = Provider.of<Info>(context);
    print('seralised');
    newObj = ref.processedData;
    print(newObj);
    return Container(
      alignment: Alignment.center,
      child: ListView.builder(
        itemCount: newObj.keys.length,
        itemBuilder: (context, index) {
          var key = [...newObj.keys];

          var num = key[index];

          return CardWidget(
              num, newObj[num]!['count'].toString(), newObj[num]!['msg']);
        },
      ),
    );
  }
}
