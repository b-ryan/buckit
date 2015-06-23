angular.module("buckit.core").factory "componentUrl", [
  ->
    (url) ->
      "/app/components/#{url}"
]
