module ApplicationHelper
  def path_for_resource(resource, opts = {})
    PathGenerator.new(resource, opts).path
  end

  def link_to_resource(resource, opts = {})
    link_to resource.to_s, path_for_resource(resource, opts)
  end

  def render_comments(resource = @resource)
    render partial: "comments/comments", locals: { resource: resource }
  end
end
