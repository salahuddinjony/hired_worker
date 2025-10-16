# Customer Help & Support - Implementation

## Overview
This implementation provides a help and support ticket creation system using GetX state management and API integration.

## API Endpoint
- **URL**: `{{AMA}}/contractors/create_support`
- **Method**: POST
- **Content-Type**: application/json

## Request Body
```json
{
    "title": "Issue title here",
    "details": "Detailed description of the issue"
}
```

## Response Format
```json
{
    "success": true,
    "message": "Support ticket created successfully"
}
```

## Features Implemented

### 1. Controller (`create_help_controller.dart`)
- **Form Controllers**: TextEditingController for title and details
- **Validation**: Checks for empty fields before submission
- **Loading State**: Shows loading indicator during API call
- **API Integration**: POST request to create support endpoint
- **Success Handling**: 
  - Shows success message
  - Clears form fields
  - Navigates back to previous screen
- **Error Handling**: Displays appropriate error messages

### 2. Screen (`customer_help_support_screen.dart`)
- **AppBar**: Custom app bar with back button
- **Help Image**: Visual indicator for help section
- **Title Field**: Input for issue title
- **Details Field**: Multi-line text area for issue details (5 lines)
- **Submit Button**: 
  - Shows "Sending..." when loading
  - Disabled during API call
  - Shows "Send" when ready

## How It Works

1. User enters issue title and details
2. Clicks "Send" button
3. Form validates inputs (checks for empty fields)
4. If valid, shows loading state ("Sending...")
5. Makes POST API call with title and details
6. On success:
   - Shows success toast message
   - Clears the form
   - Navigates back after 500ms
7. On error:
   - Shows error toast message
   - Form remains populated for retry

## Controller Properties

```dart
// Text editing controllers
TextEditingController titleController
TextEditingController detailsController

// Loading state
RxBool isLoading

// Methods
Future<void> createSupportTicket()
```

## Usage

Navigate to the screen:
```dart
Get.to(() => CustomerHelpSupportScreen());
```

The controller is automatically initialized using `Get.put()`.

## Validation Rules

1. **Title**: Required, cannot be empty
2. **Details**: Required, cannot be empty

## UI States

1. **Idle State**: Form ready for input
2. **Loading State**: Button shows "Sending...", disabled
3. **Success State**: Toast message, form clears, navigate back
4. **Error State**: Toast message with error details

## Toast Messages

- **Success**: Green toast with success message from API
- **Error**: Red toast with error message
- **Validation**: Red toast for empty fields

## Dependencies
- GetX for state management
- http for API calls
- Fluttertoast for toast notifications

## API Response Handling

The controller handles both string and map responses:
```dart
final responseData = response.body is String 
    ? jsonDecode(response.body) 
    : response.body;
```

## Error Scenarios Handled

1. Empty title field
2. Empty details field
3. Network errors
4. API errors (non-200 status codes)
5. JSON parsing errors
6. General exceptions

## Auto-cleanup

The controller automatically disposes of text controllers when closed to prevent memory leaks.
