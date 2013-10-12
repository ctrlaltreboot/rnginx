default[:nginx][:ignore_invalid_headers] = "on"
default[:nginx][:keepalive_requests] = "100"
default[:nginx][:recursive_error_pages] = "on"
default[:nginx][:sendfile] = "on"
default[:nginx][:server_name_in_redirect] = "off"
default[:nginx][:server_tokens] = "off"

# Timeouts 
default[:nginx][:keepalive_timeout] = "75"
default[:nginx][:client_body_timeout] = "60"
default[:nginx][:client_header_timeout] = "60"
default[:nginx][:send_timeout] = "60"

# Compression
default[:nginx][:gzip] = "on"
default[:nginx][:gzip_proxied] = "any"
default[:nginx][:gzip_buffers] = "16 8k"
default[:nginx][:gzip_comp_level] = "1"
default[:nginx][:gzip_min_length] = "100"
default[:nginx][:gzip_vary] = "on"
default[:nginx][:gzip_disable] = "MSIE [1-6]\.(?!.*SV1)"
default[:nginx][:gzip_types] = [ 
  "text/plain", "text/css", "application/javascript",
  "application/x-javascript", "text/xml",
  "application/xml", "application/xml+rss",
  "text/javascript", "application/json"
]

# TCP Options
default[:nginx][:tcp_nodelay] = "on"
default[:nginx][:tcp_nopush] = "on"

# Client request size limits
default[:nginx][:client_body_buffer_size] = "64K"
default[:nginx][:client_header_buffer_size] = "1K"
default[:nginx][:client_max_body_size] = "2M"
default[:nginx][:large_client_header_buffers] = "4 16K"
