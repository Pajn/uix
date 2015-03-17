// Copyright (c) 2015, the uix project authors. Please see the AUTHORS file for
// details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library uix.src.component;

import 'dart:async';
import 'dart:html' as html;
import 'vcontext.dart';
import 'vnode.dart';
import 'env.dart';

abstract class Component<P> implements VContext {
  static const dirtyFlag = 1;
  static const attachedFlag = 1 << 1;
  static const domAttachedFlag = 1 << 2;

  String get tag => 'div';

  int flags = dirtyFlag;
  int depth = 0;
  Component _parent;
  P data;
  html.Element element;
  VNode _root;

  Component get parent => _parent;
  set parent(Component c) {
    _parent = c;
    depth = c.depth + 1;
  }

  VNode get root => _root;
  set root(VNode n) {
    if (n != null) {
      if (_root == null) {
        n.ref = element;
        n.cref = this;
        n.render(this);
      } else {
        _root.update(n, this);
      }
      _root = n;
    }
  }

  List<VNode> get children => null;
  set children(List<VNode> c) {}

  bool get isDirty => (flags & dirtyFlag) != 0;
  bool get isAttached => (flags & attachedFlag) != 0;
  bool get isDomAttached => (flags & domAttachedFlag) != 0;

  Component() {
    element = html.document.createElement(tag);
    init();
  }

  void init() {}

  void update() {
    if ((flags & (dirtyFlag | attachedFlag)) == (dirtyFlag | attachedFlag)) {
      if (updateState()) {
        updateView();
      }
      flags &= ~dirtyFlag;
    }
  }

  bool updateState() => true;
  void updateView() { root = build(); }

  VNode build() => null;

  void invalidate() {
    if ((flags & dirtyFlag) == 0) {
      flags |= dirtyFlag;

      if (identical(Zone.current, scheduler.zone)) {
        scheduler.nextFrame.write(depth).then(_invalidatedUpdate);
      } else {
        scheduler.zone.run(() {
          scheduler.nextFrame.write(depth).then(_invalidatedUpdate);
        });
      }
    }
  }

  void _invalidatedUpdate(_) { update(); }

  void dispose() {}

  void attached() {}
  void detached() {}

  void attach() {
    assert(!isAttached);
    flags |= attachedFlag;
    attached();
    if (_root != null) {
      _root.attach();
    }
  }

  void detach() {
    assert(isAttached);
    if (_root != null) {
      _root.detached();
    }
    flags &= ~attachedFlag;
    detached();
  }
}