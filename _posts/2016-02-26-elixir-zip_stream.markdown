---
layout: post
title:  "Elixir ZipStream"
date:   2016-02-26 10:25:39 -0600
categories: elixir
---

I recently had to process a several-gigabyte zip file, containing several hundred-thousand json documents.

I wrote an Elixir script to lazily stream data out of the zip file, into a [poolboy pool][poolboy]  of post-processors.  While the unzipping process itself is a single-process affair, the data thus extracted is handed off for parallel processing.

Using the [Stream.resource/3][res3] function, it becomes fairly trivial to begin processing the data immediately as it becomes available, instead of waiting for the entire process to complete, and buffering the entire thing while you wait (or worse, writing it to files).

The code:

{% highlight elixir %}
{% include zip_stream.ex %}
{% endhighlight %}
[poolboy]: https://github.com/devinus/poolboy
[res3]: http://elixir-lang.org/docs/stable/elixir/Stream.html#resource/3
