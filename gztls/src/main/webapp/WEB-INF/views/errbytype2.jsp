<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script src="resources/js/Chart.min.js"></script>
<link rel="stylesheet" type="text/css" href="resources/css/Chart.min.css">

<head>
<meta charset="UTF-8">
</head>
<body>
<script>
var obj = new Object();	
var lbl; var cnt;
var lblarr; var cntarr;
let tempData;
let chartOptions;

$(document).ready(function() {	
	updateDev();
	dateSelect();
	getChart();	
	getChart2();
});
function dateSelect(){
	var server_time = $("#server_time").val();
	var to_date = $("#to_date").val();
	if (server_time){ obj.server_time = server_time;}
	if (to_date){ obj.to_date = to_date;}
	console.log("obj",obj);
}
function newDateSelect(){
	dateSelect();
	getChart();
}

function getChart(){
	console.log("obj",obj);
	$.ajax({
		url : "errcntjsn", //날짜조건에 맞는 
		type : "GET",
		data : obj,
		error : function() {
			alert(error);
		}
	}).done(function(results){
		console.log("results",results);
		lbl = ""; cnt = "";
		for(key in results){
			lbl += results[key].err_type;
			lbl += ",";
			cnt += results[key].count;
			cnt += ",";
		}
		lbl = lbl.substr(0, lbl.length - 1);
		lblarr = lbl.split(",");
		cnt = cnt.substr(0, cnt.length - 1);
		cntarr = cnt.split(",");
		console.log("lblarr",lblarr);
		console.log("cntarr",cntarr);


		chartOptions = {
			    title:{
			        display:true,
			        text:'기간 내 에러 건수(에러 타입 별)',
			        fontSize:25
			    },
			    legend:{
			        position:'right',
			        labels:{
			            fontColor:'grey'
			        }
			    },
			    layout:{
			        padding:{left:30}
			    },
			    tooltips:{
			    	mode: 'index',
					intersect: false
			    },
			    cutoutPercentage: 40,
			    rotation: 1 * Math.PI,
	            circumference: 1 * Math.PI
			}
		
		if(window.testChart && window.testChart !== null){
	        window.testChart.destroy();
	    } 
			
		let myChart = document.getElementById('myChart').getContext('2d');

		//Global Options
		Chart.defaults.global.defaultFontSize=15;
		Chart.defaults.global.defaultFontColor='Gray';

		window.testChart = new Chart(myChart, {
		    type: 'doughnut',
		    data: {
		        labels: lblarr,
		        datasets:[{
		            data: cntarr,
		            borderColor: ["rgba(0, 123, 255, 0.6)",
		            	"rgba(220, 53, 69, 0.6)",
		            	"rgba(255, 193, 7, 0.6)"],
		            backgroundColor: ["rgba(0, 123, 255, 0.6)",
		            	"rgba(220, 53, 69, 0.6)",
		            	"rgba(255, 193, 7, 0.6)"],
		            hoverBorderWidth:4,
		            fill: false
		        }]
		    },
		    options: chartOptions
		});	
		testChart.data.datasets[0].data = cntarr;	
		testChart.labels = lblarr;
		testChart.update();
	});
};
function updateDev(){
	$.ajax({
		url : "dlistjsn",
		type : "GET",
		error : function() {
			console.log(error);
		}			
	}).done(function(results){
		$('#deviceinfo').find('option').remove();
		$('#deviceinfo').append("<option value=''>선택 기기</option>");
		for(key in results) {
			$('#deviceinfo').append("<option value="+results[key].device_id+">"+results[key].device_name+"</option>")
		}	
	});
};
///////////////////////////
var set = new Object();	

function yearSelect2(){
	var device_id = $("#deviceinfo").val();
	var server_time = $("#server_time2").val();
	var to_date = $("#to_date2").val();
	set.device_id = device_id;
	if (server_time){ set.server_time = server_time;}
	if (to_date){ set.to_date = to_date;}
	console.log("set",set);
}
function newYearSelect2(){
	yearSelect2();
	getChart2();
}


function getChart2(){
	$.ajax({
		url : "errcntbyidjsn",
		type : "GET",
		data : set,
		error : function() {
			alert(error);
		}
	}).done(function(results){
		console.log(results);

		lbl2 = ""; cnt2 = ""; dname = "";
		
		if(results.length == 0){
			lbl2 = "TLS(SSL) 오류,X509(인증서) 오류,데이터 오류,";
			cnt2 = "0,0,0,";
			dname = "기간 내 ";
			dname += $('#deviceinfo option:checked').text();
			dname += "의 에러 건수(에러 타입 별)";
		}		
		else{
			dname = "기간 내 ";
			dname += results[0].device_name;
			dname += "의 에러 건수";
			for(key in results[0].errorList){
				lbl2 += results[0].errorList[key].err_type;
				lbl2 += ",";
				cnt2 += results[0].errorList[key].count;
				cnt2 += ",";
			}		
		}
		
		lbl2 = lbl2.substr(0, lbl2.length - 1);
		lblarr2 = lbl2.split(",");

		//아예 오류가 없었던 기기인지 체크
		if(cnt2.length != 0){
			cnt2 = cnt2.substr(0, cnt2.length - 1);
			cntarr2 = cnt2.split(",");
			}
		else {
			cntarr2 = "";
			}	
		
		console.log("lblarr2",lblarr2);
		console.log("cntarr2",cntarr2);
		console.log("dname",dname);		

		deviceData = {
		        labels: lblarr2,
		        datasets:[{
		            data: cntarr2,
		            borderColor: ["rgba(0, 123, 255, 0.6)",
		            	"rgba(220, 53, 69, 0.6)",
		            	"rgba(255, 193, 7, 0.6)"],
		            backgroundColor: ["rgba(0, 123, 255, 0.6)",
		            	"rgba(220, 53, 69, 0.6)",
		            	"rgba(255, 193, 7, 0.6)"],
		            hoverBorderWidth:4,
		            fill: false
		        }]
		    }
		deviceChartOptions = {
		    title:{
		        display:true,
		        text: dname,
		        fontSize:25
		    },
		    legend:{
		        position:'right',
		        labels:{
		            fontColor:'grey'
		        }
		    },
		    tooltips:{
		    	mode: 'index',
				intersect: false
		    },
		    cutoutPercentage: 40
		}
		if(window.deviceChart && window.deviceChart !== null){
	        window.deviceChart.destroy();
	    } 

		let tempChart = document.getElementById('tempChart').getContext('2d');
		window.deviceChart = new Chart(tempChart, {		
			type: 'polarArea',
			data: deviceData,
			options: deviceChartOptions
		});
	});
   
	deviceData.datasets[0].data = cntarr2;
    deviceData.labels = lblarr2;
    deviceChart.update();
};

</script>
<div class="container-fluid" style="padding-top:100px;">
	<div class="row">
		<div class="col" style="width:50%;">
			<canvas id="myChart" style="max-width:900px; min-width:300px;"></canvas>
		</div>
		<div class="col" style="width:50%;">
			<canvas id="tempChart" style="max-width:900px; min-width:300px;"></canvas>
		</div>
	</div>
	<div class="row">
		<div class="col" style="width:50%;">
			<input type="date" id="server_time">
			<input type="date" id="to_date">
			<button type="submit" id="submit" class="btn btn-dark" onclick='newDateSelect()'>조회</button>
			<p class="font-weight-light font-italic">조건 조회 시 기간 내 누적 에러 건수를 확인하실 수 있습니다.<br>날짜를 선택하지 않을 시 전체 기간으로 조회됩니다.</p>
			
		</div>
		<div class="col" style="width:50%;">
			<select id="deviceinfo" name="deviceinfo"></select>
			<input type="date" id="server_time2">
			<input type="date" id="to_date2">
			<button type="submit" id="submit" class="btn btn-dark" onclick='newYearSelect2()'>조회</button>		
			<p class="font-weight-light font-italic">조건 조회 시 기간 내 해당 기기의 누적 에러 건수를 확인하실 수 있습니다.<br>날짜를 선택하지 않을 시 전체 기간으로 조회됩니다.</p>
		</div>
	</div>
</div>
</body>
</html>