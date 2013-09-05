budget.directive 'firstchart', () ->

    restrict: 'E'
    replace: true,
    template: '<div id="container"></div>'
    scope:
        transactions: '='

    link: (scope, elem, attrs) ->

        cbk = (transactions) ->

            # seriesData = ([new Date(x.date), x.total_amount] for x in transactions)
            seriesData = [
                [Date.parse('2013-08-29'), 2]
                [Date.parse('2013-09-01'), 4]
                [Date.parse('2013-09-01'), 9]
            ]

            console.log seriesData

            $('#container').highcharts 'StockChart'
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
                series: [
                    {
                        data: seriesData
                    }
                ]

        scope.$watch 'transactions', cbk, true
