---
title: 'AWS CLI 常用命令整理'
date: 2024-03-21 10:30:00 +0900
categories: ['技术分享']
tags: ['aws', 'aws-cli']
# img_path: /assets/images/2022-xx-xx-template/
# image:
#   path: cover.png
#   width: 300
#   height: 200
published: false
---

[AWS CLI 文档](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/index.html){:target="_blank"}

## 安装 AWS CLI

安装方法参考[官方文档](https://docs.aws.amazon.com/zh_cn/cli/latest/userguide/getting-started-install.html){:target="_blank"}

```sh
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /

# 确认安装成功
which aws
aws --version
```


## 配置 Profile

配置 default profile

```sh
# 配置 default profile
aws configure

# 配置指定的 profile
aws configure --profile <profile>

# 查看 profile
code ~/.aws
```

## 常用的 Service

### S3

```sh
# 查看 Buckets
aws s3 ls

# 创建 Bucket
aws s3 mb s3://<bucket-name>

# 删除 Bucket
aws s3 rb s3://<bucket-name>

# 删除 Object
aws s3 rm s3://<bucket-name>/<object-key>

# 查看 Bucket 中的所有内容
aws s3 ls s3://<bucket-name> --recursive
```

### SSM

```sh
# 列出所有 Parameters
aws ssm list-parameters

# 获得 Parameter
aws ssm get-parameter --name <parameter-name>
```

### SQS

### CloudWatch

```sh
# 查看 LogGroup
aws logs tail <log-group-name>

# 查看 LogGroup 并自动获取新的 Log
aws logs tail <log-group-name> --follow

# 搜索 Log
aws logs filter-log-events --log-group-name <log-group-name> --filter-pattern <filter-pattern>
```

### Lambda

### EC2


## 参考资料

- [aws — AWS CLI 2.15.30 Command Reference](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/index.html){:target="_blank"}
