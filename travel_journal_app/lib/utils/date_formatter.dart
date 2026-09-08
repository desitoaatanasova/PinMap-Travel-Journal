const _months = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

String formatTripDate(DateTime date) => '${_months[date.month - 1]} ${date.day}';

String formatTripRange(DateTime start, DateTime end) =>
    '${formatTripDate(start)} - ${formatTripDate(end)}';

String formatPickerDate(DateTime date) => '${date.month}/${date.day}/${date.year}';
