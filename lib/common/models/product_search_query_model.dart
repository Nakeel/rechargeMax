class SearchQuery {
  final int page;
  final int pageLimit;
  final int pageSize;
  final String? search;
  final String? from;
  final String? to;
  final List<String>? categories;
  final List<String>? brands;
  final bool? popularity;
  final String? price;
  final double? minPrice;
  final double? maxPrice;

  SearchQuery({
    required this.page,
    this.pageLimit = 20,
    this.pageSize = 20,
    this.search,
    this.from,
    this.to,
    this.categories,
    this.brands,
    this.popularity,
    this.price,
    this.maxPrice,
    this.minPrice,
  });

  SearchQuery copyWith({
    int? page,
    int? pageLimit,
    int? pageSize,
    String? search,
    String? from,
    String? to,
    List<String>? categories,
    List<String>? brands,
    bool? popularity,
    String? price,
    double? minPrice,
    double? maxPrice,
  }) {
    return SearchQuery(
      page: page ?? this.page,
      pageLimit: pageLimit ?? this.pageLimit,
      pageSize: pageSize ?? this.pageSize,
      search: search ?? this.search,
      from: from ?? this.from,
      to: to ?? this.to,
      categories: categories ?? this.categories,
      brands: brands ?? this.brands,
      popularity: popularity ?? this.popularity,
      price: price ?? this.price,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
    );
  }

  Map<String, dynamic> toQueryParams() {
    return {
      'page': page,
      'pageLimit': pageLimit,
      'pageSize': pageSize,
      if (search != null) 'search': search,
      if (from != null) 'from': from,
      if (to != null) 'to': to,
      if (categories != null) 'Categories': categories,
      if (brands != null) 'brands': brands,
      if (popularity != null) 'popularity': popularity,
      if (price != null) 'price': price,
      if (maxPrice != null) 'maxPrice': maxPrice,
      if (minPrice != null) 'minPrice': minPrice,
    };
  }
}
