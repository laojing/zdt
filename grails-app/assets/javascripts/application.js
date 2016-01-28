var UPDATESPAN = 5000;
//[['偏航预判','wind','index'],[['偏航总览','wind','yaw'],['偏航损耗','wind','lost'],['参数调整','wind','change']]],
var OptNames = [ [['功率评估','power','index'],[['功率排名','power','effi'],['功率查询','power','check'],['标准功率','power','stand']]],
				[['转矩优化','pitch','index'],[['实时曲线','pitch','real'],['曲线拟合','pitch','fitting'],['拟合比较','pitch','compare'],['标准转矩','pitch','stand']]],
				[['偏航预判','wind','index'],[['偏航总览','wind','yaw'],['偏航损耗','wind','lost']]],
				[['扇区管理','sector','index'],[]],
				[['动态无功','follow','index'],[['无功分配','follow','dist'],['无功数据','follow','data']]] ];

var OptimizeType = [ 'economy', '风电场经济运行系统',
					 'powercurvel', '功率特性评估及故障诊断',
					 'faultanalysis', '变桨距故障分析',
					 'windsensor', '风速风向传感器故障预警',
					 'sectormanage', '扇区管理',
					 'powerfollow', '动态功率调控跟踪' ];

var lineColorsPowers = ['#000040', '#004000'];
var lineColorsFollows = ['#000040', '#004000'];
var lineColorsCompare = ['#000040', '#004000', '#2000a0',
				'#800020', '#202040', '#8020a0'];



function DateString(d) {
	return sprintf("%d/%02d/%02d %02d:%02d",d.getFullYear(),(d.getMonth()+1),d.getDate(),d.getHours(),d.getMinutes());
}

function GetTurbName ( turbnum ) {
	if ( turbnum <=33 ) {
		return '金风第'+turbnum+'号机组';
	} else {
		return '东汽第'+(turbnum-33)+'号机组';
	}
}

Date.prototype.Format = function(fmt)   
{ //author: meizz   
  var o = {   
    "M+" : this.getMonth()+1,                 //月份   
    "d+" : this.getDate(),                    //日   
    "h+" : this.getHours(),                   //小时   
    "m+" : this.getMinutes(),                 //分   
    "s+" : this.getSeconds(),                 //秒   
    "q+" : Math.floor((this.getMonth()+3)/3), //季度   
    "S"  : this.getMilliseconds()             //毫秒   
  };   
  if(/(y+)/.test(fmt))   
    fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));   
  for(var k in o)   
    if(new RegExp("("+ k +")").test(fmt))   
  fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
  return fmt;   
}

