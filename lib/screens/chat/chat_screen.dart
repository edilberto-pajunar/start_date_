import 'package:flutter/material.dart';
import 'package:start_date/models/match_model.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    super.key,
    this.match,
  });

  final Match? match;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var messageCount = (match!.chat == null) ? 0 : match!.chat!.messages.length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Column(
          children: [
            // CircleAvatar(
            //   radius: 15,
            //   backgroundImage: NetworkImage(match.matchedUser.imageUrls[0]),
            // ),
            // Text(userMatch.matchedUser.name),
          ],
        ),
      ),
      body: Column(
        children: [
          CircleAvatar(
            radius: 15.0,
            backgroundImage: NetworkImage(match!.matchUser.imageUrls[0]),
          ),
          Text(
            match!.matchUser.name,
          ),
          // Expanded(
          //   child: SingleChildScrollView(
          //     child: match.chat != null
          //         ? ListView.builder(
          //             shrinkWrap: true,
          //             itemCount: match.chat[0].messages.length,
          //             itemBuilder: (context, index) {
          //               return ListTile(
          //                 title: match.chat[0].messages[index].senderId == 1
          //                     ? Align(
          //                         alignment: Alignment.topRight,
          //                         child: Container(
          //                           padding: const EdgeInsets.all(8.0),
          //                           decoration: BoxDecoration(
          //                             borderRadius: BorderRadius.circular(8.0),
          //                             color: Colors.black,
          //                           ),
          //                           child: Text(
          //                             match.chat[0].messages[index].message,
          //                             style:
          //                                 theme.textTheme.bodyMedium!.copyWith(
          //                               color: Colors.white,
          //                             ),
          //                           ),
          //                         ),
          //                       )
          //                     : Align(
          //                         alignment: Alignment.topLeft,
          //                         child: Row(
          //                           children: [
          //                             CircleAvatar(
          //                               radius: 15,
          //                               backgroundImage: NetworkImage(
          //                                   match.matchedUser.imageUrls[0]),
          //                             ),
          //                             const SizedBox(width: 10.0),
          //                             Container(
          //                               padding: const EdgeInsets.all(8.0),
          //                               decoration: BoxDecoration(
          //                                 borderRadius:
          //                                     BorderRadius.circular(8.0),
          //                                 color: Colors.grey,
          //                               ),
          //                               child: Text(
          //                                 match.chat[0].messages[index].message,
          //                                 style: theme.textTheme.bodyMedium!
          //                                     .copyWith(
          //                                   color: Colors.white,
          //                                 ),
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                       ),
          //               );
          //             },
          //           )
          //         : const SizedBox(),
          //   ),
          // ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Type here...",
                        contentPadding:
                            EdgeInsets.only(left: 20, bottom: 5, top: 5),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
