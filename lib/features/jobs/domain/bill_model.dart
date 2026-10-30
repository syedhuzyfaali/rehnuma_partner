class BillItem {
  final String description;
  final double amount;
  final int quantity;

  const BillItem({
    required this.description,
    required this.amount,
    this.quantity = 1,
  });
}

class JobBill {
  final String invoiceNumber;
  final String date;
  final String currency;
  final List<BillItem> items;
  final double totalAmount;
  final bool isCashPayment;
  final bool isConfirmed;

  const JobBill({
    required this.invoiceNumber,
    required this.date,
    required this.currency,
    required this.items,
    required this.totalAmount,
    this.isCashPayment = true,
    this.isConfirmed = false,
  });

  JobBill copyWith({
    bool? isConfirmed,
  }) {
    return JobBill(
      invoiceNumber: invoiceNumber,
      date: date,
      currency: currency,
      items: items,
      totalAmount: totalAmount,
      isCashPayment: isCashPayment,
      isConfirmed: isConfirmed ?? this.isConfirmed,
    );
  }
}