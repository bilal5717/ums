import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();
  List<String> messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AlgoOracle'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type message...',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    sendMessage(_controller.text);
                  },
                  child: Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void sendMessage(String message) async {
    setState(() {
      messages.add('You: $message');
    });
    _controller.clear();

    // Send message to chatbot backend and get response
    Uri url = Uri.parse("http://127.0.0.1/ums_api/teacher/messages.php");
    String response = await fetchResponseFromBackend(url, message);

    setState(() {
      messages.add('AlgoOracle: $response');
    });
  }

  Future<String> fetchResponseFromBackend(Uri url, String message) async {
    try {
      // Send HTTP request to backend
      final response = await http.post(
        url,
        body: {'message': message},
      );

      if (response.statusCode == 200) {
        // Parse response and return message from chatbot
        return response.body;
      } else {
        throw Exception('Failed to fetch response');
      }
    } catch (e) {
      print('Error: $e');
      return 'Error fetching response';
    }
  }
}


