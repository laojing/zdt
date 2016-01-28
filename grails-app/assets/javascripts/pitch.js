
/*
function UpdatePitchIndex () {
	var turb = $('#turbinenum').val();
	for ( var i=0; i<33; i++ ) {
		var ii = i;
		var cap = "金风";
		if ( turb == 2 ) {
			ii = 33 + i;
			cap = "东气";
		}
		$('#title'+(i+1)).html( cap + (ii+1) + '号机组' );
		$('#kk1'+(i+1)).html( '转矩系数：'+pitchgains[ii].optgain );
		$('#kk2'+(i+1)).html( '有功功率：'+pitchtens[ii+1].power );
		$('#kk3'+(i+1)).html( '电机转速：'+pitchtens[ii+1].speed );
	}
}

function UpdatePitchRank( over ) {
	$.getJSON(furl, {turbinenum:turbnum}, function(data) {
		pitchtens = data.tens;
		pitchgains = data.gains;
		UpdatePitchIndex();
	});
}
*/
