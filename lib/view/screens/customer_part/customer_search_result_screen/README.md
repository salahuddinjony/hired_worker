# Customer Search Result Screen - Implementation

## Overview
This implementation provides real-time category search functionality using GetX state management and API integration.

## API Endpoint
- **URL**: `{{AMA}}/categories`
- **Method**: GET
- **Query Parameter**: `searchTerm` (string)

## Features Implemented

### 1. Controller (`search_category_controller.dart`)
- **Real-time Search**: Listens to text field changes with 500ms debounce
- **Loading States**: Manages loading, success, error, and empty states
- **Observable Results**: Uses RxList for reactive UI updates
- **API Integration**: Calls the categories API with searchTerm parameter
- **Error Handling**: Properly handles API errors and displays messages

### 2. Screen (`customer_search_result_screen.dart`)
- **Search Input**: Text field with search icon and loading indicator
- **Dynamic Results**: 
  - Shows search prompt when field is empty
  - Displays loading indicator during API call
  - Shows "No results found" when search returns empty
  - Lists categories in cards when results are available
- **Category Cards**: Display name, image, creation date
- **Result Count**: Shows number of results found

## How It Works

1. User types in the search field
2. After 500ms of inactivity (debounce), API call is triggered
3. Loading indicator appears in the search field suffix
4. API is called with `searchTerm` query parameter
5. Results are parsed and displayed in real-time
6. UI updates reactively based on the status

## Key Components

### Controller Properties:
```dart
- searchController: TextEditingController
- searchResults: RxList<Datum> (observable list)
- isLoading: RxBool (loading state)
- status: Rx<RxStatus> (overall status)
```

### API Call:
```dart
Response response = await ApiClient.getData(
  ApiUrl.categories,
  query: {'searchTerm': searchTerm},
);
```

### Debounce Logic:
- Prevents excessive API calls
- Waits 500ms after user stops typing
- Cancels previous timer if user continues typing

## Usage

Navigate to the screen:
```dart
Get.to(() => CustomerSearchResultScreen());
```

The controller is automatically initialized using `Get.put()`.

## UI States

1. **Empty State**: Initial state with search prompt
2. **Loading State**: Shows loading indicator while fetching
3. **Success State**: Displays search results in a list
4. **Error State**: Shows "No results found" message

## Dependencies
- GetX for state management
- http for API calls
- Customer Category Model for data parsing
