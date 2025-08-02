---
title: 'Claude Code 从入门到实践'
date: 2025-08-02 10:30:00 +0900
categories: ['技术分享']
tags: ['Claude', 'AI', 'CLI', 'DevTools']
img_path: /assets/images/2025-08-02-claude-code-from-beginner-to-practice/
published: true
---

## 什么是 Claude Code？

Claude Code 是 Anthropic 开发的命令行工具，让开发者能够在终端中直接与 Claude AI 协作进行编程任务。它不仅是一个聊天工具，更是一个强大的编程助手，能够：

- 读取和编辑代码文件
- 执行命令行操作
- 管理 Git 仓库
- 安装和配置开发环境
- 通过 MCP (Model Context Protocol) 扩展功能

> Claude Code 的核心价值在于将 AI 助手无缝集成到开发工作流程中，让编程变得更高效。
{: .prompt-info }

## 快速开始

### 安装

推荐使用 npm 安装：

```sh
npm install -g @anthropic-ai/claude-code
```

也可以使用官方安装脚本：

```sh
curl -fsSL https://install.anthropic.com | sh
```

### 首次使用

```sh
claude
```

首次运行时会提示进行身份验证，按照指示完成配置即可。

更多安装和配置详情：[Claude Code 官方文档](https://docs.anthropic.com/en/docs/claude-code/setup){:target="_blank"}

### 项目初始化

在新项目中，可以使用 `/init` 命令进行智能初始化：

```sh
/init
```

该命令会：
- 自动分析当前代码仓库的结构和技术栈
- 识别项目的开发工作流程和常用命令
- 自动生成 `CLAUDE.md` 配置文件
- 为项目定制 Claude 的行为和响应方式

> 使用 `/init` 可以让 Claude 更好地理解你的项目，提供更精准的帮助。
{: .prompt-tip }

## 核心功能

### 交互模式和快捷键

Claude Code 提供多种交互模式来优化工作流程：

**自动接受模式**
- 快捷键：<kbd>Shift</kbd> + <kbd>Tab</kbd>
- 功能：自动接受 Claude 的建议和操作
- 适用场景：信任 Claude 的操作时使用

**计划模式 (Plan Mode)**
- 快捷键：<kbd>Shift</kbd> + <kbd>Tab</kbd> (在自动模式基础上再按一次)
- 功能：Claude 会先制定计划，等待用户确认后再执行
- 适用场景：复杂任务或需要审查的操作

**其他快捷键**
- <kbd>Esc</kbd>：中断当前操作
- <kbd>Ctrl</kbd> + <kbd>C</kbd>：退出 Claude Code

### 上下文管理

Claude Code 支持多种方式为 AI 提供上下文信息：

#### 局部上下文
1. **选中文本**：在编辑器中选中代码后直接询问
2. **复制粘贴**：
   - 少量文本：直接粘贴
   - 大量文本：会显示缩略信息
3. **截图粘贴**：<kbd>Ctrl</kbd> + <kbd>V</kbd> 粘贴截图
4. **文件引用**：`@filename` 引用特定文件
5. **文件夹搜索**：`@/` 搜索整个文件夹
6. **URL 分析**：直接输入网址让 Claude 分析网页内容

#### 整体上下文
- `claude -c`：继续上次的会话 (continue)
- `claude -r`：恢复历史会话 (resume)
- `/clear`：清除当前会话，开始新对话
- `/compact <指令>`：手动压缩会话历史

### 记忆管理 (Claude Memories)

Claude Code 支持持久化记忆功能：

```sh
# 添加规则和偏好
\# 项目使用 TypeScript 严格模式
\# 代码风格遵循 Prettier 配置
\# 测试框架使用 Jest
```

这些记忆会自动保存到文件中，在后续会话中生效。

## MCP (Model Context Protocol) 扩展

MCP 是 Claude Code 的扩展系统，允许集成外部工具和服务。

### 安装常用 MCP 服务

**Context7** - 获取最新文档和代码示例：
```sh
claude mcp add --transport http context7 https://mcp.context7.com/mcp
```

**DeepWiki** - GitHub 仓库文档查询：
```sh
claude mcp add -s user -t http deepwiki https://mcp.deepwiki.com/mcp
```

**Playwright** - 浏览器自动化和网页操作：
```sh
claude mcp add playwright npx @playwright/mcp@latest
```

### MCP 管理命令

```sh
claude mcp list          # 列出已安装的 MCP 服务
claude mcp remove <name> # 移除 MCP 服务
```

## 最佳实践和工作流程

### 1. 探索-计划-编码-提交工作流

**探索阶段**
- 先阅读相关文件，不急于编写代码
- 使用 "think" 模式触发更深入的分析
- 理解代码库结构和约定

**计划阶段**
- 使用计划模式制定详细方案
- 确认方案的合理性
- 分解复杂任务为小步骤

**编码阶段**
- 逐步实现功能
- 遵循项目代码风格
- 及时测试验证

**提交阶段**
- 编写清晰的提交信息
- 确保代码质量

### 2. 测试驱动开发 (TDD)

```sh
# 示例工作流
claude "帮我为用户认证模块编写测试"
# Claude 编写测试用例
claude "运行测试确认失败"
# 实现功能代码
claude "再次运行测试确认通过"
```

### 3. 视觉迭代方法

特别适用于前端开发：

1. 提供设计稿或截图
2. Claude 实现初版
3. 截图对比效果
4. 迭代改进 2-3 次

### 4. 权限管理

使用 `/permissions` 命令管理 Claude 的操作权限：

```sh
/permissions            # 查看当前权限
/permissions allow git  # 允许 Git 操作
/permissions deny file  # 禁止文件编辑
```

### 5. 多实例协作

对于大型项目，可以：
- 使用多个 Claude 实例并行处理任务
- 利用 Git worktrees 进行独立开发
- 通过自定义斜杠命令简化重复工作流

## DevContainer 集成

在 `devcontainer.json` 中添加 Claude Code：

```json
{
  "features": {
    "ghcr.io/devcontainers/features/node:1": {},
    "ghcr.io/anthropics/devcontainer-features/claude-code:1": {}
  }
}
```

如果已有 Node.js 环境，只需添加：

```json
{
  "features": {
    "ghcr.io/anthropics/devcontainer-features/claude-code:1": {}
  }
}
```

参考：[DevContainer Features 文档](https://github.com/anthropics/devcontainer-features/blob/main/src/claude-code/README.md){:target="_blank"}

## 无头模式 (Headless Mode)

Claude Code 支持在脚本中使用：

```sh
# 流式输出 JSON 格式
claude -p "分析这个错误日志" --output-format stream-json

# 批处理模式
claude -p "重构这个函数" --auto-accept
```

适用于 CI/CD 管道和自动化脚本。

## CLAUDE.md 配置文件

为项目创建 `CLAUDE.md` 文件来：

- 记录常用命令和脚本
- 定义代码风格指南
- 说明项目结构和约定
- 提供开发环境设置说明
- 记录已知问题和注意事项

示例：

```markdown
# 项目配置

## 开发命令
npm run dev    # 启动开发服务器
npm run test   # 运行测试
npm run build  # 构建生产版本

## 代码风格
- 使用 TypeScript 严格模式
- 遵循 ESLint 和 Prettier 配置
- 组件使用 PascalCase 命名

## 注意事项
- API 端点需要认证
- 数据库连接使用环境变量
```

## 常见问题和解决方案

### 安装问题
- 确保 Node.js 版本 ≥ 18
- 检查网络连接和防火墙设置
- 使用 `claude --version` 验证安装

### 性能优化
- 定期使用 `/clear` 清理会话
- 合理使用 `/compact` 压缩历史
- 避免上传过大的文件或截图

### 权限问题
- 检查文件系统权限
- 确认 Git 仓库状态
- 使用 `/permissions` 调整权限设置

## 进阶技巧

### 自定义斜杠命令

创建项目特定的快捷命令：

```sh
# 在 CLAUDE.md 中定义
/deploy   # 部署到生产环境
/test-all # 运行完整测试套件
/lint-fix # 修复代码风格问题
```

### Git 集成最佳实践

```sh
# 让 Claude 帮助生成提交信息
claude "分析这些更改并生成合适的提交信息"

# 代码审查
claude "审查这个 Pull Request 的代码质量"

# 分支管理
claude "帮我创建功能分支并设置上游"
```

### 调试工作流

```sh
# 错误分析
claude "这个错误是什么原因？" @error.log

# 性能分析
claude "分析这个函数的时间复杂度" @utils.js

# 代码重构
claude "重构这个组件提高可读性" @component.jsx
```

## 参考资源

- [Claude Code 官方文档](https://docs.anthropic.com/en/docs/claude-code){:target="_blank"}
- [Claude Code 最佳实践](https://www.anthropic.com/engineering/claude-code-best-practices){:target="_blank"}
- [MCP 协议规范](https://modelcontextprotocol.io/){:target="_blank"}
- [DevContainer 集成指南](https://github.com/anthropics/devcontainer-features){:target="_blank"}