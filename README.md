# Kamikakushi

```
class Post
  include Kamikakushi
end
```

```
post = Post.create(title: 'demo')
post.destroy
post.destroyed? # true
post.restore
post.destroyed? # false
```
