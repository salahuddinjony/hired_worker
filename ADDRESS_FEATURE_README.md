# Address Management Feature

## Overview
This implementation adds a comprehensive address management system to the customer profile edit screen. Users can:
1. Click on "Additional Address" to open a bottom sheet with saved addresses
2. Add new addresses with a map picker
3. Save address details (type, flat/villa number, directions)
4. Select from saved addresses

## Files Created/Modified

### New Files:
1. **`lib/view/screens/customer_part/profile/model/address_model.dart`**
   - Contains the `SavedAddress` model with all address properties
   - Includes methods for JSON serialization and copying

2. **`lib/view/screens/customer_part/profile/widgets/address_selection_bottom_sheet.dart`**
   - Bottom sheet UI that displays saved addresses
   - Shows "Add New Address" button
   - Displays list of saved addresses with radio button selection
   - Matches the design from the first image (address list)

3. **`lib/view/screens/customer_part/profile/widgets/add_address_dialog.dart`**
   - **Now a Bottom Sheet** for adding address details (not a dialog)
   - Appears AFTER map location is selected and confirmed
   - Address type selection (Home, Work, Other) with chips
   - Pre-filled address field from map
   - Fields for flat/villa number and directions
   - Matches the design from the image you provided
   - **Fixed Obx error** by using StatefulWidget with setState instead

### Modified Files:
1. **`lib/view/screens/customer_part/profile/controller/customer_profile_controller.dart`**
   - Added `savedAddresses` list to store addresses
   - Removed `tempLatitude` and `tempLongitude` (no longer needed)
   - Added methods:
     - `showAddressBottomSheet()` - Opens the address selection bottom sheet
     - `showAddAddressDialog()` - **Now navigates to map first**, then shows address details bottom sheet
     - `addNewAddress()` - Adds a new address with latitude/longitude parameters
     - `selectAddress()` - Selects an address from the list
     - `getSelectedAddress()` - Returns the currently selected address
   - **Fixed Obx error** by removing reactive programming from dialog

2. **`lib/view/screens/customer_part/profile/edit_customer_profile_screen/edit_customer_profile_screen.dart`**
   - Made "Additional Address" clickable with `GestureDetector`
   - Shows placeholder text when no address is selected
   - Updates text to show selected address

## User Flow Diagram

```
┌─────────────────────────────────────────────────────────────────────┐
│  EDIT PROFILE SCREEN                                                │
│                                                                     │
│  [Additional Address (Tap to add)] ◄─── User taps here             │
└────────────────────────┬────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────────┐
│  ADDRESS SELECTION BOTTOM SHEET                                     │
│                                                                     │
│  ➕ Add New Address  ◄─── User taps here                           │
│                                                                     │
│  ⚪ Home                                                            │
│     4-17, Masjid Building                                          │
│     Sharjah, Dubai                                                 │
│                                                                     │
│  ⚪ Work                                                            │
│     406, Empower Residence                                         │
│     Al Jaddaf, Dubai                                               │
└────────────────────────┬────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────────┐
│  MAP SCREEN (SeletedMapScreen)                                      │
│                                                                     │
│  [User picks location on map]                                      │
│                                                                     │
│  [Confirm Button] ◄─── User confirms location                      │
└────────────────────────┬────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────────┐
│  ADDRESS DETAILS BOTTOM SHEET  ◄─── Automatically opens!           │
│                                                                     │
│  Address Details                                                   │
│                                                                     │
│  [Home]  [Work]  [Other]  ◄─── Select type                        │
│                                                                     │
│  Address / Building Name                                           │
│  4-17, Masjid Building  ◄─── Pre-filled from map                  │
│  ─────────────────────────────────────                            │
│                                                                     │
│  Flat / Villa No.                                                  │
│  ─────────────────────────────────────                            │
│                                                                     │
│  Directions (Optional)                                             │
│  ─────────────────────────────────────                            │
│                                                                     │
│  [Save Address] ◄─── User saves                                    │
└────────────────────────┬────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────────┐
│  ✅ Address saved successfully!                                     │
│  Returns to Edit Profile Screen                                    │
└─────────────────────────────────────────────────────────────────────┘
```

## How It Works

### User Flow:
1. **User clicks on "Additional Address"**
   - `GestureDetector` triggers `profileController.showAddressBottomSheet()`
   - Bottom sheet slides up showing saved addresses (if any)

2. **User clicks "Add New Address"**
   - Bottom sheet closes
   - `showAddAddressDialog()` is called
   - **Map screen opens immediately** for location selection

3. **User picks location on map and confirms**
   - User selects location on the map
   - Taps confirm button
   - Returns to profile with location data
   - **Address Details Bottom Sheet automatically appears** with:
     - Selected address pre-filled
     - Address type selection (Home/Work/Other)
     - Fields for flat/villa number
     - Optional directions field

4. **User fills address details in bottom sheet**
   - Address field is pre-filled from map selection
   - User selects address type (Home/Work/Other) by tapping chips
   - Optionally adds flat/villa number
   - Optionally adds directions

5. **User clicks "Save Address"**
   - `addNewAddress()` creates new SavedAddress object
   - Adds to `savedAddresses` list
   - Shows success message
   - Bottom sheet closes

6. **User selects an address from the list**
   - Opens address selection bottom sheet again
   - `selectAddress(index)` is called
   - All addresses are deselected
   - Selected address is marked with radio button
   - `additionalAddressController` is updated
   - Bottom sheet closes
   - UI shows the selected address

## Key Features

### Address Model
```dart
class SavedAddress {
  String? id
  String title          // Home, Work, Other
  String address        // Full address from map
  String? flatNo        // Flat/Villa number
  String? directions    // Optional directions
  String city
  double? latitude
  double? longitude
  bool isSelected
}
```

### Controller Methods
- **showAddressBottomSheet()**: Opens bottom sheet with saved addresses
- **showAddAddressDialog()**: Opens dialog to add new address
- **addNewAddress()**: Saves new address to list
- **selectAddress(index)**: Selects address at given index
- **getSelectedAddress()**: Returns currently selected address

### UI Components
- **AddressSelectionBottomSheet**: Bottom sheet showing saved addresses
- **AddAddressDialog**: Dialog for adding new address
- **Address Type Chips**: Home, Work, Other selection
- **Radio Button Selection**: Shows which address is selected

## Integration with Map

The feature integrates with your existing `MapController`:
1. **Direct Navigation**: When "Add New Address" is clicked, navigates directly to map
2. Navigates to `/SeletedMapScreen` with `returnData: true` argument
3. User picks location on map and confirms
4. Returns with `{address, latitude, longitude}` data
5. **Automatically shows Address Details Bottom Sheet** with pre-filled address

## Styling

All UI components use your existing design system:
- `AppColors.primary` for accent colors
- `CustomText` for consistent typography
- `CustomButton` for buttons
- Simple TextField with underline borders (matching your image)
- Follows your spacing and sizing conventions with ScreenUtil

## Troubleshooting

### Issue: Obx Error Fixed ✅
**Previous Problem:** `[Get] the improper use of a GetX has been detected`

**Solution:** Converted `AddAddressBottomSheet` from StatelessWidget with Obx to **StatefulWidget with setState**. This prevents improper use of reactive variables inside nested Obx widgets.

### Issue: Bottom Sheet Flow
**How it works now:**
1. Click "Add New Address" → Map opens immediately
2. Confirm location on map → Address Details Bottom Sheet appears
3. Fill details → Save address

### Map Integration Requirements
Your map screen must return data in this format:
```dart
Get.back(result: {
  'address': 'Selected address string',
  'latitude': 25.1234,
  'longitude': 55.5678,
});
```

## Key Improvements

1. ✅ **Fixed Obx Error**: Using StatefulWidget instead of reactive programming
2. ✅ **Better UX Flow**: Map first, then details (more intuitive)
3. ✅ **Bottom Sheet Design**: Matches your provided image exactly
4. ✅ **No Dialog**: All interactions use bottom sheets
5. ✅ **Pre-filled Address**: Address automatically filled from map selection

## Next Steps

To fully integrate this feature, you may want to:
1. **API Integration**: Connect to backend to save/load addresses
2. **Persistence**: Save addresses locally with SharedPreferences
3. **Delete Function**: Add ability to delete saved addresses
4. **Edit Function**: Allow editing existing addresses
5. **Set Default**: Mark one address as default
6. **Use in Booking**: Use selected address when creating service bookings

## Testing

To test the feature:
1. Run the app and navigate to Edit Profile
2. Click on "Additional Address (Tap to add)"
3. Bottom sheet with saved addresses appears
4. Click "Add New Address"
5. **Map screen opens immediately** ⭐
6. Pick a location and tap confirm
7. **Address Details Bottom Sheet appears automatically** ⭐
8. Address field is pre-filled from map
9. Select address type (Home/Work/Other)
10. Optionally fill flat number and directions
11. Save the address
12. Verify it appears in the saved addresses list
13. Select an address and verify it updates the UI
