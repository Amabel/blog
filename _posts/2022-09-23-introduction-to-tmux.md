---
title: '使用 tmux 来管理终端'
date: 2022-09-23 18:00:00 +0900
categories: ['技术分享']
tags: ['terminal', 'tmux']
img_path: /assets/images/2022-09-23-introduction-to-tmux/
image:
  path: cover.png
  width: 400
  height: 200
---

## 我为什么要用 tmux ？

作为一名（自称的）全栈工程师，在开发中往往会遇到需要在本地启动很多（5~10 个）服务的情况。

如果我们没有办法通过 Docker 来统一管理服务（例如统一启动服务以及日志的集中管理），
或是需要经常查看各个服务输出的 log 的情况下，
通常只能开多个终端窗口，或是在一个窗口中开启多个标签页，
这时终端往往会变成下面这个样子：

![image](1.png){: width="600", height="600" }
_请注意看顶部，有太多的标签页了_

这么多的标签页，我们很难快速定位到需要查看 log 的标签页（为每个标签页设定颜色可能有点用，但还是很麻烦）。

这时候就轮到我们的主角 tmux 登场了。

> 关于 tmux 的一些基础的使用方法（比如怎么安装？）不会在本文涉及，如有需要请自行查阅文档。相关链接会放到最下面。本文主要是写一些自己的理解和使用方法，以及一些实用但又经常容易忘记的东西。
{: .prompt-info }

## 介绍一下 tmux

[tmux](https://github.com/tmux/tmux){:target="_blank"} 是一款终端复用软件。
翻译成人话就是你可以在一个终端内同时管理多个终端，并且可以在多个终端之间自由切换。

对于上面的问题，我用 tmux 整理了一下就变成下面这个样子：
（由于我使用了）

![image](2.png){: width="600", height="600" }
_使用 tmux 来管理多个终端_

看起来是不是高大上了许多？没错，高端程序员的终端就应该是这个样子。

在这个界面中，我们可以同时看到多个不同的服务的 log，
而且可以随意切换到需要的终端并使其最大化。
这样一来，我们调试和写 bug 的速度一定会快很多 > <

> 由于我使用了[配置文件](#配置文件)，所以默认的界面看起来和图片上的会不太一样。
{: .prompt-info }

### tmux 中几个重要的概念

Session、 window 和 pane 是 tmux 中比较重要的概念，
了解这些概念可以帮助我们更好地管理多个终端。

Session
: 用于管理一个或多个 windows 的集合

Window
: 一个 window 会占据整个窗口的大小，可以将多个 windows 放入一个 session 中，
并且在不同的 windows 之间自由切换。一个 window 内可以包含多个 panes

Pane
: 一个 window 可以分割成多个 panes，一个 pane 相当于一个终端

来看一下这张图：

![image](3.png){: width="600", height="600" }
_tmux 中的 session、window 和 pane_

上面这张图用绿色和红色标出了 window 和 pane 的概念。
并且左下角标出了 session 和 windows 的名字，在这个 session 中有 2 个 windows，
名字分别为 「main」 和 「chore」。

下面这张图是切换 session 和 window 时的界面。这里显示了我们的电脑上总共有 3 个 sessions，并且显示了 session 下面的 windows 和 panes 的数量和名字。
（切换 session 和 window 有很多种方法，这只是其中的一种）

![image](4.png){: width="600", height="600" }
_切换 session、window 和 pane 的界面_

掌握了这些概念，我们就可以思考一下如何管理我们的终端了。

通常，我会把和某个项目相关的服务都丢进同一个 session 里面，并且把 session 命名为项目的名字。
在同一个项目中可能会有很多服务（从而导致有很多 panes），
这个时候我会在 session 中创建 2 个 windows，把需要一直监控的服务放到名为「main」的 window 中，
把剩余不常用的服务的放到另一个 window 中，
这样可以防止主要的 window 中不会有太多的 panes 而导致画面太乱的情况。

另外，对于多个项目共用的一些服务，比如 Redis 或是其他数据库，也可以单独新建一个 session，或是直接通过 `bg` 命令丢到后台运行，取决于你需不需要经常看输出的 log。

> 为 sessions 和 windows 取一个好名字非常重要。值得注意的是，panes 似乎不配拥有姓名，但 tmux 会自动为每个 pane 编上序号。
{: .prompt-info }

## 如何用好 tmux ？

首先需要说明 tmux 的操作大量依赖键盘快捷键（类似于 Vim），这对于初学的小伙伴们非常不友好。
与学习 Vim 相同，为了记住这些快捷键，只能通过多用多练，慢慢地自然就会熟悉啦。

我们先来看一下快捷键中 `<prefix>` 键的概念：

`<prefix>`
: 前缀键。顾名思义，我们在按下前缀键之后才能使用对应的快捷键，
否则这些快捷键会直接作用在终端而不是 tmux 上。
默认的前缀键是 <kbd>⌃</kbd> + <kbd>b</kbd>。可以在配置文件中更改。

那么怎么使用呢？举个栗子，在 tmux 中显示切换 session 和 window 的快捷键是 <kbd>s</kbd>，
那么我们需要先按下 <kbd>⌃</kbd> + <kbd>b</kbd>，然后（放开 <kbd>⌃</kbd> + <kbd>b</kbd>）再单独按下 <kbd>s</kbd>，
这样就会显示上面那张图的画面啦。

### 一些常用的快捷键

这里介绍一些我个人常用的快捷键。使用时请记得在前面加上 `<prefix>`。

|快捷键|说明|
|:-:|-|
|<kbd>s</kbd>|显示所有的 sessions|
|<kbd>w</kbd>|显示所有的 windows（与上面相似，但是会自动展开 windows）|
|<kbd>z</kbd>|将当前的 pane 最大化，再按一次则还原|
|<kbd>$</kbd>|重命名 session|
|<kbd>,</kbd>|重命名 window|
|<kbd>q</kbd>|显示每个 pane 的编号。在显示期间直接按下对应的数字可以快速切换到该 pane|
|<kbd>t</kbd>|显示时钟|
|<kbd>c</kbd>|创建一个新的 window|
|<kbd>&</kbd>|关闭（删除）当前的 window|
|<kbd>%</kbd>|在右边创建一个新的 pane|
|<kbd>"</kbd>|在下边创建一个新的 pane|
|<kbd>x</kbd>|关闭（删除）当前的 pane|

更多复杂的快捷键可以看下面的网站：

- [Tmux Cheat Sheet & Quick Reference](https://tmuxcheatsheet.com/){:target="_blank"}
- [tmux(1) - OpenBSD manual page](http://man.openbsd.org/tmux.1){:target="_blank"}


### 配置文件

我目前是在使用 [GitHub - gpakosz/.tmux](https://github.com/gpakosz/.tmux){:target="_blank"}，在 GitHub 上应该算是很热门的配置文件了。

介绍几点比较重要的改进：

1. 新增了 <kbd>⌃</kbd> + <kbd>a</kbd> 作为 `<prefix>` 键，因为 <kbd>a</kbd> 和 <kbd>⌃</kbd> 的距离更近，方便使用。（<kbd>⌃</kbd> + <kbd>b</kbd> 依然有效）
2. UI 界面的美化，以及添加了电脑开机时间的显示
3. 创建 pane 的快捷键从原来的 <kbd>%</kbd> 和 <kbd>"</kbd> 改为 <kbd>|</kbd> 和 <kbd>-</kbd>，用横线和竖线来分割 pane，更加直观
4. 新增快捷键 <kbd>m</kbd> 用于切换鼠标模式，在鼠标模式下可以通过点击来快速切换 pane，通过拖拽改变 pane 的大小，通过滚轮控制终端显示的滚动，选中内容后自动复制等

完整的特性可以看 [这里](https://github.com/gpakosz/.tmux#features){:target="_blank"}

### 参考资料

- [GitHub - tmux/tmux: tmux source code](https://github.com/tmux/tmux){:target="_blank"}
- [Tmux Cheat Sheet & Quick Reference](https://tmuxcheatsheet.com/){:target="_blank"}
