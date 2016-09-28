# frozen_string_literal: true
require "rails"
require "active_support/all"

require "devise"
require "devise_invitable"
require "jquery-rails"
require "sass-rails"
require "turbolinks"
require "jquery-turbolinks"
require "foundation-rails"
require "foundation_rails_helper"
require "jbuilder"
require "active_link_to"
require "rectify"

module Decidim
  module Core
    # Decidim's core Rails Engine.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim
      engine_name "decidim"

      initializer "decidim.action_controller" do |_app|
        ActiveSupport.on_load :action_controller do
          helper Decidim::LayoutHelper
        end
      end

      initializer "decidim.middleware" do |app|
        app.config.middleware.use Decidim::CurrentOrganization
      end
    end
  end
end
