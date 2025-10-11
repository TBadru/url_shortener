ActiveAdmin.register Url do
  permit_params :original_url, :slug, :expires_at
end
