# uix

Library to build Web User Interfaces in [Dart](https://dartlang.org)
inspired by [React](http://facebook.github.io/react/).

## Quick Start

Requirements:

 - Dart SDK 1.9.1 or greater

#### 1. Create a new Dart Web Project
#### 2. Add uix library in `pubspec.yaml` file:

```yaml
dependencies:
  uix: any
```

#### 3. Install dependencies

```sh
$ pub get
```

#### 4. Add `build.dart` file:

```dart
library build_file;

import 'package:source_gen/source_gen.dart';
import 'package:uix/generator.dart';

void main(List<String> args) {
  build(args, const [
    const ComponentGenerator()
  ], librarySearchPaths: ['web']).then((msg) {
    print(msg);
  });
}
```

Dart Editor will automatically run `build.dart` file. To configure
auto-build in [WebStorm](https://www.jetbrains.com/webstorm/), just
[add File Watcher](http://stackoverflow.com/questions/17266106/how-to-run-build-dart-in-webstorm).

## Examples

- [Hello](https://github.com/localvoid/uix/tree/master/example/hello)
- [Timer](https://github.com/localvoid/uix/tree/master/example/timer)
- [Collapsable](https://github.com/localvoid/uix/tree/master/example/collapsable)
- [Form](https://github.com/localvoid/uix/tree/master/example/form)
- [State Diff](https://github.com/localvoid/uix/tree/master/example/state_diff)
- [Read/Write DOM Batching](https://github.com/localvoid/uix/tree/master/example/read_write_batching)
- [Component Inheritance](https://github.com/localvoid/uix/tree/master/example/inheritance)
- [SVG](https://github.com/localvoid/uix/tree/master/example/svg)
- [TodoMVC (observable)](https://github.com/localvoid/uix_todomvc/)
- [TodoMVC (persistent)](https://github.com/localvoid/uix_todomvc_persistent/)
- [MineSweeper Game](https://github.com/localvoid/uix_minesweeper/)
- [Snake Game](https://github.com/localvoid/uix_snake/)
- [Dual N-Back Game](https://github.com/localvoid/dual_nback/)

## VDom Benchmark

- [Run](http://vdom-benchmark.github.io/vdom-benchmark/?cfg=http://localvoid.github.io/vdom-benchmark-uix/config.js)

## DBMonster Benchmark

- [Run](http://localvoid.github.io/uix_dbmon/)
- [Run](http://localvoid.github.io/uix_dbmon/classlist2) (compiled with [patched dart-sdk](https://code.google.com/p/dart/issues/detail?id=23012))

## Server-Side rendering

uix library with
[simple tweaks](https://github.com/localvoid/uix_standalone) is fully
capable to render components on the server and mounting on top of the
existing html tree. Unfortunately Dart doesn't support any usable way
to build uix Components this way. There are several proposals for
Configured Imports [1](https://github.com/lrhn/dep-configured-imports)
[2](https://github.com/eernstg/dep-configured-imports)
[3](https://github.com/munificent/dep-external-libraries/blob/master/Proposal.md)
that will solve some problems, but all this proposals will be really
bad in terms of developer experience for building isomorphic uix
components compared to simple conditional compilation.
