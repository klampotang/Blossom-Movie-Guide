# 🌸 BlossomMovieGuide

A SwiftUI iOS app for browsing trending and top-rated movies/TV shows, checking out upcoming releases, watching trailers, and searching for titles — powered by [TMDB](https://www.themoviedb.org/documentation/api) and the [YouTube Data API](https://developers.google.com/youtube/v3).

This project was built while following an iOS development tutorial on YouTube.

## Features

- **Home** — A hero banner with a random trending title, plus horizontally scrolling rows for Trending Movies, Trending TV, Top Rated Movies, and Top Rated TV.
- **Upcoming** — A vertical list of upcoming movie releases.
- **Search** — Search for movies or TV shows, with a toggle to switch between the two.
- **Title Detail** — Tapping any title fetches and plays its trailer (via an embedded YouTube player) alongside its overview.

<!-- Screenshots coming soon! -->

## Tech Stack

- Swift & SwiftUI
- `@Observable` view models for state management
- `async/await` for networking
- `WKWebView` for embedded YouTube trailer playback
- [TMDB API](https://www.themoviedb.org/documentation/api) for movie/TV data
- [YouTube Data API v3](https://developers.google.com/youtube/v3) for trailer search

## Project Structure

```
BlossomMovieGuide/
├── Models/          # Data models & view models (Title, ViewModel, SearchViewModel, ...)
├── Network/         # API config + networking (DataFetcher, YoutubeDataFetcher, ...)
├── Views/           # SwiftUI views (HomeView, SearchView, UpcomingView, TitleDetailView, ...)
├── Assets.xcassets  # App colors/assets
└── Constants.swift  # Shared strings & constants
```

## Getting Started

### Requirements

- Xcode 16+
- iOS 18+ simulator or device

### Setup

1. Clone the repo:

   ```bash
   git clone https://github.com/<your-username>/BlossomMovieGuide.git
   cd BlossomMovieGuide
   ```

2. Get your own API keys:
   - A [TMDB API key](https://www.themoviedb.org/settings/api)
   - A [YouTube Data API v3 key](https://console.cloud.google.com/apis/library/youtube.googleapis.com)

3. Copy the example config and fill in your keys:

   ```bash
   cp BlossomMovieGuide/Network/APIConfig.example.json BlossomMovieGuide/Network/APIConfig.json
   ```

   Then edit `APIConfig.json` with your own keys:

   ```json
   {
       "tmdbBaseURL": "https://api.themoviedb.org",
       "tmdbAPIKey": "YOUR_TMDB_API_KEY",

       "youtubeBaseURL": "https://youtube.com/embed",
       "youtubeAPIKey": "YOUR_YOUTUBE_API_KEY",
       "youtubeSearchURL": "https://www.googleapis.com/youtube/v3/search"
   }
   ```

   `APIConfig.json` is gitignored, so your keys stay local.

4. Open `BlossomMovieGuide.xcodeproj` in Xcode and hit Run.

## Roadmap

- [ ] Download button functionality
- [ ] Additional screenshots/preview

## Acknowledgements

Built by following a YouTube tutorial series on building a movie/TV guide app in SwiftUI.
