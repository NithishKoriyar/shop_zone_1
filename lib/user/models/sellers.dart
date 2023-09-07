class Sellers {
  final int sellerId;
  final String sellerName;
  final String sellerEmail;
  final String sellerPassword; // Storing passwords in plain text or even hashed in front-end models is a big security risk! You shouldn't really be doing this.
  final String sellerProfile;
  final int sellerPhone;
  final String sellerAddress;
  final double rating;

  Sellers({
    required this.sellerId,
    required this.sellerName,
    required this.sellerEmail,
    required this.sellerPassword,
    required this.sellerProfile,
    required this.sellerPhone,
    required this.sellerAddress,
    required this.rating,
  });

  // Factory constructor to create an instance of Sellers from a map
factory Sellers.fromJson(Map<String, dynamic> json) {
  return Sellers(
    sellerId: (json['seller_id'] is int) ? json['seller_id'] : 0,
    sellerName: (json['seller_name'] is String) ? json['seller_name'] : '',
    sellerEmail: (json['seller_email'] is String) ? json['seller_email'] : '',
    sellerPassword: (json['seller_password'] is String) ? json['seller_password'] : '', // Remember: Storing passwords in plain text or even hashed in front-end models is a big security risk!
    sellerProfile: (json['seller_profile'] is String) ? json['seller_profile'] : '',
    sellerPhone: (json['seller_phone'] is int) ? json['seller_phone'] : 0,
    sellerAddress: (json['seller_address'] is String) ? json['seller_address'] : '',
    rating: (json['rating'] is int || json['rating'] is double) ? json['rating'].toDouble() : 0.0,
  );
}


  // Convert Sellers instance to a map
  Map<String, dynamic> toJson() {
    return {
      'seller_id': sellerId,
      'seller_name': sellerName,
      'seller_email': sellerEmail,
      'seller_password': sellerPassword,
      'seller_profile': sellerProfile,
      'seller_phone': sellerPhone,
      'seller_address': sellerAddress,
      'rating': rating,
    };
  }
}
