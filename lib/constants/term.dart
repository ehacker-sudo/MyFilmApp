class Term {
  static const List<Map<String, String>> type = [
    {"title": "Phim ảnh", "media_type": "movie"},
    {"title": "Phim truyền hình", "media_type": "tv"},
  ];
  static const List<dynamic> genreSample = [
    {
      "movie": [
        // {"id": 28, "name": "Phim Hành Động"},
        // {"id": 12, "name": "Phim Phiêu Lưu"},
        // {"id": 16, "name": "Phim Hoạt Hình"},
        // {"id": 35, "name": "Phim Hài"},
        // {"id": 80, "name": "Phim Hình Sự"},
        // {"id": 99, "name": "Phim Tài Liệu"},
        // {"id": 18, "name": "Phim Chính Kịch"},
        // {"id": 10751, "name": "Phim Gia Đình"},
        // {"id": 14, "name": "Phim Giả Tượng"},
        // {"id": 36, "name": "Phim Lịch Sử"},
        // {"id": 27, "name": "Phim Kinh Dị"},
        // {"id": 10402, "name": "Phim Nhạc"},
        // {"id": 9648, "name": "Phim Bí Ẩn"},
        // {"id": 10749, "name": "Phim Lãng Mạn"},
        // {"id": 878, "name": "Phim Khoa Học Viễn Tưởng"},
        // {"id": 10770, "name": "Chương Trình Truyền Hình"},
        {"id": 53, "name": "Phim Gây Cấn"},
        // {"id": 10752, "name": "Phim Chiến Tranh"},
        // {"id": 37, "name": "Phim Miền Tây"}
      ],
      "tv": [
        // {"id": 10759, "name": "Phim Hành Động"},
        // {"id": 10759, "name": "Phim Phiêu Lưu"},
        // {"id": 16, "name": "Phim Hoạt Hình"},
        // {"id": 35, "name": "Phim Hài"},
        // {"id": 80, "name": "Phim Hình Sự"},
        // {"id": 99, "name": "Phim Tài Liệu"},
        // {"id": 18, "name": "Phim Chính Kịch"},
        // {"id": 10751, "name": "Phim Gia Đình"},
        {"id": 10762, "name": "Kids"},
        // {"id": 9648, "name": "Phim Bí Ẩn"},
        {"id": 10763, "name": "News"},
        {"id": 10764, "name": "Reality"},
        // {"id": 10765, "name": "Sci-Fi & Fantasy"},
        {"id": 10766, "name": "Soap"},
        {"id": 10767, "name": "Talk"},
        // {"id": 10768, "name": "Phim Chiến Tranh"},
        // {"id": 37, "name": "Phim Miền Tây"}
      ]
    }
  ];

  static const List<dynamic> genres = [
    {
      "name": "Phim Hành Động",
      "id": {"movie": 28, "tv": 10759},
    },
    {
      "name": "Phim Phiêu Lưu",
      "id": {"movie": 12, "tv": 10759},
    },
    {
      "name": "Phim Hoạt Hình",
      "id": {"movie": 16, "tv": 16},
    },
    {
      "name": "Phim Hài",
      "id": {"movie": 35, "tv": 35},
    },
    {
      "name": "Phim Hình Sự",
      "id": {"movie": 80, "tv": 80},
    },
    {
      "name": "Phim Tài Liệu",
      "id": {"movie": 99, "tv": 99},
    },
    {
      "name": "Phim Chính Kịch",
      "id": {"movie": 18, "tv": 18},
    },
    {
      "name": "Phim Gia Đình",
      "id": {"movie": 10751, "tv": 10751},
    },
    {
      "name": "Phim thiếu nhi",
      "id": {"movie": "", "tv": 10762},
    },
    {
      "name": "Phim Giả Tượng",
      "id": {"movie": 14, "tv": 0},
    },
    {
      "name": "Phim Lịch Sử",
      "id": {"movie": 36, "tv": 0},
    },
    {
      "name": "Phim Kinh Dị",
      "id": {"movie": 27, "tv": 0},
    },
    {
      "name": "Phim Nhạc",
      "id": {"movie": 10402, "tv": 0},
    },
    {
      "name": "Phim Bí Ẩn",
      "id": {"movie": 9648, "tv": 9648},
    },
    {
      "name": "Phim Lãng Mạn",
      "id": {"movie": 10749, "tv": 0},
    },
    {
      "name": "Phim Khoa Học Viễn Tưởng",
      "id": {"movie": 878, "tv": 10765},
    },
    {
      "name": "Chương Trình Truyền Hình",
      "id": {"movie": 10770, "tv": 0},
    },
    {
      "name": "Phim Gây Cấn",
      "id": {"movie": 53, "tv": 0},
    },
    {
      "name": "Phim Chiến Tranh",
      "id": {"movie": 10752, "tv": 10768},
    },
    {
      "name": "Phim Miền Tây",
      "id": {"movie": 37, "tv": 37},
    },
    // "tv": [
    //   {"id": 10763, "name": "News"},
    //   {"id": 10764, "name": "Reality"},
    //   {"id": 10767, "name": "Talk"},
    // ]
  ];

  static const List<dynamic> rates = [
    {
      "name": "9+",
      "rate": 9.0,
    },
    {
      "name": "8+",
      "rate": 8.0,
    },
    {
      "name": "7+",
      "rate": 7.0,
    },
    {
      "name": "6+",
      "rate": 6.0,
    },
  ];

  static const List<dynamic> rateCounts = [
    {
      "name": "1000+",
      "count": 1000.0,
    },
    {
      "name": "5000+",
      "count": 5000.0,
    },
    {
      "name": "10000+",
      "count": 10000.0,
    },
    {
      "name": "15000+",
      "count": 15000.0,
    },
    {
      "name": "20000+",
      "count": 20000.0,
    },
  ];

  static List<int> releaseYears = List<int>.generate(
      (2026 - 1920), (int index) => index + 1920,
      growable: false);
  static List<int> releaseDecades = List<int>.generate(
      (((2025 - 1920) ~/ 10) + 1), (int index) => (index * 10) + 1920,
      growable: false);

  static const List<dynamic> runTimes = [
    {
      "name": "Nhỏ hơn 1 giờ",
      "range": [0, 1],
    },
    {
      "name": "Từ 1 đến 2 giờ",
      "range": [1, 2],
    },
    {
      "name": "Từ 2 đến 3 giờ",
      "range": [2, 3],
    },
    {
      "name": "Từ 3 đến 4 giờ",
      "range": [3, 4],
    },
    {
      "name": "Lớn hơn 4 giờ",
      "range": [4, 10000000]
    },
  ];
}
