import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restobuy_supplier_flutter/common/constants/strings.dart';
import 'package:restobuy_supplier_flutter/common/extensions/common_fun.dart';
import 'package:restobuy_supplier_flutter/data/core/api_constants.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/api_functions.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/local_data_source_shared_preferences.dart';
import 'package:restobuy_supplier_flutter/data/models/chats_api_res_model.dart';
import 'package:restobuy_supplier_flutter/data/models/status_message_api_res_model.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:restobuy_supplier_flutter/presentation/themes/theme_text.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/lottie_loading.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/no_data_found.dart';

import 'chat_widgets.dart';

class ChatScreen extends StatefulWidget {
  final String disputeId;
  final String supplierName;
  final String ticketId;
  final String disputeReason;

  const ChatScreen({Key? key, required this.disputeId, required this.supplierName, required this.ticketId, required this.disputeReason}) : super(key: key);

  @override
  ChatScreenState createState() {
    return ChatScreenState();
  }
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  late Future<bool> _future;
  late bool isApiDataAvailable = false;
  late bool isMsgSend = false;
  ChatsApiResModel model = ChatsApiResModel();

  @override
  void initState() {
    super.initState();
    _future = getDataFromApi();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> getDataFromApi() async {
    try {
      Map<String, dynamic> body = {};
      body['dispute_id'] = widget.disputeId;

      await ApiFun.apiPostWithBody(ApiConstants.chats, body).then((jsonDecodeData) => {
            model = ChatsApiResModel.fromJson(jsonDecodeData),
          });

      if (model.status == 1) {
        isApiDataAvailable = true;
      }
    } catch (error) {
      print("Error: $error");
    }
    return isApiDataAvailable;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        toolbarHeight: 65,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.black,
                    size: 22,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                const CircleAvatar(
                  backgroundImage: NetworkImage(Strings.imgUrlNotFoundYellowAvatar),
                  maxRadius: 22,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.supplierName,
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
                      ),
                      Text(
                        'Ticket Id - ${widget.ticketId}',
                        style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.sticky_note_2_outlined, color: Colors.black,),
            onPressed: () {
              showIosDialog(context, 'Dispute Reason', widget.disputeReason, 'Close', 'Ok', (){

              });
            },),
        ],
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapShot) {
          if (snapShot.hasData && snapShot.connectionState == ConnectionState.done) {
            if (isApiDataAvailable) {
              List<MessageBubble> messageWidgets = [];

              for (int i = 0; i < model.response!.length; i++) {
                String msgText = model.response![i].message!;
                String msgSender = model.response![i].repliedBy!;
                String currentUser = model.response![i].repliedBy!;

                // print('MSG' + msgSender + '  CURR' + currentUser);

                final msgBubble = MessageBubble(
                    msgText: msgText,
                    msgSender: msgSender,
                    user: currentUser == 'Supplier'? false: true,
                );
                messageWidgets.add(msgBubble);
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      reverse: true,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      children: messageWidgets,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    decoration: kMessageContainerDecoration,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Material(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white,
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0, top: 2, bottom: 2),
                              child: TextField(
                                style: const TextStyle(color: Colors.black),
                                onChanged: (value) {
                                  //messageText = value;
                                },
                                controller: _textEditingController,
                                decoration: kMessageTextFieldDecoration,
                              ),
                            ),
                          ),
                        ),
                        MaterialButton(
                            shape: const CircleBorder(),
                            color: Colors.orange,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: !isMsgSend ? const Icon(
                                Icons.send,
                                color: Colors.white,
                              ) : const CircularProgressIndicator(color: Colors.white,),
                            ),
                          onPressed: () {
                            sendMessage(_textEditingController.text);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return NoDataFound(txt: 'No Message Found', onRefresh: () {});
            }
          } else {
            return const LottieLoading();
          }
        },
      ),
    );
  }

  void sendMessage(String message) async {
    try{
      setState(() {
        isMsgSend = true;
      });

      String? userId = await MySharedPreferences().getUserId();
      Map<String, dynamic> body = {};
      body['dispute_id'] = widget.disputeId;
      body['user_id'] = userId;
      body['message'] = message;

      await ApiFun.apiPostWithBody(ApiConstants.storeChatMessage, body).then((jsonDecodeData) {
        StatusMessageApiResModel statusMessageApiResModel = StatusMessageApiResModel.fromJson(jsonDecodeData);
        if (kDebugMode) {
          print('----Msg : ${statusMessageApiResModel.message}');
        }
        if (statusMessageApiResModel.status == 1) {
          Timer(const Duration(milliseconds: 2000), () {
            setState(() {
              edgeAlert(context, title: 'Message', description: 'Sent');
              isMsgSend = false;
              _textEditingController.clear();
              _future = getDataFromApi();
            });
          });
        }
      });
      // isApiDataAvailable = false;

    } catch(error){
      print("Error: $error");
    }
  }
}

