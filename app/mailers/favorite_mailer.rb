class FavoriteMailer < ApplicationMailer
  default from: "jdking33@aol.com"

  def new_comment(user, post, comment)
    headers["Message-ID"] = "<comments/#{comment.id}@https://arcane-meadow-26733.herokuapp.com>"
    headers["In-Reply-To"] = "<post/#{post.id}@https://arcane-meadow-26733.herokuapp.com>"
    headers["References"] = "<post/#{post.id}@https://arcane-meadow-26733.herokuapp.com>"

    @user = user
    @post = post
    @comment = comment

    mail(to: user.email, subject: "New comment on #{post.title}")
  end

  def new_post(user, post)
    headers["Message-ID"] = "<#{post.id}@https://arcane-meadow-26733.herokuapp.com>"
    headers["In-Reply-To"] = "<#{post.topic}/#{post.id}@https://arcane-meadow-26733.herokuapp.com>"
    headers["References"] = "<#{post.topic}/#{post.id}@https://arcane-meadow-26733.herokuapp.com>"

    @user = user
    @post = post

    mail(to: @user.email, subject: "Your new post: #{@post.title}")
  end
end