var turbpos = new Array();
turbpos.push({x:4697.56823,y:1556.44081,v:1});
turbpos.push({x:4334.45956,y:1202.03903,v:2});
turbpos.push({x:3633.74982,y:1020.23381,v:4});
turbpos.push({x:3049.87909,y:1096.98210,v:6});
turbpos.push({x:2795.12566,y:1211.28311,v:7});
turbpos.push({x:2709.60278,y:1571.55562,v:8});
turbpos.push({x:2347.75886,y:1212.90788,v:9});
turbpos.push({x:2350.09999,y:1535.13616,v:10});
turbpos.push({x:1784.57554,y:1565.44261,v:11});
turbpos.push({x:1684.02255,y:1903.44872,v:12});
turbpos.push({x:1371.63595,y:2176.27749,v:13});
turbpos.push({x:1559.60704,y:2633.78813,v:14});
turbpos.push({x:1463.47719,y:3086.75923,v:15});
turbpos.push({x:2131.15249,y:3446.19372,v:16});
turbpos.push({x:2383.63352,y:3205.15463,v:17});
turbpos.push({x:2478.33432,y:2717.67957,v:18});
turbpos.push({x:2666.01091,y:2231.86329,v:19});
turbpos.push({x:3153.56377,y:3121.80242,v:20});
turbpos.push({x:3512.75528,y:2831.06405,v:21});
turbpos.push({x:3432.16162,y:2408.57015,v:22});
turbpos.push({x:5036.21911,y:3416.44640,v:23});
turbpos.push({x:4895.06739,y:3717.08639,v:24});
turbpos.push({x:4668.69751,y:4290.70202,v:25});
turbpos.push({x:4411.25325,y:4598.35110,v:26});
turbpos.push({x:4328.37808,y:4915.70043,v:27});
turbpos.push({x:3486.27269,y:3931.48110,v:31});
turbpos.push({x:2967.34803,y:3718.91249,v:32});
turbpos.push({x:2630.35282,y:3748.75070,v:33});
turbpos.push({x:3307.50270,y:3382.19640,v:30});
turbpos.push({x:3089.95605,y:2894.26039,v:5});
turbpos.push({x:3248.55293,y:2727.77544,v:28});
turbpos.push({x:3215.00640,y:2523.21092,v:29});
turbpos.push({x:4147.80624,y:947.97962,v:3});

turbpos.push({x:8453.45809,y:1176.33203,v:34});
turbpos.push({x:8390.86380,y:1480.68896,v:35});
turbpos.push({x:8496.35448,y:1852.28784,v:36});
turbpos.push({x:8586.79859,y:2252.16965,v:37});
turbpos.push({x:8446.24607,y:2604.84500,v:38});
turbpos.push({x:8361.49696,y:2904.59253,v:39});
turbpos.push({x:7610.36589,y:793.33038,v:40});
turbpos.push({x:7440.58201,y:1097.11285,v:41});
turbpos.push({x:6616.28647,y:2499.46628,v:42});
turbpos.push({x:6709.65700,y:2817.87353,v:43});
turbpos.push({x:6303.12666,y:2777.65077,v:44});
turbpos.push({x:5979.53852,y:2896.87928,v:45});
turbpos.push({x:5444.83204,y:3073.86609,v:46});
turbpos.push({x:5711.38708,y:3019.61031,v:47});
turbpos.push({x:8203.47724,y:1800.74685,v:48});
turbpos.push({x:5401.24309,y:2322.06481,v:49});
turbpos.push({x:5531.23690,y:1828.55610,v:50});
turbpos.push({x:4740.77089,y:1331.59498,v:53});
turbpos.push({x:3313.69347,y:1108.68124,v:52});
turbpos.push({x:4967.04729,y:1882.97008,v:51});
turbpos.push({x:4519.23325,y:1993.64402,v:54});
turbpos.push({x:3473.22326,y:3122.16605,v:55});
turbpos.push({x:3970.60990,y:4794.68665,v:56});
turbpos.push({x:3805.41160,y:4259.37130,v:57});
turbpos.push({x:3531.19315,y:3448.48032,v:58});
turbpos.push({x:2978.30827,y:2618.42044,v:61});
turbpos.push({x:3058.39305,y:2291.23084,v:62});
turbpos.push({x:1745.76245,y:2299.08103,v:63});
turbpos.push({x:2099.10220,y:1644.77777,v:64});
turbpos.push({x:1902.33099,y:1232.41534,v:65});
turbpos.push({x:1383.27640,y:1731.40052,v:66});

var minx = 5000;
var maxx = 0;
var miny = 5000;
var maxy = 0;
var turbsize = 50;
var turbimg = new Image();
var turbimgred = new Image();

function InitPos() {
	for ( var i=0; i<turbpos.length; i++ ) {
		if ( minx > turbpos[i].x ) minx = turbpos[i].x;
		if ( maxx < turbpos[i].x ) maxx = turbpos[i].x;
		if ( miny > turbpos[i].y ) miny = turbpos[i].y;
		if ( maxy < turbpos[i].y ) maxy = turbpos[i].y;
	}
	minx -= 3*turbsize;
	miny -= 2*turbsize;
	maxx += 4*turbsize;
	maxy += 4*turbsize;
	turbimg.src = turbpic;
	turbimgred.src = turbpicred;
}
