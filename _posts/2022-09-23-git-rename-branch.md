---
title: '如何重命名 Git 分支'
date: 2022-09-23 12:00:00 +0900
categories: ['技术分享']
tags: ['git', 'branch']
---

工作中经常会遇到分支已经推到远程了之后发现命名有错误，需要修改分支名字的情况。

在队友发现之前可以通过下面的步骤赶紧改回来

> 如果已经创建了 Pull Request 并且有 Review 之后就不建议再改名字啦，因为 GitHub 在你删除分支之后会自动关闭相关的 PR，再开新 PR 的话之前的 Review 找起来会很麻烦。
{: .prompt-warning }

## 1. 在本地重命名你的分支

确保你已经在需要修改名字的分支上

```shell
$ git branch -m new-name
```

## 2. 删除远程分支，并推送重命名后的分支

```shell
$ git push origin :old-name new-name
```

> 关于使用冒号 `:` 来删除分支，可以看 [这篇回答](https://stackoverflow.com/a/7303710){:target="_blank"}
{: .prompt-tip }

## 3. 将 upstream 重设为 origin 上新的分支

```shell
$ git push origin -u new-name
```

设定完成之后就可以正常使用啦。

## 参考资料

- [Rename a local and remote branch in git &#8211; Multiple States Knowledge Base](https://multiplestates.wordpress.com/2015/02/05/rename-a-local-and-remote-branch-in-git/){:target="_blank"}
