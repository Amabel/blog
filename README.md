# Amabel's blog

Welcome to my blog. This blog is built with [Jekyll](https://jekyllrb.com/) and [Chirpy](https://github.com/cotes2020/jekyll-theme-chirpy/) theme.


## Local Development

### Install Dependencies

```sh
bundle install
```

### Start Application

```sh
# When using WSL, you need to add sudo
bundle exec jekyll s --livereload
sudo bundle exec jekyll s --livereload

# http://127.0.0.1:4000/
```

### Upgrade `jekyll-theme-chirpy`

1. Replace content in [Gemfile](./Gemfile) with [chirpy-starter
](https://github.com/cotes2020/chirpy-starter/blob/main/Gemfile)
2. Run `bundle install`

## License

Except where otherwise noted, the blog posts are licensed under the [CC BY 4.0 License](https://github.com/Amabel/blog/blob/master/LICENSE).
