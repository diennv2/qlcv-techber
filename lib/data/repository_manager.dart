import 'package:mobile_rhm/data/local/database_helper.dart';
import 'package:mobile_rhm/data/network/api/api_helper.dart';

import 'prefs/preference_helper.dart';

abstract class RepositoryManager
    implements DatabaseHelper, PreferenceHelper, ApiHelper {}
