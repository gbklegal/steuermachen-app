# WordPress REST API

by Tobias Röder - 14.02.2022

## Explaination in JavaScript
The URL from which the data is obtained
```javascript
/**
 * @param {string} _fields
 * only get the data you want
 * @see https://developer.wordpress.org/rest-api/using-the-rest-api/global-parameters/#_fields
 *
 * @param {bool} _embed
 * enable access to the full author and/or full media data,
 * however it only works if _embedded is listet in _fields
 * @see https://developer.wordpress.org/rest-api/using-the-rest-api/global-parameters/#_embed
 */
const url = 'https://steuermachen.de/wp-json/wp/v2/posts?_embed&_fields=id,date,link,title,content,_links,_embedded';
```

JS example how to fetch the data
```javascript
// fetch the url which was previously defined with the fetch promise
fetch(url).then(resp => {
  // return the response as json object
  return resp.json();
}).then(obj => {
  // get full author name
  console.log(obj._embedded['author'][0].name);
  // get original image url
  console.log(obj._embedded['wp:featuredmedia'][0].source_url);
  // get thumbnail url
  console.log(obj._embedded['wp:featuredmedia'][0].media_details.sizes['onepress-blog-small'].source_url);
});
```

Due some new requirements, we have to check if the post can be shown in the app or not. In this case we need to check the new item in the meta field.
```javascript
// add to the previous shown url in _fields, meta
const url = 'https://steuermachen.de/wp-json/wp/v2/posts?_embed&_fields=id,date,link,meta,title,content,_links,_embedded';

// example
fetch(url).then(resp => resp.json()).then(obj => {
  // get the meta field of the first post in array
  let meta = obj[0].meta;
  // get bool from "hide post on app"
  let hidePostOnApp = meta.hide_post_on_app;
  // show result in the console
  console.log(hidePostOnApp);
});
```

More information about the [WordPress REST API](https://developer.wordpress.org/rest-api/) and the [global parameters](https://developer.wordpress.org/rest-api/using-the-rest-api/global-parameters/).

---

## Flutter example

```dart
import 'dart:convert';

import 'package:app/models/post.dart';
import 'package:app/models/docs.dart';
import 'package:http/http.dart';

class HttpService {
  // ignore: missing_return
  Future<List<Post>> getPosts(pageNumber) async {
    Response response = await get(Uri.parse(
        "https://steuermachen.de/wp-json/wp/v2/posts?page=$pageNumber&_embed&_fields=id,date,link,title,content,_links,_embedded"));
    try {
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var posts = List<Post>.from(body.map((model) => Post.fromJson(model)));
        return posts;
      } else if (response.statusCode == 400) {
        return null;
      } else
        throw "Can't get posts.";
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
  }
}
```

More details in the source code file `/lib/services/http_service.dart` from the BussgeldPrüfer app.