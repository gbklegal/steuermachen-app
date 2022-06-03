// To parse this JSON data, do
//
//     final faqWrapper = faqWrapperFromJson(jsonString);

import 'dart:convert';

class TaxTipsWrapper {
  TaxTipsWrapper({
    this.id,
    this.date,
    this.link,
    this.title,
    this.content,
    this.embedded,
  });

  int? id;
  DateTime? date;
  String? link;
  Title? title;
  Content? content;
  Embedded? embedded;

  factory TaxTipsWrapper.fromRawJson(String str) =>
      TaxTipsWrapper.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaxTipsWrapper.fromJson(Map<String, dynamic> json) => TaxTipsWrapper(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        link: json["link"],
        title: json["title"] == null ? null : Title.fromJson(json["title"]),
        content:
            json["content"] == null ? null : Content.fromJson(json["content"]),
        embedded: json["_embedded"] == null
            ? null
            : Embedded.fromJson(json["_embedded"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date?.toIso8601String(),
        "link": link,
        "title": title?.toJson(),
        "content": content?.toJson(),
        "_embedded": embedded?.toJson(),
      };
}

class Content {
  Content({
    this.rendered,
    this.protected,
  });

  String? rendered;
  bool? protected;

  factory Content.fromRawJson(String str) => Content.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        rendered: json["rendered"],
        protected: json["protected"],
      );

  Map<String, dynamic> toJson() => {
        "rendered": rendered,
        "protected": protected,
      };
}

class Embedded {
  Embedded({
    this.author,
    this.wpFeaturedmedia,
    this.wpTerm,
  });

  List<Author>? author;
  List<WpFeaturedmedia>? wpFeaturedmedia;
  List<List<WpTerm>>? wpTerm;

  factory Embedded.fromRawJson(String str) =>
      Embedded.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Embedded.fromJson(Map<String, dynamic> json) => Embedded(
        author: json["author"] == null
            ? null
            : List<Author>.from(json["author"].map((x) => Author.fromJson(x))),
        wpFeaturedmedia: json["wp:featuredmedia"] == null
            ? null
            : List<WpFeaturedmedia>.from(json["wp:featuredmedia"]
                .map((x) => WpFeaturedmedia.fromJson(x))),
        wpTerm: json["wp:term"] == null
            ? null
            : List<List<WpTerm>>.from(json["wp:term"].map(
                (x) => List<WpTerm>.from(x.map((x) => WpTerm.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "author": List<dynamic>.from(author!.map((x) => x.toJson())),
        "wp:featuredmedia":
            List<dynamic>.from(wpFeaturedmedia!.map((x) => x.toJson())),
        "wp:term": List<dynamic>.from(
            wpTerm!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class Author {
  Author({
    this.id,
    this.name,
    this.url,
    this.description,
    this.link,
    this.slug,
    this.avatarUrls,
  });

  int? id;
  String? name;
  String? url;
  String? description;
  String? link;
  String? slug;
  Map<String, String>? avatarUrls;

  factory Author.fromRawJson(String str) => Author.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        description: json["description"],
        link: json["link"],
        slug: json["slug"],
        avatarUrls: json["avatar_urls"] == null
            ? null
            : Map.from(json["avatar_urls"])
                .map((k, v) => MapEntry<String, String>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "description": description,
        "link": link,
        "slug": slug,
        "avatar_urls": avatarUrls == null
            ? null
            : Map.from(avatarUrls!)
                .map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

class WpFeaturedmedia {
  WpFeaturedmedia({
    this.id,
    this.date,
    this.slug,
    this.type,
    this.link,
    this.title,
    this.author,
    this.caption,
    this.altText,
    this.mediaType,
    this.mimeType,
    this.sourceUrl,
  });

  int? id;
  DateTime? date;
  String? slug;
  String? type;
  String? link;
  Title? title;
  int? author;
  Title? caption;
  String? altText;
  String? mediaType;
  String? mimeType;
  String? sourceUrl;

  factory WpFeaturedmedia.fromRawJson(String str) =>
      WpFeaturedmedia.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WpFeaturedmedia.fromJson(Map<String, dynamic> json) =>
      WpFeaturedmedia(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        slug: json["slug"],
        type: json["type"],
        link: json["link"],
        title: Title.fromJson(json["title"]),
        author: json["author"],
        caption:
            json["caption"] == null ? null : Title.fromJson(json["caption"]),
        altText: json["alt_text"],
        mediaType: json["media_type"],
        mimeType: json["mime_type"],
  
        sourceUrl: json["source_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date?.toIso8601String(),
        "slug": slug,
        "type": type,
        "link": link,
        "title": title?.toJson(),
        "author": author,
        "caption": caption?.toJson(),
        "alt_text": altText,
        "media_type": mediaType,
        "mime_type": mimeType,
        "source_url": sourceUrl,
      };
}

class Title {
  Title({
    this.rendered,
  });

  String? rendered;

  factory Title.fromRawJson(String str) => Title.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        rendered: json["rendered"],
      );

  Map<String, dynamic> toJson() => {
        "rendered": rendered,
      };
}



class WpTerm {
  WpTerm({
    this.id,
    this.link,
    this.name,
    this.slug,
    this.taxonomy,
    this.links,
  });

  int? id;
  String? link;
  String? name;
  String? slug;
  String? taxonomy;
  Links? links;

  factory WpTerm.fromRawJson(String str) => WpTerm.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WpTerm.fromJson(Map<String, dynamic> json) => WpTerm(
        id: json["id"],
        link: json["link"],
        name: json["name"],
        slug: json["slug"],
        taxonomy: json["taxonomy"],
        links: json["_links"] == null ? null : Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "link": link,
        "name": name,
        "slug": slug,
        "taxonomy": taxonomy,
        "_links": links?.toJson(),
      };
}

class Links {
  Links({
    this.self,
    this.collection,
    this.about,
    this.wpPostType,
    this.curies,
  });

  List<About>? self;
  List<About>? collection;
  List<About>? about;
  List<About>? wpPostType;
  List<Cury>? curies;

  factory Links.fromRawJson(String str) => Links.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"] == null
            ? null
            : List<About>.from(json["self"].map((x) => About.fromJson(x))),
        collection: json["collection"] == null
            ? null
            : List<About>.from(
                json["collection"].map((x) => About.fromJson(x))),
        about: json["about"] == null
            ? null
            : List<About>.from(json["about"].map((x) => About.fromJson(x))),
        wpPostType: json["wp:post_type"] == null
            ? null
            : List<About>.from(
                json["wp:post_type"].map((x) => About.fromJson(x))),
        curies: json["curies"] == null
            ? null
            : List<Cury>.from(json["curies"].map((x) => Cury.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": self == null
            ? null
            : List<dynamic>.from(self!.map((x) => x.toJson())),
        "collection": collection == null
            ? null
            : List<dynamic>.from(collection!.map((x) => x.toJson())),
        "about": about == null
            ? null
            : List<dynamic>.from(about!.map((x) => x.toJson())),
        "wp:post_type": wpPostType == null
            ? null
            : List<dynamic>.from(wpPostType!.map((x) => x.toJson())),
        "curies": curies == null
            ? null
            : List<dynamic>.from(curies!.map((x) => x.toJson())),
      };
}

class About {
  About({
    this.href,
  });

  String? href;

  factory About.fromRawJson(String str) => About.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory About.fromJson(Map<String, dynamic> json) => About(
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
      };
}

class Cury {
  Cury({
    this.name,
    this.href,
    this.templated,
  });

  String? name;
  String? href;
  bool? templated;

  factory Cury.fromRawJson(String str) => Cury.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Cury.fromJson(Map<String, dynamic> json) => Cury(
        name: json["name"],
        href: json["href"],
        templated: json["templated"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "href": href,
        "templated": templated,
      };
}
