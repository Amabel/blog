---
title: '关于 JWT 的签名和验证'
date: 2022-10-16 10:30:00 +0900
categories: ['技术分享']
tags: ['jwt', 'openid']
---

介绍 JWT（JSON Web Token）的文章有很多，
这里主要讲一下 JWT 的签名和验证，以及为什么签名是可信的。

> 由于 JWT 的签名和验证过程比较繁琐，一般情况下不需要自己手动实现。
>
> 我们可以通过调用已经封装好的库来轻松验证 JWT 是否有效，以及获取里面的信息。
>
> 这里是一些可用的库：[JSON Web Token Libraries - jwt.io](https://jwt.io/libraries)
{: .prompt-info }

## JWT 签名和验证的过程

首先来看一下 JWT 的结构，下面是一个有效的 JWT：

```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c
```

这个长字符串被 2 个 `.` 分成 3 个部分 （segment），
我们把这三个部分分别叫做 头部（Header）、载荷（Payload） 和 签名（Signature）。

其中，Header 和 Payload 是通过 Base64 转码的，所以我们可以通过解码来获取实际的值：

Header
```javascript
base64UrlDecode('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9')
=>
{
  "alg": "HS256",
  "typ": "JWT"
}
```
{: file='header' }

`alg` 表示签名哈希使用的算法，
常用的值有 RS256（RSA-SHA256）和 HS256（HMAC-SHA256）。
如果想看所有的算法可以看这篇文章：[RFC 7518: JSON Web Algorithms (JWA)](https://www.rfc-editor.org/rfc/rfc7518#page-6)

Payload
```javascript
base64UrlDecode('eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ')
=>
{
  "sub": "1234567890",
  "name": "John Doe",
  "iat": 1516239022
}
```
{: file='payload' }

## 签名

签名（Signature） 是通过对 Base64 转码后的前两部分进行哈希（SHA256）后，再进行加密得到的结果：

> 注意签名时使用的哈希的算法必须要在 Header 的 `alg` 字段里说明，
这样接受方才能用对应的算法进行验证。本文的例子中用的是 HS256 算法
{: .prompt-warning }

Signature
```javascript
HMAC(
  SHA256(
    eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9 +
    "." +
    eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ
  )
  , 'your-256-bit-secret'
)
=>
SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c
```
{: file='payload' }

关于 JWT 的生成，可以记住这个公式：

```javascript
jwt = base64UrlEncode(header).base64UrlEncode(payload).HMAC(SHA256(base64UrlEncode(header) + "." + base64UrlEncode(payload)), secret)
```
{: file='jwt' }

### 验证

由于 JWT 的 Payload 仅仅是通过 Base64 转码，
因此我们需要验证它的真实性，以保证它不是被人篡改过的。

首先我们需要对 Payload 进行 Base64 解码，并获取签名哈希的算法：

（与上面相同）

```javascript
base64UrlDecode('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9')
=>
{
  "alg": "HS256",
  "typ": "JWT"
}
```
{: file='header' }

解码后，我们看到这个 JWT 使用了 `HS256` 算法进行签名。

所以我们需要使用相应的算法和密钥来验证签名。

> 在 HMAC 和 RSA 算法中签名和验证都需要使用密钥，
> 第三者在没有获得密钥的情况下无法伪造出正确的签名，所以这个验证方法是可信的。
{: .prompt-info }

### RS256 和 HS256 的区别

两者的区别主要在于 RS256 是非对称算法（需要公钥和私钥），
而 HS256 则是对称算法（只有私钥）。
应该根据实际情况来选择合适的算法（官方则是推荐 RS256 算法）

#### RS256

由于私钥存放在本地，公钥存放在网络上并且可以随时被获取，
所以可以同时为多方提供服务（如谷歌等提供的 OpenID 服务）

在私钥泄露时，只需要更换本地的私钥以及网络上的公钥即可。

#### HS256

需要双方事先交换密钥，并且保证密钥的安全。
如果需要同时为多方提供服务时，会导致多方共用密钥，因此不安全。

密钥不慎泄露时需要双方同时更换密钥，因此比较麻烦。

## 参考资料

- [JWT详解_baobao555#的博客-CSDN博客_jwt](https://blog.csdn.net/weixin_45070175/article/details/118559272){:target="_blank"}
- [Signing and Validating JSON Web Tokens (JWT) For Everyone](https://dev.to/kimmaida/signing-and-validating-json-web-tokens-jwt-for-everyone-25fb){:target="_blank"}
- [RFC 7519: JSON Web Token (JWT)](https://www.rfc-editor.org/rfc/rfc7519#section-5.1){:target="_blank"}
- [How to Explain Public-Key Cryptography and Digital Signatures to Non-Techies](https://auth0.com/blog/how-to-explain-public-key-cryptography-digital-signatures-to-anyone/){:target="_blank"}
- [jwt - RS256 vs HS256: What's the difference? - Stack Overflow](https://stackoverflow.com/questions/39239051/rs256-vs-hs256-whats-the-difference){:target="_blank"}
