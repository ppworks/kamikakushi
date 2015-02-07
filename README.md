# Kamikakushi

very very simple soft deletion gem:)

```
class Post < ActiveRecord::Base
  kamikakushi
end
```

```
class Comment < ActiveRecord::Base
  kaonashi parent: :post
  belongs_to :post
end
```

## usage

```
post = Post.create(title: 'demo')
post.destroy
post.destroyed? # true
post.restore
post.destroyed? # false
post.purge # real destroy
post.reload # raise ActiveRecord::RecordNotFound
```

```
post = Post.create(title: 'demo')
comment = post.comments.create(content: 'hoge')
post.destroy
comments.destroyed? # true
```

## scope

`with_deleted`, `without_deleted`, `only_deleted`
