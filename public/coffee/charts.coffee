budget.directive 'firstchart', () ->

    restrict: 'E'
    replace: true,
    template: '<div id="container"></div>'
    scope:
        transactions: '='

    link: (scope, elem, attrs) ->

        cbk = (newVals) ->

            $('#container').highcharts
                chart:
                    type: 'line',
                title:
                    text: 'Transactions Summary'
                xAxis:
                    type: 'datetime'
                    title:
                        text: null
                yAxis:
                    title:
                        text: 'Amount'
                series: [
                    {
                        data: [
                            [Date.UTC(2013, 7, 29), 2]
                            [Date.UTC(2013, 8, 1), 4]
                        ]
                    }
                ]

        scope.$watch 'transactions', cbk, true
