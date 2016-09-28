# frozen_string_literal: true
Decidim::Admin::Engine.routes.draw do
  root to: "dashboard#show", constraints: ->(request) { Decidim::Admin::OrganizationDashboardConstraint.new(request).matches? }
end
