# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Jekyll-based blog using the Chirpy theme. The blog is written primarily in Chinese with some English content and contains technical articles and personal updates.

## Development Commands

### Install Dependencies
```bash
bundle install
```

### Local Development Server
```bash
bundle exec jekyll s --livereload

# For WSL users (if permissions are required):
sudo bundle exec jekyll s --livereload

# Site will be available at: http://127.0.0.1:4000/
```

### Build for Production
```bash
JEKYLL_ENV=production bundle exec jekyll build
```

### Test Site (HTML Proofer)
```bash
bundle exec htmlproofer --disable-external --check-html --allow_hash_href _site
```

## Project Structure

### Content Organization
- `_posts/`: Blog posts in Markdown format with YAML front matter
- `_tabs/`: Static pages (About, Archives, Categories, Tags)
- `_data/`: Site configuration data including locales and contact info
- `assets/images/`: Image assets organized by post date

### Key Configuration Files
- `_config.yml`: Main Jekyll configuration with site metadata, theme settings, and build options
- `Gemfile`: Ruby dependencies including jekyll-theme-chirpy

### Plugins and Customization
- `_plugins/posts-lastmod-hook.rb`: Automatically sets last_modified_at from git history
- Theme: jekyll-theme-chirpy (~> 5.6)

## Post Creation Guidelines

### File Naming Convention
Posts should follow the pattern: `YYYY-MM-DD-title.md` in the `_posts/` directory.

### Front Matter Template
Use the template in `_posts/_2025-xx-xx-template.md`:
```yaml
---
title: '标题'
date: 2025-01-01 10:30:00 +0900
categories: ['技术分享']  # Optional
tags: ['tag1', 'tag2']   # Optional
img_path: /assets/images/YYYY-MM-DD-post-name/  # Optional
image:                   # Optional
  path: cover.png
  width: 300
  height: 200
published: true
---
```

### Image Organization
Images should be placed in `assets/images/YYYY-MM-DD-post-name/` matching the post date and name.

## Writing Style Guidelines

### Text Formatting
- **Chinese-English Spacing**: Always add spaces between Chinese and English text
  - ✅ Correct: `使用 tmux 来管理终端`
  - ❌ Incorrect: `使用tmux来管理终端`
- **Punctuation**: Use Chinese punctuation (，。？！) for Chinese content, English punctuation for English content

### Links
- When referencing URLs, fetch the page title and use it as the link text
- Always add `{:target="_blank"}` to open links in new tabs
- Format: `[Page Title](URL){:target="_blank"}`
- Examples:
  - `[tmux](https://github.com/tmux/tmux){:target="_blank"}`
  - `[Homebrew](https://brew.sh/)`

### Images
- Use Jekyll image syntax with size parameters
- Add descriptive captions using italic text with underscore
- Format: `![image](filename.png){: width="600", height="600" }`
- Follow with caption: `_图片描述_`
- Example:
  ```markdown
  ![image](1.png){: width="600", height="600" }
  _请注意看顶部，有太多的标签页了_
  ```

### Code Blocks
- Always specify language for syntax highlighting
- Use `sh` or `bash` for shell commands
- Example:
  ```sh
  bundle exec jekyll s --livereload
  ```

### Special Elements
- **Prompt boxes**: Use Jekyll prompt syntax for tips and warnings
  - Info: `{: .prompt-info }`
  - Warning: `{: .prompt-warning }`
  - Tip: `{: .prompt-tip }`
- **Keyboard shortcuts**: Use `<kbd>` tags for key combinations
  - Example: `<kbd>⌃</kbd> + <kbd>b</kbd>`
- **Tables**: Use standard markdown table format with alignment
- **Definition lists**: Use Jekyll definition list syntax for glossaries

## Site Configuration

- **Primary Language**: Chinese (zh-CN), with English locale support
- **Timezone**: Asia/Tokyo
- **Analytics**: Google Analytics enabled (G-VKVSH409BQ)
- **Comments**: Configured but not currently active
- **PWA**: Enabled for offline support
- **Pagination**: 10 posts per page

## Theme Customization

The site uses the Chirpy theme with:
- Custom avatar from GitHub
- Table of Contents enabled for posts
- Syntax highlighting with Rouge
- Responsive design with dark/light mode toggle

## Git Commit Guidelines

### Commit Message Format
Follow the conventional commit format used in this repository:

- `feat: add post` - for new blog posts
- `feat: update post` - for updating existing posts  
- `feat: update template` - for template modifications
- `fix: correct typo in post` - for bug fixes
- `docs: update readme` - for documentation changes
- `style: improve formatting` - for code formatting changes

### Commit Rules
- Use lowercase after the colon
- Keep messages concise and descriptive
- Use imperative mood (e.g., "add", "update", "fix")
- No period at the end of commit messages

## Deployment

The site deploys automatically to GitHub Pages via GitHub Actions when code is pushed to the `master` branch.

The deployment workflow (`.github/workflows/deploy.yml`):
1. Sets up Ruby 3.2.1 environment
2. Installs dependencies with bundler
3. Builds the site with `JEKYLL_ENV=production bundle exec jekyll build`
4. Deploys to GitHub Pages using `peaceiris/actions-gh-pages@v3`
