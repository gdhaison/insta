Rails.application.config.middleware.use OmniAuth::Builder do
    provider :instagram_graph, '3182136938520718', '03a9f5848a249014788322586a8957b9'
end