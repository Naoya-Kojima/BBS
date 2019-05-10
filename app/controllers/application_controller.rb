class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found
    render file: Rails.root.join('public/404.html'), status: 404, layout: false, content_type: 'text/html'
  end
end
