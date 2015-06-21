angular.module("buckit.services").factory "componentUrl", [
  ->
    (url) ->
      "/app/components/#{url}"
]
