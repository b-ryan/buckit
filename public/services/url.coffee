angular.module("buckit").factory 'componentUrl', [
  ->
    (url) ->
      "/public/components/#{url}"
]
