import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'MyApp.dart';
import './Treatment/StateContainer.dart';

const SERVER_DOMAIN = "https://www.farmsoilmoisture.tk/mobile";
final storage = FlutterSecureStorage();

void main() => runApp(new MyApp());
