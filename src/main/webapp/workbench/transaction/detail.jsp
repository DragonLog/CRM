<%@ page import="com.zcx.crm.settings.domain.DicValue" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.zcx.crm.workbench.domain.Tran" %>
<%@ page import="java.util.Set" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + 	request.getServerPort() + request.getContextPath() + "/";
//java脚本获取可能性为0阶段的位置以及其他参数
List<DicValue> dvList = (List<DicValue>) application.getAttribute("stageList");
Map<String, String> pMap = (Map<String, String>) application.getAttribute("pMap");
Set<String> set = pMap.keySet();
int point = 0;
for (int i = 0; i < dvList.size(); i ++) {
	DicValue dicValue = dvList.get(i);
	String stage = dicValue.getValue();
	String possibility = pMap.get(stage);
	if ("0".equals(possibility)) {
		point = i;
		break;
	}
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<base href="<%=basePath%>">
<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />

<style type="text/css">
.mystage{
	font-size: 20px;
	vertical-align: middle;
	cursor: pointer;
}
.closingDate{
	font-size : 15px;
	cursor: pointer;
	vertical-align: middle;
}
</style>
	
<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>

<script type="text/javascript">

	//默认情况下取消和保存按钮是隐藏的
	var cancelAndSaveBtnDefault = true;
	
	$(function(){
		$("#remark").focus(function(){
			if(cancelAndSaveBtnDefault){
				//设置remarkDiv的高度为130px
				$("#remarkDiv").css("height","130px");
				//显示
				$("#cancelAndSaveBtn").show("2000");
				cancelAndSaveBtnDefault = false;
			}
		});
		
		$("#cancelBtn").click(function(){
			//显示
			$("#cancelAndSaveBtn").hide();
			//设置remarkDiv的高度为130px
			$("#remarkDiv").css("height","90px");
			cancelAndSaveBtnDefault = true;
		});
		
		$(".remarkDiv").mouseover(function(){
			$(this).children("div").children("div").show();
		});
		
		$(".remarkDiv").mouseout(function(){
			$(this).children("div").children("div").hide();
		});
		
		$(".myHref").mouseover(function(){
			$(this).children("span").css("color","red");
		});
		
		$(".myHref").mouseout(function(){
			$(this).children("span").css("color","#E6E6E6");
		});
		
		
		//阶段提示框
		$(".mystage").popover({
            trigger:'manual',
            placement : 'bottom',
            html: 'true',
            animation: false
        }).on("mouseenter", function () {
                    var _this = this;
                    $(this).popover("show");
                    $(this).siblings(".popover").on("mouseleave", function () {
                        $(_this).popover('hide');
                    });
                }).on("mouseleave", function () {
                    var _this = this;
                    setTimeout(function () {
                        if (!$(".popover:hover").length) {
                            $(_this).popover("hide")
                        }
                    }, 100);
                });

		showHistoryList();	//展现交易历史
	});
	
	function showHistoryList() {
		$.ajax({
			url : "workbench/transaction/getHistoryListByTranId.do",
			data : {
				"tranId" : "${t.id}"
			},
			type : "get",
			dataType : "json",
			success : function (data) {
				var html = "";
				$.each(data, function (i, n) {
					html += '<tr>';
					html += '<td>' + n.stage + '</td>';
					html += '<td>' + n.money + '</td>';
					html += '<td>' + n.possibility + '</td>';
					html += '<td>' + n.expectedDate + '</td>';
					html += '<td>' + n.createTime + '</td>';
					html += '<td>' + n.createBy + '</td>';
					html += '</tr>';
				})
				$("#tranHistoryBody").html(html);
			}
		})
	}

	function changeStage(stage, i) {	//改变交易阶段
		$.ajax({
			url : "workbench/transaction/changeStage.do",
			data : {
				"id" : "${t.id}",
				"stage" : stage,
				"money" : "${t.money}",
				"expectedDate" : "${t.expectedDate}"
			},
			type : "post",
			dataType : "json",
			success : function (data) {
				if (data.success) {
					$("#stage").html(data.t.stage);
					$("#possibility").html(data.t.possibility);
					$("#editBy").html(data.t.editBy);
					$("#editTime").html(data.t.editTime);
					changeIcon(stage, i);
					showHistoryList();
				} else {
					alert("改变阶段失败！");
				}
			}
		})
	}

	function changeIcon(stage, index) {	//图标也要跟着一起改变
		var currentStage = stage;
		var currentPossibility = $("#possibility").html();
		var point = "<%=point%>";
		if (currentPossibility == "0") {
			for (var i = 0; i < point; i ++) {
//黑圈
				$("#" + i).removeClass();
				$("#" + i).addClass("glyphicon glyphicon-record mystage");
				$("#" + i).css("color", "#000000");
			}
			for (var i = point; i < <%=dvList.size()%>; i ++) {
				if (i == index) {
//红叉
					$("#" + i).removeClass();
					$("#" + i).addClass("glyphicon glyphicon-remove mystage");
					$("#" + i).css("color", "#FF0000");
				} else {
//黑叉
					$("#" + i).removeClass();
					$("#" + i).addClass("glyphicon glyphicon-remove mystage");
					$("#" + i).css("color", "#000000");
				}
			}
		} else {
			for(var i = 0; i < point; i ++) {
				if (i == index) {
//绿尖
					$("#" + i).removeClass();
					$("#" + i).addClass("glyphicon glyphicon-map-marker mystage");
					$("#" + i).css("color", "#90F790");
				} else if (i < index) {
//绿圈
					$("#" + i).removeClass();
					$("#" + i).addClass("glyphicon glyphicon-ok-circle mystage");
					$("#" + i).css("color", "#90F790");
				} else {
//黑圈
					$("#" + i).removeClass();
					$("#" + i).addClass("glyphicon glyphicon-record mystage");
					$("#" + i).css("color", "#000000");
				}
			}
			for (var i = point; i < <%=dvList.size()%>; i ++) {
//黑叉
				$("#" + i).removeClass();
				$("#" + i).addClass("glyphicon glyphicon-remove mystage");
				$("#" + i).css("color", "#000000");
			}
		}
	}
	
</script>

</head>
<body>
	
	<!-- 返回按钮 -->
	<div style="position: relative; top: 35px; left: 10px;">
		<a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left" style="font-size: 20px; color: #DDDDDD"></span></a>
	</div>

	<!-- 大标题 -->
	<div style="position: relative; left: 40px; top: -30px;">
		<div class="page-header">
			<h3>${t.customerId}-${t.name} <small>￥${t.money}</small></h3>
		</div>
	</div>

	<br><br>

	<!-- 阶段状态 -->
	<div style="position: relative; left: 40px; top: -50px;">
		阶段&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<%
			Tran tran = (Tran) request.getAttribute("t");
			String currentStage = tran.getStage();
			String currentPossibility = pMap.get(currentStage);
			if ("0".equals(currentPossibility)) {
				for (int i = 0; i < dvList.size(); i ++) {
					DicValue dicValue = dvList.get(i);
					String listStage = dicValue.getValue();
					String listPossibility = pMap.get(listStage);
					if ("0".equals(listPossibility)) {
						if (listStage.equals(currentStage)) {
				%>
<%--								红叉--%>
							<span id="<%=i%>" onclick="changeStage('<%=listStage%>', '<%=i%>')" class="glyphicon glyphicon-remove mystage" data-toggle="popover" data-placement="bottom" data-content="<%=dicValue.getText()%>" style="color: #FF0000;"></span>
							-------------
				<%
						} else {
				%>
<%--							黑叉--%>
							<span id="<%=i%>" onclick="changeStage('<%=listStage%>', '<%=i%>')" class="glyphicon glyphicon-remove mystage"data-toggle="popover" data-placement="bottom" data-content="<%=dicValue.getText()%>" style="color: #000000;"></span>
							-------------
				<%
						}
					} else {
				%>
<%--							黑圈--%>
							<span id="<%=i%>" onclick="changeStage('<%=listStage%>', '<%=i%>')" class="glyphicon glyphicon-record mystage" data-toggle="popover" data-placement="bottom" data-content="<%=dicValue.getText()%>" style="color: #000000;"></span>
							-------------
				<%
					}
				}
			} else {
				int index = 0;
				for (int i = 0; i < dvList.size(); i ++) {
					DicValue dicValue = dvList.get(i);
					String stage = dicValue.getValue();
					if (stage.equals(currentStage)) {
						index = i;
						break;
					}
				}
				for (int i = 0; i < dvList.size(); i ++) {
					DicValue dicValue = dvList.get(i);
					String listStage = dicValue.getValue();
					String listPossibility = pMap.get(listStage);
					if ("0".equals(listPossibility)) {
				%>
<%--							黑叉--%>
						<span id="<%=i%>" onclick="changeStage('<%=listStage%>', '<%=i%>')" class="glyphicon glyphicon-remove mystage"data-toggle="popover" data-placement="bottom" data-content="<%=dicValue.getText()%>" style="color: #000000;"></span>
						-------------
				<%
					} else {
						if (i == index) {
				%>
<%--							绿尖--%>
						<span id="<%=i%>" onclick="changeStage('<%=listStage%>', '<%=i%>')" class="glyphicon glyphicon-map-marker mystage" data-toggle="popover" data-placement="bottom" data-content="<%=dicValue.getText()%>" style="color: #90F790;"></span>
						-------------
				<%
						} else if(i < index) {
				%>
<%--							绿圈--%>
						<span id="<%=i%>" onclick="changeStage('<%=listStage%>', '<%=i%>')" class="glyphicon glyphicon-ok-circle mystage" data-toggle="popover" data-placement="bottom" data-content="<%=dicValue.getText()%>" style="color: #90F790;"></span>
						-------------
				<%
						} else {
				%>
<%--							黑圈--%>
							<span id="<%=i%>" onclick="changeStage('<%=listStage%>', '<%=i%>')" class="glyphicon glyphicon-record mystage" data-toggle="popover" data-placement="bottom" data-content="<%=dicValue.getText()%>" style="color: #000000;"></span>
							-------------
				<%
						}
					}
				}
			}
		%>
<%--		<span class="glyphicon glyphicon-ok-circle mystage" data-toggle="popover" data-placement="bottom" data-content="资质审查" style="color: #90F790;"></span>--%>
<%--		-------------%>
<%--		<span class="glyphicon glyphicon-ok-circle mystage" data-toggle="popover" data-placement="bottom" data-content="需求分析" style="color: #90F790;"></span>--%>
<%--		-------------%>
<%--		<span class="glyphicon glyphicon-ok-circle mystage" data-toggle="popover" data-placement="bottom" data-content="价值建议" style="color: #90F790;"></span>--%>
<%--		-------------%>
<%--		<span class="glyphicon glyphicon-ok-circle mystage" data-toggle="popover" data-placement="bottom" data-content="确定决策者" style="color: #90F790;"></span>--%>
<%--		-------------%>
<%--		<span class="glyphicon glyphicon-map-marker mystage" data-toggle="popover" data-placement="bottom" data-content="提案/报价" style="color: #90F790;"></span>--%>
<%--		-------------%>
<%--		<span class="glyphicon glyphicon-record mystage" data-toggle="popover" data-placement="bottom" data-content="谈判/复审"></span>--%>
<%--		-------------%>
<%--		<span class="glyphicon glyphicon-record mystage" data-toggle="popover" data-placement="bottom" data-content="成交"></span>--%>
<%--		-------------%>
<%--		<span class="glyphicon glyphicon-record mystage" data-toggle="popover" data-placement="bottom" data-content="丢失的线索"></span>--%>
<%--		-------------%>
<%--		<span class="glyphicon glyphicon-record mystage" data-toggle="popover" data-placement="bottom" data-content="因竞争丢失关闭"></span>--%>
<%--		-------------%>
		<span class="closingDate">${t.expectedDate}</span>
	</div>
	
	<!-- 详细信息 -->
	<div style="position: relative; top: 0px;">
		<div style="position: relative; left: 40px; height: 30px;">
			<div style="width: 300px; color: gray;">所有者</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${t.owner}&nbsp;</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">金额</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>￥${t.money}&nbsp;</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 10px;">
			<div style="width: 300px; color: gray;">名称</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${t.name}&nbsp;</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">预计成交日期</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${t.expectedDate}&nbsp;</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 20px;">
			<div style="width: 300px; color: gray;">客户名称</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${t.customerId}&nbsp;</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">阶段</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="stage">${t.stage}&nbsp;</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 30px;">
			<div style="width: 300px; color: gray;">类型</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${t.type}&nbsp;</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">可能性</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="possibility">${t.possibility}&nbsp;</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 40px;">
			<div style="width: 300px; color: gray;">来源</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${t.source}&nbsp;</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">市场活动源</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${t.activityId}&nbsp;</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 50px;">
			<div style="width: 300px; color: gray;">联系人名称</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${t.contactsId}&nbsp;</b></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 60px;">
			<div style="width: 300px; color: gray;">创建者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${t.createBy}&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">${t.createTime}</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 70px;">
			<div style="width: 300px; color: gray;">修改者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="editBy">${t.editBy}&nbsp;&nbsp;</b><small id="editTime" style="font-size: 10px; color: gray;">${t.editTime}</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 80px;">
			<div style="width: 300px; color: gray;">描述</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b>
					${t.description}&nbsp;
				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 90px;">
			<div style="width: 300px; color: gray;">联系纪要</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b>
					&nbsp;${t.contactSummary}&nbsp;
				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 100px;">
			<div style="width: 300px; color: gray;">下次联系时间</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>&nbsp;${t.nextContactTime}&nbsp;</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
	</div>
	
	<!-- 阶段历史 -->
	<div>
		<div style="position: relative; top: 100px; left: 40px;">
			<div class="page-header">
				<h4>阶段历史</h4>
			</div>
			<div style="position: relative;top: 0px;">
				<table id="activityTable" class="table table-hover" style="width: 900px;">
					<thead>
						<tr style="color: #B3B3B3;">
							<td>阶段</td>
							<td>金额</td>
							<td>可能性</td>
							<td>预计成交日期</td>
							<td>创建时间</td>
							<td>创建人</td>
						</tr>
					</thead>
					<tbody id="tranHistoryBody">
					</tbody>
				</table>
			</div>
			
		</div>
	</div>
	
	<div style="height: 200px;"></div>
	
</body>
</html>