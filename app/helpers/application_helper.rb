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
end
