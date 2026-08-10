class Journal {
  final int journalId;
  final String title;
  final int countryId;
  final String? coverImage;
  final List<JournalPage> pages;

  const Journal({
    required this.journalId,
    required this.title,
    required this.countryId,
    this.coverImage,
    this.pages = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'id': journalId,
      'title': title,
      'countryId': countryId,
      'coverImage': coverImage,
      'pages': pages.map((p) => p.toJson()).toList(),
    };
  }

  factory Journal.fromJson(Map<String, dynamic> json) {
    return Journal(
      journalId: json['journal_id'] ?? int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      title: json['title'] ?? '',
      countryId: json['country_id'] ?? 0,
      coverImage: json['cover_image'] ?? json['coverImage'],
      pages: (json['pages'] as List?)
              ?.map((p) => JournalPage.fromJson(p))
              .toList() ??
          [],
    );
  }
}

class JournalPage {
  final int pageId;
  final int pageNumber;
  final String? backgroundColor;
  final List<JournalElement> elements;

  const JournalPage({
    required this.pageId,
    required this.pageNumber,
    this.backgroundColor,
    this.elements = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'pageNumber': pageNumber,
      'backgroundColor': backgroundColor,
      'elements': elements.map((e) => e.toJson()).toList(),
    };
  }

  factory JournalPage.fromJson(Map<String, dynamic> json) {
    return JournalPage(
      pageId: json['page_id'] ?? 0,
      pageNumber: json['page_number'] ?? 0,
      backgroundColor: json['background_color'],
      elements: (json['elements'] as List?)
              ?.map((e) => JournalElement.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class JournalElement {
  final int elementId;
  final String elementType;
  final String? elementKey;
  final String? content;
  final String? imageUrl;
  final int xPosition;
  final int yPosition;
  final int width;
  final int height;
  final double scale;
  final double rotation;
  final int zIndex;

  const JournalElement({
    required this.elementId,
    required this.elementType,
    this.elementKey,
    this.content,
    this.imageUrl,
    this.xPosition = 0,
    this.yPosition = 0,
    this.width = 200,
    this.height = 100,
    this.scale = 1,
    this.rotation = 0,
    this.zIndex = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'elementId': elementId,
      'elementType': elementType,
      'elementKey': elementKey,
      'content': content,
      'imageUrl': imageUrl,
      'xPosition': xPosition,
      'yPosition': yPosition,
      'width': width,
      'height': height,
      'scale': scale,
      'rotation': rotation,
      'zIndex': zIndex,
    };
  }

  factory JournalElement.fromJson(Map<String, dynamic> json) {
    return JournalElement(
      elementId: json['element_id'] ?? 0,
      elementType: json['element_type'] ?? 'text',
      elementKey: json['element_key'] ?? json['elementKey'],
      content: json['content'],
      imageUrl: json['image_url'],
      xPosition: json['x_position'] ?? 0,
      yPosition: json['y_position'] ?? 0,
      width: json['width'] ?? 200,
      height: json['height'] ?? 100,
      scale: (json['scale'] as num?)?.toDouble() ?? 1,
      rotation: (json['rotation'] as num?)?.toDouble() ?? 0,
      zIndex: (json['z_index'] as num?)?.toInt() ?? 0,
    );
  }
}
