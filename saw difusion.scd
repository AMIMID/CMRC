(
Server.default = s = Server.local;
////server setup
(
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(1);
s.options.memSize = 8192*128*2;
s.options.blockSize = 64*4;
s.options.maxNodes = 1024 * 16;
s.options.sampleRate= 44100;
);

s.waitForBoot{
/////wavetables
Buffer.freeAll;

//~t= Buffer.alloc(s,2048);


////////////////////////////////////speaker setup///other
/*(
// 3D///cube
~a = VBAPSpeakerArray.new(3, [[0, 45], [90, 45], [180, 45], [90.neg, 45],[0, 45.neg], [90, 45.neg], [180, 45.neg], [90.neg, 45.neg]]);
//0 up fl, 1 up bl, 2 up br, 3 up fr, 4 down fl, 5 down bl, 6 down br, 7 down fr
~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
///furhter on speaker setup can be geodesic octahedron 2nd order torus with 16 channels, and Rhombic triacontahedron with 32 vertices as 32 speaker channels
	// )*/
	~a = VBAPSpeakerArray.new(3, [[0, 45], [180, 45], [90, 45.neg], [90.neg, 45.neg]]);
	 ~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);


// 16
	// ~a = VBAPSpeakerArray.new(3, [[0, 45], [90, 45], [180, 45], [90.neg, 45],
	// 	[0, 0], [45, 0], [90, 0], [135, 0],[180.neg,0], [135.neg, 0], [90.neg, 0],[45.neg, 0],
	// [0, 45.neg], [90, 45.neg], [180, 45.neg], [90.neg, 45.neg]]);
	// //0 up fl, 1 up bl, 2 up br, 3 up fr, 4 down fl, 5 down bl, 6 down br, 7 down fr
	// ~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
///furhter on speaker setup can be geodesic octahedron 2nd order torus with 16 channels, and Rhombic triacontahedron with 32 vertices as 32 speaker channels
//)

///////////////////////////////////////////////////////arrays



	////no0
	(
{
var  sph1,sph2,sph3,sph4,sph5,m_x=2,m_y=2,m_z=2;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;
var angle=0,ang=0;
var azimuth,elevation,magnitudex,magnitudey,magnitudez;
var durx,dury,durz;
var sphx,sphy,sphz,azx,elx,azy,ely,azz,elz,plx=0,ply=0,plz=0;
var num=1.neg;
var ellipsis=[1,1,1];
var spread=1;
			~az=[];~el=[];~magx=[];~magy=[];~magz=[];~dur=[];

		360.do{
durx=(12).collect{
			azx = (angle+(360*2.pow(plx/12))).wrap(180.neg,180);  // Increment azimuth
				elx = (angle+(180*2.pow(plx/12))).wrap(90.neg,90);
		plx=(plx+1).mod(12);

		sphx=(Spherical(1,(azx.degrad),(elx.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).x.round(0.000000001).abs;

	};

dury=(12).collect{
		azy = (angle+(360*2.pow(ply/12))).wrap(180.neg,180);  // Increment azimuth
			ely = (angle+(180*2.pow(ply/12))).wrap(90.neg,90);
		ply=(ply+1).mod(12);

		sphy=(Spherical(1,(azy.degrad),(ely.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).y.round(0.000000001).abs;

	};
durz=(12).collect{
			azz = (angle+(360*2.pow(plz/12))).wrap(180.neg,180);  // Increment azimuth
				elz = (angle+(180*2.pow(plz/12))).wrap(90.neg,90);
		plz=(plz+1).mod(12);

		sphz=(Spherical(1,(azz.degrad),(elz.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).z.round(0.000000001).abs;

	};

azimuth=(12).collect{

			az1 = (angle+(360*2.pow(pl1/12))).wrap(180.neg,180);  // Increment azimuth
				el1 = (angle+(180*2.pow(pl1/12))).wrap(90.neg,90);
		pl1=(pl1+1).mod(12);

		sph1=(Spherical(1,(az1.degrad),(el1.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).theta.round(0.00001);

	};

elevation=(12).collect{

				az2 = (angle+(360*2.pow(pl2/12))).wrap(180.neg,180);  // Increment azimuth
			el2 = (angle+(180*2.pow(pl2/12))).wrap(90.neg,90);
		pl2=(pl2+1).mod(12);

		sph2=(Spherical(1,(az2.degrad),(el2.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).phi.round(0.00001);

	};

magnitudex=(12).collect{

			az3 = (angle+(360*2.pow(pl3/12))).wrap(180.neg,180);  // Increment azimuth
			el3 = (angle+ (180*2.pow(pl3/12))).wrap(90.neg,90);
		pl3=(pl3+1).mod(12);

	sph3=(Spherical(1,(az3.degrad),(el3.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2]));

	 mag_x=((Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho/(2.sqrt)).pow(spread)*
			(Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread));

////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis

/*mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2)))).rho*
		 Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;*/

};

magnitudey=(12).collect{

			az4 = (angle+(360*2.pow(pl4/12))).wrap(180.neg,180);  // Increment azimuth
			el4 = (angle+(180*2.pow(pl4/12))).wrap(90.neg,90);
		pl4=(pl4+1).mod(12);

	sph4=(Spherical(1,(az4.degrad),(el4.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2]));

mag_y=((Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho/(2.sqrt)).pow(spread)*
		(Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread));
//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
};

magnitudez=(12).collect{

			az5 = (angle+(360*2.pow(pl5/12))).wrap(180.neg,180);  // Increment azimuth
				el5 = (angle+(180*2.pow(pl5/12))).wrap(90.neg,90);
		pl5=(pl5+1).mod(12);

		sph5=(Spherical(1,(az5.degrad),(el5.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2]));

if(
m_z.even,
mag_z=(Complex(cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread),
mag_z=(Complex(sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread)
	);
////z axis   ambi..  sin for odd numbers, cos for even

};angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);~az=~az++azimuth;~el=~el++elevation;~magx=~magx++magnitudex;~magy=~magy++magnitudey;~magz=~magz++magnitudez;

				12.do{ num=num+1; ~dur=~dur++durx.[num]++dury.[num]++durz.[num];};num=1.neg;};
}.value;
(
//~magx = ~magx.collect { |z| z / ~magx.maxItem };
//~magy = ~magy.collect { |z| z / ~magy.maxItem };
//~magz = ~magz.collect { |z| z / ~magz.maxItem };
 );
);


		//////////////////////wavetable
/*		{
var signal,wt,m=0,amp;

~level=90.collect{m=m+1;amp=m.reciprocal};
~phase=90.collect{pi};
signal=Signal.sineFill(1024,~level,~phase);

wt = signal.asWavetable;
~t.loadCollection(wt);
//signal.plot;
		}.value;*/

		//////control buses
	(
	 ~controlBus_m = Bus.control(s, 1);
	// ~controlBus_ax = Bus.control(s, 1);
	// ~controlBus_ay = Bus.control(s, 1);
	// ~controlBus_az = Bus.control(s, 1);
		~controlBus_ang = Bus.control(s, 1);
		~controlBus_ang1 = Bus.control(s, 1);
				~controlBus_spread = Bus.control(s, 1);
		~controlBus_t = Bus.control(s, 1);
	);

	///phases
		({
		var angle=0;
		~phase=(360*12).collect{
		angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
		}
		}.value;
	);

/////synths////
		(
SynthDef.new(\ospace, {
	arg	gain=1/16, lfo_amp=0.05, harm=1, spread=1, ripple=0.01;
	var sph3,sph4,sph5,m=0,pl1=0;
	var phase,osc1,osc2,osc3,sphere,amp1,amp2,amp3,decay=8,pl2=0,envp,octave=8;
	var ton1,ton2,ton3;
	var fundamental;
	var freq,pitch1,pitch2,pitch3,env;
	var pitch,int=1;
	var n1,n2,n3,rq1,rq2,rq3;
	var magx,magy,magz,mag_x,mag_y,mag_z;
	var ratio1,ratio2,ratio3;
	var scale,nn=49.neg,ampx,ampy,ampz;
	var interval,mod_angle,mod_angle0,mod_angle1;
	var ellipsis=[1,1,1],mag,magxx;
	var waveSpeed = 1, waveFreq = 4,amp=1, theta,phi,wave,t;

			// var wrappedOut1 = { |busArray, signalArray|
			// 	[busArray, signalArray].flop.do { |pair|
			// Out.ar(pair[0], pair[1])}};
			// var wrappedOut2 = { |busArray, signalArray|
			// 	[busArray, signalArray].flop.do { |pair|
			// Out.ar(pair[0], pair[1])}};
			// var wrappedOut3 = { |busArray, signalArray|
			// 	[busArray, signalArray].flop.do { |pair|
			// Out.ar(pair[0], pair[1])}};
			// var out1 = NamedControl.kr(\out1, [0, 1, 2, 3]);  // multiple buses!
//	var out2 = NamedControl.kr(\out2, [0, 1, 2, 3, 4, 5]);  // multiple buses!
//	var out3 = NamedControl.kr(\out3, [0, 1, 2, 3, 4, 5]);  // multiple buses!

			t=SinOsc.kr(ripple.lag(0.1)).range(1, 100);
			Out.kr(~controlBus_t.index,t);
			Out.kr(~controlBus_m.index, harm.lag(0.1));
			Out.kr(~controlBus_spread.index, spread.lag(0.1));

			mod_angle=SinOsc.ar(lfo_amp.lag(0.1),0.degrad,mul:1).range(90.neg.degrad,90.degrad);
			mod_angle1=SinOsc.ar(lfo_amp.lag(0.1),90.degrad,mul:1).range(90.neg.degrad,90.degrad);

				Out.kr(~controlBus_ang.index,mod_angle);
			Out.kr(~controlBus_ang1.index,mod_angle1);

				scale=97.collect{nn=nn+1;Scale.major.performDegreeToKey(nn,12)};
				fundamental=(12);freq=(fundamental*octave);

				6.do{
				m=m+1;
				24.do{

					sph3=Spherical(1,~az.[pl1],~el.[pl1]);
					sph4=Spherical(1,~az.[pl1],~el.[pl1]);
		sph5=Spherical(1,~az.[pl1],~el.[pl1]);


	(
					magx=((Complex(cos(((sph3.theta+mod_angle).round(0.00001)*m).wrap(pi.neg,pi)),cos((((sph3.theta+mod_angle).round(0.00001)*m)).wrap(pi.neg,pi))).rho/(2.sqrt)).pow(spread)*
	(Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread);

////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis
/*
		(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
			cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		 	Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/
		 	2).neg,(pi/2)))).rho*
		 Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;*/
				);

magy=((Complex(sin(((sph4.theta+mod_angle1).round(0.00001)*m).wrap(pi.neg,pi)),sin(((sph4.theta+mod_angle1).round(0.00001)*m).wrap(pi.neg,pi))).rho/(2.sqrt)).pow(spread)*
		(Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread);
//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
				);

magz=((Complex(cos(((sph5.phi+mod_angle).round(0.00001)*m).wrap((pi/2).neg,(pi/2))),cos(((sph5.phi+mod_angle1).round(0.00001)*m).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread));


	 theta = ~az[pl1].degrad;
     phi = ~el[pl1].degrad;
   // var wave = sin(waveFreq * theta + waveFreq * phi - waveSpeed * t);
 wave = amp*sin(waveFreq * theta + waveFreq * phi - waveSpeed * t);
magxx=  magx * wave;

				mag_x=magxx.value; mag_y= magy.value; mag_z=magz.value; interval=Cartesian(mag_x,mag_y,mag_z).rho;
				);
					sphere=Spherical(48,~az.[pl1],~el.[pl1]);

/*n1=(sphere.x).round(0.00000001); n2=(sphere.y).round(0.00000001); n3=(sphere.z).round(0.00000005);

ratio1=n1.round(1);ratio2=n2.round(1);ratio3=n3.round(1);

	ton1 = 2.pow(Select.kr(ratio1.linlin(48.neg, 48, 0, 96), scale) / 12);
ton2 = 2.pow(Select.kr(ratio2.linlin(48.neg, 48, 0, 96), scale) / 12);
ton3 = 2.pow(Select.kr(ratio3.linlin(48.neg, 48, 0, 96), scale) / 12);

amp1=(ton1.reciprocal*octave.reciprocal).round(0.00000001);amp2=(ton2.reciprocal*octave.reciprocal).round(0.00000001);amp3=(ton3.reciprocal*octave.reciprocal).round(0.00000001);

	pitch1=(freq*ton1).round(0.0000001);pitch2=(freq*ton2).round(0.0000001);pitch3=(freq*ton3).round(0.0000001);*/


osc1=VBAP.ar(4,SinOsc.ar(freq*int,mul:int.reciprocal*interval),~b.bufnum,sphere.theta.raddeg,sphere.phi.raddeg);

				Out.ar(0,LeakDC.ar(osc1,mul:0.1*gain));
					pl1=pl1+1;};int=int+1;pl1=0;}

}).add;
);

//	TempoClock.default.tempo_(2);




}
)

(
var data,spread=1,ellipsis=[1,1,1];
var az=0,el=0;
var sph,pl=0,magg,r;
var run = true;
var ot=0.degrad,dota,pla=0;
var  sph1,sph2,sph3,sph4,sph5,m=1.5;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;
var angle=0,ang=0;
var azimuth,elevation,magnitudex,magnitudey,magnitudez;
var durx,dury,durz;
var sphx,sphy,sphz,azx,elx,azy,ely,azz,elz,plx=0,ply=0,plz=0;
var num=1.neg,amplitudex,amplitudey,amplitudez,a,mod_angle,mod_angle1,mod_angle0;
var t;
			 data = [];

Window.closeAll;
s.meter;s.freqscope;s.scope;
w=Window.new("gui",Rect.new(750,100,500,420)).front.alwaysOnTop_(true);
~aa = Slider.new(w.view,Rect.new(20,20,400,30));

~bb = Slider.new(w.view,Rect.new(20,60,400,30));

~cc = Slider.new(w.view,Rect.new(20,140,400,30));

~dd = Slider.new(w.view,Rect.new(20,100,400,30));

~ee = Slider.new(w.view,Rect.new(20,180,400,30));

~on = Button(w,Rect(20,350,40,40)).states_([
	["off",Color.black],Color.gray,["on",Color.white,Color.gray]]).action_({
	arg obj;
	if(
		obj.value==1,{~synth=Synth.new(\ospace,[
			\gain,~aa.value,\lfo_amp,~bb.value.linlin(0,1,0.01,20).round(1/32),\harm,~dd.value.linlin(0,1,1,4).round(1),\spread,~cc.value.linlin(0,1,1,100),\ripple,~ee.value.linlin(0,1,0.001,100)]).register;},
		{~synth.free}
)});
(
a = StaticText(w, Rect(430,20,100, 20));
a.string = "gain";
b = StaticText(w, Rect(430,60,100, 20));
b.string = "lfo";
c = StaticText(w, Rect(430,100,100, 20));
c.string = "harm";
d = StaticText(w, Rect(430,140,100, 20));
d.string = "spread";
e = StaticText(w, Rect(430,180,100, 20));
e.string = "ripple";
);
			(
~aa.value_(1).action_({
	arg obj;
					var gain;
	obj.value.postln;
	gain=obj.value;
	if(~synth.isPlaying,{~synth.set(\gain,gain)});
});
);
(
~bb.value_(1).action_({
	arg obj;
			var lfo_amp;
	lfo_amp=obj.value.linlin(0,1,0.001,20).round(1/32);
				lfo_amp.value.postln;
		if(~synth.isPlaying,{~synth.set(\lfo_amp,lfo_amp)});
}););
(
~cc.value_(1).action_({
	arg obj;
			var spread;
	spread=obj.value.linlin(0,1,1,100);
				spread.value.postln;
		if(~synth.isPlaying,{~synth.set(\spread,spread)});
}););
(
~dd.action_({
	arg obj;
			var harm;
	harm=obj.value.linlin(0,1,1,4).round(1);
				harm.value.postln;
if(~synth.isPlaying,{~synth.set(\harm,harm)});
});
);
(
~ee.action_({
	arg obj;
			var ripple;
	ripple=obj.value.linlin(0,1,0.001,100);
				ripple.value.postln;
if(~synth.isPlaying,{~synth.set(\ripple,ripple)});
});
);
/*(

			 ~v = UserView.new(w,Rect(220,150,200,200)).background_(Color.black);
			 a = ScatterView3d(~v, Rect(0,0, 200,200), data, [-1000, 1000].asSpec,[-1000, 1000].asSpec,[-1000, 1000].asSpec);
			 a.drawMethod = \fillRect;
			 a.symbolSize = 1;
			 a.symbolColor = Color.white;
			 a.background = Color.black;

			 r= Routine({loop{

			 	data=[];
m=~controlBus_m.getSynchronous;
t = ~controlBus_t.getSynchronous;
mod_angle=~controlBus_ang.getSynchronous;
mod_angle1=~controlBus_ang1.getSynchronous;
spread=~controlBus_spread.getSynchronous;
			 	//	a.symbolColor = Color.new(amplitude,1,amplitude);

			 	(

			~azz=[];~ell=[];~magxx=[];~magyy=[];~magzz=[];

		360.do{

azimuth=(12).collect{

			az1 = (angle+(360*2.pow(pl1/12))).wrap(180.neg,180);  // Increment azimuth
				el1 = (angle+(180*2.pow(pl1/12))).wrap(90.neg,90);
		pl1=(pl1+1).mod(12);

		sph1=(Spherical(1,(az1.degrad),(el1.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).theta.round(0.00001);

	};

elevation=(12).collect{

				az2 = (angle+(360*2.pow(pl2/12))).wrap(180.neg,180);  // Increment azimuth
			el2 = (angle+(180*2.pow(pl2/12))).wrap(90.neg,90);
		pl2=(pl2+1).mod(12);

		sph2=(Spherical(1,(az2.degrad),(el2.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).phi.round(0.00001);

	};

magnitudex=(12).collect{

			az3 = (angle+(360*2.pow(pl3/12))).wrap(180.neg,180);  // Increment azimuth
			el3 = (angle+ (180*2.pow(pl3/12))).wrap(90.neg,90);
		pl3=(pl3+1).mod(12);

	sph3=(Spherical(1,(az3.degrad),(el3.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2]));

	 mag_x=((Complex(cos(((sph3.theta+mod_angle).round(0.00001)*m).wrap(pi.neg,pi)),cos(((sph3.theta+mod_angle).round(0.00001)*m).wrap(pi.neg,pi))).rho/(2.sqrt)).pow(spread)*
(Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread));

////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis

/*mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2)))).rho*
		 Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;*/

};

magnitudey=(12).collect{

			az4 = (angle+(360*2.pow(pl4/12))).wrap(180.neg,180);  // Increment azimuth
			el4 = (angle+(180*2.pow(pl4/12))).wrap(90.neg,90);
		pl4=(pl4+1).mod(12);

	sph4=(Spherical(1,(az4.degrad),(el4.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2]));

mag_y=((Complex(sin(((sph4.theta+mod_angle1).round(0.00001)*m).wrap(pi.neg,pi)),sin(((sph4.theta+mod_angle1).round(0.00001)*m).wrap(pi.neg,pi))).rho/(2.sqrt)).pow(spread)*
(Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread));
//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
};

magnitudez=(12).collect{

			az5 = (angle+(360*2.pow(pl5/12))).wrap(180.neg,180);  // Increment azimuth
				el5 = (angle+(180*2.pow(pl5/12))).wrap(90.neg,90);
		pl5=(pl5+1).mod(12);

		sph5=(Spherical(1,(az5.degrad),(el5.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2]));

mag_z=(Complex(cos(((sph5.phi+mod_angle).round(0.00001)*m).wrap((pi/2).neg,(pi/2))),cos(((sph5.phi+mod_angle1).round(0.00001)*m).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread)
		};
angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);~azz=~azz++azimuth;~ell=~ell++elevation;~magxx=~magxx++magnitudex;~magyy=~magyy++magnitudey;~magzz=~magzz++magnitudez;
};
(
~magxx = ~magxx.collect { |z| z / ~magxx.maxItem };
~magyy = ~magyy.collect { |z| z / ~magyy.maxItem };
~magzz = ~magzz.collect { |z| z / ~magzz.maxItem };
						~magxxx = ~magxx.collect { |val, i|
	var waveSpeed = 1;
	var waveFreq = 4;
	var amp=0.4;
	var theta = ~az[i].degrad;
    var phi = ~el[i].degrad;
   // var wave = sin(waveFreq * theta + waveFreq * phi - waveSpeed * t);
	var wave = amp*sin(waveFreq * theta + waveFreq * phi - waveSpeed * t);
    val * wave;
};
 );
);
				dota=(360*6).collect{

			 		az=~azz.[pla];
				el=~ell.[pla];

					magg=Cartesian(~magxx.[pla],~magyy.[pla],~magzz.[pla]).rho;
					pla=pla+1;

					sph=Spherical((magg)*400,az,el).asCartesian.asArray;



			 	};
			 	pla=0;

				data =data++dota;
			 //	data.postln;
			 	a.data = data;            // Update ScatterView3d
			 	0.065.wait
			 }});
			 r.play;


			 ~v.animate;
			 ~v.drawFunc ={
				Pen.translate(400,400);

			 	a.rot(ot,ot,ot);
			~v.refresh;

			 	ot=ot+1.degrad;

			 };
			 { while { run } {~v.background_(Color.black); ~v.refresh; (0.001).wait } }.fork(AppClock);
)*/)
Scale.directory;
s.record(numChannels:4);
