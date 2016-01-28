// Main Power
function UpdatePowerMain( url ) {
	$.getJSON(url, function(data) {
		if ( data.effi.length == 0 ) {
			alert ( '数据库更新错误！所有数值只是页面展示作用！' );
		}
		var len = data.effi.length;
		if( len > 0 ) {
			for( var i=0; i<len; i++ ) {
				if( data.effi[i].turbnum<=66 ) {
					$('#fvar'+data.effi[i].turbnum).html ( parseInt(data.effi[i].var) + 'kVar' );
					$('#fvarset'+data.effi[i].turbnum).html ( parseInt(data.effi[i].value) + 'kVar' );
					$('#fpower'+data.effi[i].turbnum).html ( parseInt(data.effi[i].power) + 'kW' );
				}
				if( data.effi[i].turbnum == 102 ) {
					$('#capvar').html ( parseInt(data.effi[i].value) + 'kVar' );
				}
			}
		}
	});
}
