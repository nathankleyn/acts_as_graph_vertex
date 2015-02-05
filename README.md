# acts_as_graph_vertex [![Build Status](https://travis-ci.org/nathankleyn/acts_as_graph_vertex.svg?branch=master)](https://travis-ci.org/nathankleyn/acts_as_graph_vertex) [![Coverage Status](https://coveralls.io/repos/nathankleyn/acts_as_graph_vertex/badge.png?branch=master)](https://coveralls.io/r/nathankleyn/acts_as_graph_vertex?branch=master)

Simple mixin for adding graph like functions (parents, children, traversal, etc) to any class.

## Installing

You can install this gem via RubyGems:

```sh
gem install acts_as_graph_vertex
```

## Using

Sometimes it's useful to be able to add graph like functionality to existing classes you have. This is where acts_as_graph_vertex comes in! Simply mixin this module, and you'll get basic directed acyclic graph (DAG) functionality for free:

```ruby
require 'acts_as_graph_vertex'

class MyAmazingClass
  include ActsAsGraphVertex
end
```

And now you can use the functions:

```ruby
parent = MyAmazingClass.new
child1 = MyAmazingClass.new
child2 = MyAmazingClass.new
child3 = MyAmazingClass.new

# The following calls will create a DAG like the following:
#
#            --> child1 --
#          /               \
# parent--                   --> child3
#          \               /
#            --> child2 --

parent.add_child(child1)
child2.add_parent(child1)
child3.add_parent(child1)
child3.add_parent(child2)
```

You can now traverse the graph from any of these vertices:

```ruby
parent.children # => [child1, child2]
parent.all_children # => [child1, child2, child3]
child3.parents # => [child1, child2]
child3.all_parents # => [child1, child2, parent]
```

Note that this mixin does not currently prevent or handle cyclic dependencies; it's intended to be simple rather than exhaustive. If cycle detection is required, using something as a layer over this mixin such as Tarjan's algorithm for finding strongly connected components of a graph is recommended. Tarjan's algorithm is bundled with the Ruby standard library as `TSort` (despite the naming, this class does not provide topographic sorting).

## License

The MIT License (MIT)

Copyright (c) 2015 Nathan Kleyn

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
