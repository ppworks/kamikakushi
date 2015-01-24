# Kamikakushi

very very simple soft deletion gem:)

```
class Post < ActiveRecord::Base
  include Kamikakushi
end
```

## usage

```
post = Post.create(title: 'demo')
post.destroy
post.destroyed? # true
post.restore
post.destroyed? # false
post.destroy!
post.reload # raise ActiveRecord::RecordNotFound
```

## scope

`with_deleted`, `without_deleted`, `only_deleted`
