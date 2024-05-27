# Contributing to Dotted

## Setup

1. Download Flutter SDK
2. Clone repository
3. Modify `.env` file and add environment variables
4. Create Google Cloud account and [create maps api key](https://console.cloud.google.com/google/maps-apis/)
5. Start developing! Happy coding 🍻

## Google Maps Setup

1. Get Maps API KEY
2. In Google Cloud, enable "Enable Directions API", "Distance Matrix API", "Maps SDK for Android", and "Maps SDK for iOS" under "APIs & Services"
3. ![Restrict your API keys]("/assets/images/docs/restrict_google_api_key.png")
4. Enable Background Mode and Location in XCode
   - Open Xcode > Runner > Signing & Capabilities
   - ![Turn on Background Modes and Location updates]("/assets/images/docs/xcode-background-modes-location-updates.png")
   - While Simulator is open, in the top menu, click Features > Location > Select a location

## Get Viator API key

- Goto [Viator Partners](https://partnerresources.viator.com/travel-commerce/affiliate/basic-access/golden-path/?source=specs) and follow guide

## Server Setup

1. Follow instructions of Dotted-API CONTRIBUTING.md
2. Set your SUPABASE_URL and SUPABASE_ANON keys from `supabase start`
