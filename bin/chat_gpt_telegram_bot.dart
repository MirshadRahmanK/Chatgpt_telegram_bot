import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

import 'config.dart';

void main() async {
  var BOT_TOKEN = bot_toCken;
  final username = (await Telegram(BOT_TOKEN).getMe()).username;
  var teledart = TeleDart(BOT_TOKEN, Event(username!));

  teledart.onCommand('start').listen((event) async {
    event.replyPhoto('https://telegra.ph/file/199fdb88c1abddfef064b.jpg',
        caption: 'Send Your question\n /code');
  });

  teledart.onMessage().listen((event) async {
    try {
      final chatGpt = ChatGpt(apiKey: chat_gpt_api);
      final testPrompt = event.text;
      final testRequest = CompletionRequest(
          prompt: testPrompt,
          model: ChatGptModel.textDavinci003.key,
          maxTokens: 900);
      final result = await chatGpt.createCompletion(testRequest);
      event.reply(result!);
    } catch (e) {
      print('Error');
    }
  });

  teledart.onCommand('code').listen((event) {
    event.reply('https://github.com/MirshadRahmanK/Chatgpt_telegram_bot');
  });

  teledart.start();
}
