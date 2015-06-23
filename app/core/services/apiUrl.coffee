angular.module("buckit.core").factory "apiUrl", [
  ->
    (url) ->
      "/api/#{url}"
]
