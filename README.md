# App Quan Ly Cong Viet Techber

## Getting Started

NOTE: Flutter SDK: 3.19.6

This project is a starting point for a Flutter application.

#Project structure

/app_service: include all app service

/app_widgets: store all global widget for app

/bindings: binding for app level

/core:
 + constants
 + languages
 + theme
 + utils
 + values: assets, colors, dimens, font

/data:
 + local: use Hive as local database
 + network: use Dio
 + prefs: Shared preference

/di: Dependencies injection (GetIT lib)

/modules: Include page
 + Page structure
    - binding
    - logic
    - state
    - view

/routers: 

Plugin for Android Studio or Intej IDE: 
1. GetX 
2. GetX Snippets
3. Dart data class
4. Json to dart

Dependencies:
1. get: version -> GetX 
2. cupertino_icons: ^1.0.2
3. connectivity: ^3.0.6 -> control connect 
4. shared_preferences: ^2.0.6 
5. dio: ^4.0.4 -> http client
6. get_it: ^7.2.0 -> For dependencies injection
7. hive_flutter: ^1.1.0 -> Use as local database

Worked: 
1. Multi language -> done
2. Depend injection -> done
3. Structure app -> done 
4. Repository -> done




