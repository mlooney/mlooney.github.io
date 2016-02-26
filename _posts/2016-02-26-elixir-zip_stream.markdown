---
layout: post
title:  "Elixir ZipStream"
date:   2016-02-26 10:25:39 -0600
categories: elixir
---

I recently had to process a several-gigabyte zip file, containging several hundred-thousand json documents.

I wrote an Elixir script to stream data out of the zip file, and into a [poolboy pool][devinus/poolboy]  of post-processors.  While the unzipping process itself is a single-process affair, the data thus extracted is handed off for parallel processing.

Using the Stream.resource/3 function, it becomes possible to begin processing the data immediately as it's available (lazily), instead of waiting for the entire process to complete, and buffering the entire thing (or worse, writing it to files).

It turned out to be relatively simple, and I might have done it incorrectly, but it seems to work :)

{% highlight elixir %}
{% include zip_stream.ex %}
{% endhighlight %}

Check out the [Jekyll docs][jekyll-docs] for more info on how to get the most out of Jekyll. File all bugs/feature requests at [Jekyll’s GitHub repo][jekyll-gh]. If you have questions, you can ask them on [Jekyll Talk][jekyll-talk].

[jekyll-docs]: http://jekyllrb.com/docs/home
[jekyll-gh]:   https://github.com/jekyll/jekyll
[jekyll-talk]: https://talk.jekyllrb.com/
