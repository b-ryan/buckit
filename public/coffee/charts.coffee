buckit.directive 'firstchart', () ->

  restrict: 'E'
  replace: true,
  template: '<div id="container"></div>'
  scope:
    transactions: '='

  link: (scope, elem, attrs) ->

    cbk = (transactions) ->

      seriesData = ([Date.parse(x.date), x.total_amount] for x in transactions)

      $('#container').highcharts 'StockChart',
        chart:
          type: 'column'
          zoomType: 'x'
        title:
          text: 'Transactions Summary'
        xAxis:
          minTickInterval: 24 * 60 * 60 * 1000
          minPadding: 0.05
          maxPadding: 0.05
          title:
            text: null
        yAxis:
          title:
            text: 'Amount'
        plotOptions:
          series:
            dataGrouping:
              approximation: 'sum'
              forced: true
        scrollbar:
          enabled: false
        series: [
          {
            data: seriesData
          }
        ]

    scope.$watch 'transactions', cbk, true
