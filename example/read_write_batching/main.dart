// Copyright (c) 2015, the uix project authors. Please see the AUTHORS file for
// details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library uix.example.read_write_batching.main;

import 'dart:html' as html;
import 'package:uix/uix.dart';

part 'main.g.dart';

@ComponentMeta()
class OuterBox extends Component {
  updateView() {
    updateRoot(vRoot(type: 'OuterBox')(vBox()));
  }
}

@ComponentMeta()
class InnerBox extends Component {
  updateView() {
    updateRoot(vRoot(type: 'InnerBox')('x'));
  }
}

@ComponentMeta()
class Box extends Component {
  int _outerWidth = 0;
  int _innerWidth = 0;

  init() {
    addSubscription(html.window.onResize.listen(invalidate));
  }

  updateView() async {
    final innerBox = vInnerBox();
    updateRoot(_build(innerBox));

    await scheduler.currentFrame.read();
    _outerWidth = parent.element.clientWidth;
    _innerWidth = innerBox.ref.clientWidth;

    await scheduler.currentFrame.write();
    updateRoot(_build(vInnerBox()));
  }

  _build(innerBox) => vRoot()([
    vElement('div')('Outer $_outerWidth'),
    vElement('div')('Inner $_innerWidth'),
    innerBox
  ]);
}

@ComponentMeta()
class App extends Component {
  updateView() {
    updateRoot(vRoot()([
      vOuterBox(),
      vOuterBox(),
      vOuterBox()
    ]));
  }
}

main() {
  initUix();

  scheduler.zone.run(() {
    scheduler.nextFrame.write().then((_) {
      injectComponent(createApp(), html.document.body);
    });
  });
}
