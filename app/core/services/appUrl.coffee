angular.module("buckit.core").factory "appUrl", [
  ->
    (url) ->
      "/app/#{url}"
]
