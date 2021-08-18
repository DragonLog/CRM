<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + 	request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<base href="<%=basePath%>">
<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
<link rel="stylesheet" type="text/css" href="jquery/bs_pagination/jquery.bs_pagination.min.css">
<script type="text/javascript" src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
<script type="text/javascript" src="jquery/bs_pagination/en.js"></script>

<script type="text/javascript">

	$(function(){
		
		//定制字段
		$("#definedColumns > li").click(function(e) {
			//防止下拉菜单消失
	        e.stopPropagation();
	    });

		pageList(1, 10)
	});

	function pageList(pageNo, pageSize) {
		$.ajax({
			url : "workbench/customer/getPageList.do",
			data : {
				"pageNo" : pageNo,
				"pageSize" : pageSize
			},
			type : "get",
			dataType : "json",
			success : function (data) {
				var html = "";
				$.each(data.dataList, function (i, n) {
					html += '<tr>';
					html += '<td><input type="checkbox" /></td>';
					html += '<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'workbench/customer/detail.do?id=' + n.id + '\';">' + n.name + '</a></td>';
					html += '<td>' + n.owner + '</td>';
					html += '<td>' + n.phone + '</td>';
					html += '<td>' + n.website + '</td>';
					html += '</tr>';
				})
				$("#customerBody").html(html);
				var totalPages = data.total % pageSize == 0 ? data.total / pageSize : parseInt(data.total / pageSize) + 1;
				$("#customerPage").bs_pagination({
					currentPage: pageNo, // 页码
					rowsPerPage: pageSize, // 每页显示的记录条数
					maxRowsPerPage: 20, // 每页最多显示的记录条数
					totalPages: totalPages, // 总页数
					totalRows: data.total, // 总记录条数

					visiblePageLinks: 3, // 显示几个卡片

					showGoToPage: true,
					showRowsPerPage: true,
					showRowsInfo: true,
					showRowsDefaultInfo: true,

					onChangePage : function(event, data){
						pageList(data.currentPage , data.rowsPerPage);
					}
				});

			}
		})
	}
</script>
</head>
<body>
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>客户列表</h3>
			</div>
		</div>
	</div>
	
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
	
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">

			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" /></td>
							<td>名称</td>
							<td>所有者</td>
							<td>公司座机</td>
							<td>公司网站</td>
						</tr>
					</thead>
					<tbody id="customerBody">
					</tbody>
				</table>
			</div>

			<div style="height: 50px; position: relative;top: 30px;">
				<div id="customerPage"></div>
			</div>
			
		</div>
		
	</div>
</body>
</html>