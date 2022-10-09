---
title: '把 GitHub 的最早提交历史变为 1990 年'
date: 2022-10-09 12:00:00 +0900
categories: ['技术分享']
tags: ['toys', 'git']
img_path: /assets/images/2022-10-09-how-to-make-your-github-history-back-to-1990/
---

最近发现一个有趣的仓库（[GitHub - antfu/1990-script](https://github.com/antfu/1990-script)），可以把 GitHub 主页显示的提交历史变成 1990 年。

看起来就像这个样子：

![image](1.png){: width="300", height="300" }
_GitHub 主页_

## 用法

用法很简单，首先准备好 GitHub 用户名和 Access Token，
然后执行下面的代码：

```shell
$ sh -c "$(curl -fsSL https://raw.github.com/antfu/1990-script/master/index.sh)"
```

根据提示输入 GitHub 的用户名和 Access Token 就可以了。

## 原理

由于 Git 提交时可以使用 `GIT_AUTHOR_DATE` 和 `GIT_COMMITTER_DATE`  来手动指定时间
（如果不指定则使用当前时间）

> 关于 `GIT_AUTHOR_DATE` 和 `GIT_COMMITTER_DATE` 的区别，可以参考[这篇回答](https://stackoverflow.com/a/11857467){:target="_blank"}
{: .prompt-info }

脚本中创建了一个名为 `${YEAR}` 的仓库并进行了一次提交，提交时间指定为 1990 年 1 月 1 日。
把这个仓库推送到 GitHub 之后，GitHub 会分析账户中的提交历史，并且展示到主页上：

（2 次贡献分别为创建仓库和 README 的提交）

![image](2.png){: width="500", height="300" }
_1990 年的提交历史_

更详细的说明可以看仓库的 [README](https://github.com/antfu/1990-script#explanations){:target="_blank"}。

## 参考资料

- [GitHub - antfu/1990-script: Make your GitHub history back to 1990](https://github.com/antfu/1990-script){:target="_blank"}
