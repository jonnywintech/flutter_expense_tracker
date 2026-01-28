# Copilot Instructions for Expenses Tracker

## Project Overview
A cross-platform Flutter expense tracking application supporting Android, iOS, Web, Linux, Windows, and macOS. The app manages personal expenses with categorization, date tracking, and visual analytics.

## Architecture

### Core Data Model
- **Expense**: Immutable model with auto-generated UUID (via `uuid` package), title, amount, date, and category
- **Category**: Enum (food, travel, leisure, work) with mapped Material icons in `categoryIcons` map
- **ExpenseBucket**: Groups expenses by category for analytical purposes (used in Chart widget)
- See [lib/models/expense.dart](lib/models/expense.dart) for implementation

### Widget Structure
```
main.dart (ColorScheme setup + app entry)
  └─ Expenses (StatefulWidget - state management)
      ├─ Chart (analytics visualization)
      │   └─ ChartBar (individual bar component)
      ├─ ExpensesList (scrollable list display)
      │   └─ ExpenseItem (individual expense card)
      └─ NewExpense (modal form for adding expenses)
```

**State Management Pattern**: Single `List<Expense>` in `_ExpensesState` passed down via constructors. No providers/getx—state updates trigger rebuilds via `setState()`.

### Key Data Flows
1. **Add Expense**: FAB → `_openAddExpenseOverlay()` → `NewExpense` modal → `_addExpense()` callback → `setState()` updates list
2. **Remove Expense**: Long-press/delete button in `ExpenseItem` → `_removeExpense()` → SnackBar with undo action
3. **Undo Delete**: Captures list index, re-inserts on undo action, auto-hides SnackBar after 3 seconds

## Development Conventions

### Imports Organization
Follow this order in all files:
1. `package:flutter/` imports
2. Third-party packages (`package:intl/`, `package:uuid/`)
3. Local package imports (`package:expenses_tracker/`)

### Naming & Structure
- **File organization**: Models in `lib/models/`, UI components in `lib/widgets/{component}/`
- **Widget naming**: Feature-based (e.g., `chart/`, `expenses_list/`) not type-based (don't create separate `components/` folder)
- **Widget types**: StatefulWidgets for screens managing data, StatelessWidgets for presentational components
- **Private members**: Use underscore prefix (`_selectedCategory`, `_registeredExpenses`) for private fields and methods

### UI Patterns & Theme
- **Theme Setup**: Dual theme (light + dark) using `ColorScheme.fromSeed()` in [lib/main.dart](lib/main.dart)
- **Material Design**: Uses `Material3` seeded colors with consistent spacing (16px horizontal/vertical margins via `EdgeInsets.symmetric`)
- **Responsive Layout**: `LayoutBuilder` for constraint-aware layouts (used in [new_expense.dart](lib/widgets/new_expense.dart))
- **Bottom Sheets**: Use `showModalBottomSheet(useSafeArea: true, isScrollControlled: true)` for forms to handle keyboard insets

### Form & Date Handling
- **Text Input**: Controller disposal required in `dispose()` to prevent memory leaks
- **Date Picker**: Use `showDatePicker()` with 1-year lookback range; format dates with `final formatter = DateFormat.yMd()`
- **Input Validation**: Trim whitespace, validate non-null/positive amounts, show `AlertDialog` for validation errors

### SnackBar Implementation
- Clear previous SnackBars before showing new ones: `ScaffoldMessenger.of(context).clearSnackBars()`
- Store messenger reference to manage auto-hide after delays
- Undo actions capture state (e.g., original index) for reverting deletions

## Dependencies
- **flutter**: SDK (Material Design, state management via `setState`)
- **intl**: Date formatting (v0.20.2+)
- **uuid**: Generate unique expense IDs (v4.5.2+)
- **cupertino_icons**: iOS-style icons (v1.0.8+)

## Build & Development

### Key Commands
```bash
flutter pub get              # Install dependencies
flutter run                  # Run app on connected device
flutter run -d web          # Run on web platform
flutter build apk           # Android build
flutter build ios           # iOS build (macOS only)
dart analyze                # Lint code (configured in analysis_options.yaml)
```

### Common Workflows
- **Hot Reload**: `r` in terminal after code changes (UI only, doesn't reset const globals)
- **Hot Restart**: `R` to fully restart app (includes const updates)
- **Clean Build**: `flutter clean && flutter pub get` if build fails

## Testing Notes
- Widget tests in `test/` directory
- Current test file: [test/widget_test.dart](test/widget_test.dart)
- No integration tests currently implemented

## Code Style
- Lint rules: Enforced via `flutter_lints: ^6.0.0` in [analysis_options.yaml](analysis_options.yaml)
- Format code with `dart format lib/` before commits
- Remove debug print statements (e.g., constraint logging in `LayoutBuilder`) in production

## Common Pitfalls & Solutions
- **Memory Leaks**: Always dispose `TextEditingController` in `dispose()` method
- **Keyboard Layout Issues**: Use `MediaQuery.of(context).viewInsets.bottom` for bottom sheet padding
- **SnackBar Overlaps**: Clear previous SnackBars before showing new ones
- **State Not Updating**: Ensure modifications happen inside `setState()` callback
- **Date Formatting**: Use `DateFormat.yMd()` (global instance) for consistent formatting across app
