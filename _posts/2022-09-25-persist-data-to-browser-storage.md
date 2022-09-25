---
title: '用 Storage 来进行前端数据持久化'
date: 2022-09-25 12:30:00 +0900
categories: ['技术分享']
tags: ['data persistence', 'local storage', 'session storage']
---

## 为什么要持久化？

想象一个场景，在一个页面中可以设定主题是深色模式或是浅色模式（就和这个博客左侧菜单下方的按钮一样）。

如果我们不做持久化，那么即使改变了主题颜色，在刷新页面之后由于数据的丢失，又会变回原来的主题。
这对用户来说很不友好。

为了防止数据丢失，我们把一些数据（或设定）存入硬盘或内存中，
下次需要的时候直接读取并使用这些数据，就可以达到保存用户的数据（或设定）的目的啦。

## 怎么持久化？

在 Web 应用中持久化可以分为前端和后端，
前端持久化又有几种方法：

1. **Local Storage**
2. **Session Storage**
3. Cookies
4. IndexedDB

今天主要讲一下 Local Storage 和 Session Storage。

### Local Storage

`window.localStorage` 中的数据以键值对进行存储，
在浏览器的普通模式下，Local Storage 的数据会被存储到硬盘中，直到被主动删除。

介绍 4 个常用的 API：

```javascript
// 将 theme 的值设置为 'dark'
localStorage.setItem('theme', 'dark');

// 获取 theme 的值
const theme = localStorage.getItem('theme');

// 删除 theme 键
localStorage.removeItem('theme');

// 删除 storage 中所有的键
localStorage.clear();
```

完整的 API 在这里：[Storage - Web APIs \| MDN](https://developer.mozilla.org/en-US/docs/Web/API/Storage){:target="_blank"}

#### 值得注意的几个点

1. 建议不要把敏感数据如 Token 放在 Local Storage 中。因为如果网站受到 XSS 攻击可能会导致 Local Storage 中的内容泄露。
2. Local Storage 中的值只能以 string 类型存储，因此如果需要存对象类型，就要自己负责转换和解析 JSON 字符串。
3. 接上条，`null`，`undefined` 等特殊值也会被自动转成 string，因此也需要特殊处理。
4. 在隐私（Private 或者 Incognito）模式下，Local Storage 的数据会在所有隐私模式的窗口关闭后被清除。（具体清除的时机请以各个浏览器的实现为准）
5. 在隐私模式下，Local Storage 的数据共享模式根据不同的浏览器的实现有所不同。已知的有，Chrome 浏览器中所有的 Tab 都会共享同一个 Local Storage。而在 Safari 浏览器中，每个 Tab 的 Local Storage 都是独立的，它们之间的数据无法共享。
6. 可存储的数据大小一般为 5MB 左右。

### Session Storage

与 Local Storage 大致相同，主要区别是 Session Storage 生命周期只存在于一个 Session 中，
每当我们打开一个新的 Tab 时，就会创建一个新的 Session，
因此不同的 Tab 之间的 Session Storage 无法共享。

> 当 Tab 被关闭后，Session Storage 中的数据也会被清除。
{: .prompt-info}

### 选择合适的 Storage

我们可以根据实际需求来选择使用 Local Storage 或是 Session Storage。

以设定主题颜色为例，如果使用 Local Storage，那么即使用户关闭浏览器，
下次打开时也可以维持上次选择过的主题颜色。

而如果使用 Session Storage，那么只能在刷新页面后维持主题颜色，
当用户关闭浏览器或是新开一个 Tab 的时候又会变回初始的主题颜色。

## 参考

- [Storage - Web APIs \| MDN](https://developer.mozilla.org/en-US/docs/Web/API/Storage){:target="_blank"}
- [How Chrome Incognito keeps your browsing private - Google Chrome Help](https://support.google.com/chrome/answer/9845881){:target="_blank"}
