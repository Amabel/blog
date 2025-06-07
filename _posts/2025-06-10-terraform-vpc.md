---
title: 'AWS 基础网络服务实战（一）：使用 Terraform 创建 VPC'
date: 2025-06-06 10:00:00 +0900
categories: ['技术分享']
tags: ['terraform', 'aws', 'vpc', 'iaas']
img_path: /assets/images/2025-06-6-terraform-vpc/
---

## VPC 基础与应用场景

在 AWS 上部署服务，第一步就是构建属于自己的网络环境。VPC（Virtual Private Cloud）让你可以像搭积木一样，定制自己的云上网络结构，隔离、管理和保护你的资源。

> 本文将介绍如何用 Terraform 快速搭建一个自定义 VPC，并给出完整代码和最佳实践。

## VPC 的核心概念

- **CIDR 块**：定义网络的 IP 范围，比如 `10.0.0.0/16`
- **子网（Subnet）**：VPC 内的子网络，通常分为公有和私有
- **路由表（Route Table）**：决定流量如何在子网和外部之间流动
- **Internet Gateway**：让 VPC 内的资源可以访问互联网
- **NAT Gateway**：让私有子网的资源可以访问互联网，但外部无法主动访问它们

![VPC 基本结构](1.jpg){: width="600", height="350" }
_一个典型的 VPC 结构，包含公有和私有子网_

## 用 Terraform 创建 VPC

### 1. 初始化 Terraform 项目

在开始之前，建议新建一个目录用于本次实验，并初始化 Terraform：

```bash
mkdir terraform-vpc-demo && cd terraform-vpc-demo
terraform init
```

### 2. 资源规划与配置说明

在 AWS 网络基础设施中，通常需要以下核心资源：
- **VPC**：定义整个网络的 IP 范围，是所有资源的容器。
- **子网（Subnet）**：VPC 内的子网络，分为公有子网（可直连互联网）和私有子网（仅内网访问）。
- **Internet Gateway**：为公有子网提供互联网访问能力。
- **NAT Gateway**：为私有子网提供出网能力。
- **路由表（Route Table）**：控制子网的流量走向。

下面将逐步用 Terraform 创建这些资源。

#### 创建 VPC

`main.tf` 示例：

```hcl
provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"  # 定义 VPC 的 IP 范围
  enable_dns_support   = true           # 启用 DNS 解析
  enable_dns_hostnames = true           # 启用 DNS 主机名

  tags = {
    Name = "demo-vpc"
  }
}
```

- `cidr_block`：VPC 的 IP 地址范围。
- `enable_dns_support` 和 `enable_dns_hostnames`：建议开启，便于后续资源通过域名互通。

#### 创建公有子网、私有子网与 Internet Gateway

在实际生产环境中，通常会将子网分为公有和私有：
- **公有子网**：可直接访问互联网，适合部署 Web 服务器等需要公网访问的资源。
- **私有子网**：无法直接访问互联网，适合部署数据库、应用服务器等内网资源。

**区别说明**：
- 公有子网通过 Internet Gateway 访问互联网。
- 私有子网通常通过 NAT Gateway 访问互联网，外部无法主动访问。

```hcl
# 公有子网
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"  # 公有子网 IP 段
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true            # 自动分配公网 IP

  tags = {
    Name = "public-subnet"
  }
}

# 私有子网
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"  # 私有子网 IP 段
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "private-subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "demo-igw"
  }
}

# 公有路由表
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-rt"
  }
}

# 公有子网关联路由表
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
```

- `aws_subnet.public`：公有子网，自动分配公网 IP。
- `aws_subnet.private`：私有子网，不分配公网 IP。
- `aws_internet_gateway.gw`：为 VPC 提供互联网访问。
- `aws_route_table.public`：公有路由表，所有流量通过 IGW 出网。
- `aws_route_table_association.public`：将公有子网与公有路由表关联。

> **补充**：如需让私有子网访问互联网，还需创建 NAT Gateway 和私有路由表，后续章节会详细介绍。

### 3. 应用配置

```bash
terraform plan
terraform apply
```

几分钟后，你就拥有了一个带有公有和私有子网的 VPC！

## 最佳实践

- **合理划分 CIDR**，避免与公司内网冲突
- **开启 DNS 支持**，方便资源间通过域名通信
- **资源命名规范**，便于后续维护
- **使用变量和模块**，提升可复用性（后续章节会详细介绍）

## 参考资料

- [Terraform AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc){:target="_blank"}
- [AWS VPC 官方文档](https://docs.aws.amazon.com/vpc/latest/userguide/){:target="_blank"}
- [VPC 设计最佳实践](https://aws.amazon.com/cn/architecture/vpc-design/){:target="_blank"}
