
import 'package:flutter/material.dart';
import 'channel_list_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool useXtream = true;
  final TextEditingController hostCtrl = TextEditingController();
  final TextEditingController userCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  final TextEditingController m3uCtrl = TextEditingController();

  void _login() {
    if (useXtream) {
      final url = '\${hostCtrl.text}/player_api.php?username=\${userCtrl.text}&password=\${passCtrl.text}';
      Navigator.push(context, MaterialPageRoute(
        builder: (_) => ChannelListScreen(apiUrl: url, useXtream: true),
      ));
    } else {
      Navigator.push(context, MaterialPageRoute(
        builder: (_) => ChannelListScreen(apiUrl: m3uCtrl.text, useXtream: false),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Magoo Player')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SwitchListTile(
              title: Text('Usar Xtream Codes'),
              value: useXtream,
              onChanged: (v) => setState(() => useXtream = v),
            ),
            if (useXtream) ...[
              TextField(controller: hostCtrl, decoration: InputDecoration(labelText: 'Host')),
              TextField(controller: userCtrl, decoration: InputDecoration(labelText: 'Usuário')),
              TextField(controller: passCtrl, decoration: InputDecoration(labelText: 'Senha')),
            ] else
              TextField(controller: m3uCtrl, decoration: InputDecoration(labelText: 'URL M3U')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _login, child: Text('Entrar')),
          ],
        ),
      ),
    );
  }
}
