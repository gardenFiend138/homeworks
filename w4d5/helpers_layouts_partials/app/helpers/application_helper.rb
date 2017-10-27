module ApplicationHelper

  def auth_token
    #html_safe was giving me a no method error...not sure if it was
    # due to how I was escaping quotes at first?
    h('<input type=\"hidden\"
      name=\"authenticity_token\"
      value=\"#{form_authenticity_token}\"
      />')
  end
end
