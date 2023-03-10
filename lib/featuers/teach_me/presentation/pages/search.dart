import 'package:flutter/material.dart';
import 'package:teachme/core/classes/language_constants.dart';
import 'package:teachme/featuers/teach_me/data/datasourse/models/data.dart';
import 'package:teachme/featuers/teach_me/presentation/widgets/chat_item.dart';
import 'package:teachme/featuers/teach_me/presentation/widgets/custom_textfield.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({ Key? key }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  buildBody(){
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
          children: [
            getHeader(),
            getChats(),
          ]
      ),
    );
  }

  getHeader(){
    return
      Container(
          padding: EdgeInsets.fromLTRB(0, 60, 0, 5),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                        // alignment: Alignment.,
                        child: Text(translation(context).search,
                          style: TextStyle(fontSize: 28, color: Colors.black87, fontWeight: FontWeight.w600)
                          ,)
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              CustomTextBox(hint: "Search", prefix: Icon(Icons.search, color: Colors.grey), ),
            ],
          )
      );
  }

  getChats(){
    return
       ListView(
            padding: EdgeInsets.only(top: 10),
            shrinkWrap: true,
            children: List.generate(chats.length,
                    (index) => SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: ChatItem(chats[index],
                  onTap: (){

                  },
                ),
                    )
            )
      );
  }
}