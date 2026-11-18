# Game Giveaway Finder (Flutter)

A student Flutter assignment that reads giveaway information from the GamerPower API and displays it in a responsive `GridView`.

## Features

1. Bottom navigation: Games, Favorites, Settings.
2. Games screen: fetches giveaway records from the API and displays cards in a grid; pull down or tap refresh to reload.
3. Detail screen: displays the giveaway image, title, value, platforms, end date, description and claiming instructions; opens the giveaway website.
4. Settings screen:
   - Switch between light and dark mode.
   - Select a colour theme (Purple, Blue, Green, Orange, Pink or Teal).
5. Favorites: save/remove items using the heart button on a giveaway card.
6. Loading, empty, image-loading and API-error states.

## API

`https://www.gamerpower.com/api/giveaways`

The response is a JSON array. The app reads fields including `id`, `title`, `worth`, `thumbnail`, `image`, `description`, `instructions`, `type`, `platforms`, `end_date`, `open_giveaway_url`, `status` and `users`.

## Setup

1. Create a new Flutter project:

   ```bash
   flutter create game_giveaway_finder
   ```

2. Copy this package's `lib` folder and `pubspec.yaml` into the new project (replace the generated files).
3. Make sure Android has internet permission. In `android/app/src/main/AndroidManifest.xml`, add this line directly inside the `<manifest>` element, before `<application>`:

   ```xml
   <uses-permission android:name="android.permission.INTERNET" />
   ```

   Flutter Android templates may already include this permission; avoid adding it twice.

4. Run:

   ```bash
   flutter pub get
   flutter run
   ```

## Notes

- This assignment uses live API data; an internet connection is required.
- The theme and favourites are kept in memory and reset when the app process is restarted. Add `shared_preferences` only if persistent settings are required by your instructor.
- Giveaway availability and end dates can change. Always check the official giveaway page before claiming an offer.
