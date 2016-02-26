---
layout: post
title:  "Elixir ZipStream"
date:   2016-02-26 10:25:39 -0600
categories: elixir
---

I recently had to process a several-gigabyte zip file, containing
several hundred-thousand json documents.

I wrote an [Elixir][elixir] script to lazily stream data out of the
zip file, into a [poolboy pool][poolboy]  of post-processors.  Though
the unzipping itself is a single-process, processing output can be
in parallel.

Using the [Stream.resource/3][res3] function, it becomes a simple
matter.  The zip file is opened and indexed, and the next_fun/1 delivers the next file from the zip. close/1 closes the underlying resource.  


Here's the code for the streaming unzipper. Enjoy!

{% highlight elixir %}
{% include zip_stream.ex %}
{% endhighlight %}

```

iex(1)>  ZipStream.stream!("data.zip")|>Enum.each(fn({name,_data})->IO.puts(data) end) 
foo.json
:ok
```

[poolboy]: https://github.com/devinus/poolboy
[res3]: http://elixir-lang.org/docs/stable/elixir/Stream.html#resource/3
[elixir]: http://elixir-lang.org
