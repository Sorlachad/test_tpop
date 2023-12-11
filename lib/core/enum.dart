enum SeatStatus { available, unavailable, select }

extension SeatStatusExtension on String {
  toSeatStatus() {
    switch (this) {
      case 'available':
        return SeatStatus.available;
      case 'close':
        return SeatStatus.unavailable;
      case 'select':
        return SeatStatus.select;
      default:
        return SeatStatus.unavailable;
    }
  }
}
