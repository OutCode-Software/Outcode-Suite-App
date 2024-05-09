import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'flavor_config.dart';
import 'main.dart' as main_file;

void main() async {
  await dotenv.load(fileName: '.uat.env');
  FlavorConfig(
      flavor: Flavor.uat,
      values: FlavorValues(
          baseUrl: dotenv.env['BASEURL']!,
          useAnalytics: false,
          logsResponse: true,
          clickUpApiKey: dotenv.env['CLICKUP_API_KEY']!,
          clickUpListId: dotenv.env['CLICKUP_LIST_ID']!));
  main_file.main();
}
