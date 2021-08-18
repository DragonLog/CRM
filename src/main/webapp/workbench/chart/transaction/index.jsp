<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + 	request.getServerPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>Title</title>
    <script src="ECharts/echarts.min.js" ></script>
    <script src="jquery/jquery-1.11.1-min.js"></script>

    <script>

        $(function () {
            getCharts();
        })

        function getCharts() {  //制表
            $.ajax({
                url : "workbench/transaction/getCharts.do",
                type : "get",
                dataType : "json",
                success : function (data) {
                    var myChart = echarts.init(document.getElementById('main'));
                    var option = {
                        title: {
                            text: '交易漏斗图',
                        },
                        series: [
                            {
                                name:'交易漏斗图',
                                type:'funnel',
                                left: '10%',
                                top: 60,
                                //x2: 80,
                                bottom: 60,
                                width: '80%',
                                // height: {totalHeight} - y - y2,
                                min: 0,
                                max: data.total,
                                minSize: '0%',
                                maxSize: '100%',
                                sort: 'descending',
                                gap: 2,
                                label: {
                                    show: true,
                                    position: 'inside'
                                },
                                labelLine: {
                                    length: 10,
                                    lineStyle: {
                                        width: 1,
                                        type: 'solid'
                                    }
                                },
                                itemStyle: {
                                    borderColor: '#fff',
                                    borderWidth: 1
                                },
                                emphasis: {
                                    label: {
                                        fontSize: 20
                                    }
                                },
                                data: data.dataList
                            }
                        ]
                    };
                    myChart.setOption(option);
                }
            })
        }
    </script>
</head>
<body>
    <div id="main" style="width: 600px;height:400px;"></div>
</body>
</html>
