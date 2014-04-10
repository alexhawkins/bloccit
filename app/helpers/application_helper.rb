module ApplicationHelper
  #Set the full title here that you will use for Breadcrumbs. 
  #That way, if we change the home page name, we
  #only have to change it once.
  def home_title
    home_title = "Bloccit"
    home_title
  end

  def render_user_info(user)
    "#{user.name}, #{user.email}"
  end

  def form_group_tag(errors, &block)
    if errors.any?
      content_tag :div, capture(&block), class: 'form-group has-error'
    else
      content_tag :div, capture(&block), class: 'form-group'
    end
  end

  def markdown(text)
    renderer = Redcarpet::Render::HTML.new
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render text).html_safe
  end
## RENDER AVATAR IMAGE FOR NAVIGATION (DEFAULT or USER)
  def render_tiny_avatar_for(user)
    if current_user.avatar?
      image_tag(current_user.avatar.tiny.url).html_safe
    else
      image_tag('fallback/default.gif', height: '25px', width: '25px').html_safe
    end
  end
## RENDER AVATAR IMAGE FOR RELATED POSTS LISTS
  def render_super_tiny_avatar_for(user)
    if current_user.avatar?
      image_tag(current_user.avatar.tiny.url).html_safe
    else
      image_tag('fallback/default.gif', height: '20px', width: '20px').html_safe
    end
  end

  ## RENDER AVATAR FOR ABOUT COMMENT SECTION
  def render_comment_avatar_for(comment_user)
    if comment_user.avatar?
      image_tag(comment_user.avatar.profile.url, class: "media-object thumbnail").html_safe
    else
      image_tag('fallback/default.gif', height: '45px', width: '45px', class: "media-object thumbnail").html_safe
    end
  end

## RENDER AVATAR FOR ABOUT AUTHOR SECTION
  def render_author_avatar_for(post_user)
    if post_user.avatar?
      image_tag(post_user.avatar.url, class: "media-object thumbnail").html_safe
    else
      image_tag('fallback/default.gif', height: '90px', width: '90px', class: "media-object thumbnail").html_safe
    end
  end
## RENDER TINY AVATAR FOR INDEX PAGES
  def render_tiny_author_avatar_for(post_user)
    if post_user.avatar?
      image_tag(post_user.avatar.tiny.url).html_safe
    else
      image_tag('fallback/default.gif', height: '20px', width: '20px').html_safe
    end
  end
## RENDER SMALL POST IMAGE FOR AUTHOR POSTS
  def render_small_post_image_for(post)
    if post.image?
      image_tag(post.image_thumb.url, class: 'media-object thumbnail')
    else
      image_tag('fallback/default_image.jpg', class: 'media-object thumbnail', height: '50px', width: '75px')
    end
  end
#This method will return exactly what we need for our comment partial 
# - an array of topic, post and comment objects
  def comment_url_helper(comment)
    post = comment.post
    topic = post.topic
    [topic, post, comment]
  end
end
