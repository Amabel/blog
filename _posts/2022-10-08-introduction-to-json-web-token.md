---
title: '聊一聊 JWT'
date: 2022-10-08 10:30:00 +0900
# categories: ['']
# tags: ['']
# img_path: /assets/images/2022-xx-xx-template/
# image:
#   path: cover.png
#   width: 300
#   height: 200
---

## JWT 签名和验证的过程

由于 JWT 的签名和验证过程繁琐，一般情况下不需要自己手动实现。

我们可以通过调用已经封装好的库来轻松验证 JWT 是否有效，以及获取里面的信息。

这里是一些可用的库：[JSON Web Token Libraries - jwt.io](https://jwt.io/libraries)



### 签名

### 验证


#### 对 Header 和 Payload 进行解码

由于 Header 和 Payload 是 Base64 编码的，我们可以通过解码来轻松获取它们的值。




## 参考资料

- [JWT详解_baobao555#的博客-CSDN博客_jwt](https://blog.csdn.net/weixin_45070175/article/details/118559272)
- [Signing and Validating JSON Web Tokens (JWT) For Everyone](https://dev.to/kimmaida/signing-and-validating-json-web-tokens-jwt-for-everyone-25fb)
