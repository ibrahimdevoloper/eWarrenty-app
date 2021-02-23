bool checkIfCurrentDateIsBeforeDueDate(DateTime dueDate) {
  return DateTime.now().isAfter(dueDate);
}
