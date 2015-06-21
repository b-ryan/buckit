angular.module("buckit.services").factory "apiUrl", [
  ->
    (url) ->
      "/api/#{url}"
]
