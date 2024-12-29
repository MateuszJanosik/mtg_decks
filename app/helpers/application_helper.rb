module ApplicationHelper
  def path_for_resource(resource, opts = {})
    PathGenerator.path_for(resource, opts)
  end

  def link_to_resource(resource, opts ={})     
    content_tag :a, href: path_for_resource(resource, opts) do
      resource.to_s
    end
  end

  def render_comments(resource = @resource)
    render partial: 'comments/comments', locals: { resource: resource }
  end
end
