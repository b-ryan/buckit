angular.module("buckit").factory 'componentUrl', [
  ->
    (url) ->
      "/app/components/#{url}"
]
