(
Server.default = s = Server.local;
////server setup

s.waitForBoot{

/////synth////
	(
		(
SynthDef.new(\ospace, {
	arg gain=1, lfo_amp=1, harm=1, azimuth=0, elevation=0, spread=1, ripple=1,amount=1;
	var sph3,sph4,sph5;
	var phase,osc1,osc2,osc3,sphere,amp1,amp2,amp3,decay=8,octave=8,multiplier=64;
	var ton1,ton2,ton3,fundamental;
	var freq,pitch1,pitch2,pitch3;
	var pitch,n1,n2,n3;
	var magx,magy,magz,mag_x,mag_y,mag_z;
	var ratio1,ratio2,ratio3,scale,nn=29.neg;
	var mod_angle,mod_angle1,mod_angle0,magxx;
	var mag,wave,waveSpeed=1,waveFreq=8,theta,phi,t,amp=5;

m=harm.lag(0.01);
waveFreq=amount.lag(0.01);
t=SinOsc.kr(ripple.lag(0.01),phase:0.degrad).range(1, 100);
mod_angle=SinOsc.ar(lfo_amp.lag(0.01),0.degrad,mul:1).range(90.neg.degrad,90.degrad);
mod_angle1=SinOsc.ar(lfo_amp.lag(0.01),90.degrad,mul:1).range(90.neg.degrad,90.degrad);

		sph3=Spherical(1,azimuth.lag(0.01),elevation.lag(0.01));
		sph4=Spherical(1,azimuth.lag(0.01),elevation.lag(0.01));
		sph5=Spherical(1,azimuth.lag(0.01),elevation.lag(0.01));

(
magx=((Complex(cos(((sph3.theta+mod_angle).round(0.00001)*m).wrap(pi.neg,pi)),
						cos((((sph3.theta+mod_angle).round(0.00001)*m)).wrap(pi.neg,pi))).rho/(2.sqrt)).pow(spread)*
	(Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),
						cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread);
				);

magy=((Complex(sin(((sph4.theta+mod_angle1).round(0.00001)*m).wrap(pi.neg,pi)),
						sin(((sph4.theta+mod_angle1).round(0.00001)*m).wrap(pi.neg,pi))).rho/(2.sqrt)).pow(spread)*
		(Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),
						cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread);
				);

magz=((Complex(cos(((sph5.phi+mod_angle).round(0.00001)*m).wrap((pi/2).neg,(pi/2))),
						cos(((sph5.phi+mod_angle1).round(0.00001)*m).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread));

 theta = azimuth.lag(0.01).degrad;
  phi = elevation.lag(0.01).degrad;
	wave = amp*sin(waveFreq * theta + waveFreq * phi - waveSpeed * t);
  magxx=  magx * wave;
	mag_x=magxx.value;mag_y=magy.value;mag_z=magz.value;
				);

scale=57.collect{nn=nn+1;Scale.major.performDegreeToKey(nn,12)};

fundamental=(6*multiplier);freq=(fundamental*octave);

sphere=Spherical(28,azimuth.lag(0.01),elevation.lag(0.01));

n1=(sphere.x).round(0.00000001); n2=(sphere.y).round(0.00000001); n3=(sphere.z).round(0.00000005);

//ton1=n1.abs;ton2=n2.abs;ton3=n3.abs;
//ton1=2.pow(n1.round(1)/12);ton2=2.pow(n2.round(1)/12);ton3=2.pow(n3.round(1)/12);

ratio1=n1.round(1);ratio2=n2.round(1);ratio3=n3.round(1);

ton1 = 2.pow(Select.kr(ratio1.linlin(28.neg, 28, 0, 56), scale) / 12);
ton2 = 2.pow(Select.kr(ratio2.linlin(28.neg, 28, 0, 56), scale) / 12);
ton3 = 2.pow(Select.kr(ratio3.linlin(28.neg, 28, 0, 56), scale) / 12);

	amp1=(ton1.reciprocal*octave.reciprocal).round(0.00000001);
	amp2=(ton2.reciprocal*octave.reciprocal).round(0.00000001);
	amp3=(ton3.reciprocal*octave.reciprocal).round(0.00000001);

	pitch1=(freq*ton1).round(0.0000001);pitch2=(freq*ton2).round(0.0000001);pitch3=(freq*ton3).round(0.0000001);
mag=Cartesian(mag_x,mag_y,mag_z).rho;

				osc1=Pan2.ar(SinOsc.ar(pitch1,mul:amp1*mag),sphere.theta.raddeg.linlin(180.neg,180,1.neg,1));
				osc2=Pan2.ar(SinOsc.ar(pitch2,mul:amp2*mag),sphere.theta.raddeg.linlin(180.neg,180,1.neg,1));
				osc3=Pan2.ar(SinOsc.ar(pitch3,mul:amp3*mag),sphere.phi.raddeg.linlin(90.neg,90,1.neg,1));

				Out.ar(0,LeakDC.ar(osc3,mul:gain*0.03));
				Out.ar(0,LeakDC.ar(osc2,mul:gain*0.03));
				Out.ar(0,LeakDC.ar(osc1,mul:gain*0.03));

}).add;
);
);


(

Window.closeAll;
w=Window.new("gui",Rect.new(100,100,800,600)).front.alwaysOnTop_(true);

~aa = Slider.new(w.view,Rect.new(20,20,500,30));

~bb = Slider.new(w.view,Rect.new(20,60,500,30));

~cc = Slider2D.new(w.view,Rect.new(60,280,600,300));

~dd = Slider.new(w.view,Rect.new(20,100,500,30));

~ee = Slider.new(w.view,Rect.new(20,140,500,30));

~ff = Slider.new(w.view,Rect.new(20,180,500,30));

~gg = Slider.new(w.view,Rect.new(20,220,500,30));

~on = Button(w,Rect(10,500,30,30)).states_([
			["off",Color.black,Color.gray],["on",Color.white,Color.gray]]).action_({
	arg obj;
	if(
		obj.value==1,{~synth=Synth.new(\ospace,[
	\gain,~aa.value,
	\lfo_amp,~bb.value.linlin(0,1,0.01,20).round(1/64),
	\harm,~dd.value.linlin(0,1,1,4).round(1/8),
	\spread,~ee.value.linlin(0,1,1,20),
	\ripple,~ff.value.linlin(0,1,0.0001,1),
	\amount,~gg.value.linlin(0,1,1,100).round(1),
\elevation,~cc.x.linlin(0,1,180.neg.degrad,180.degrad),
	\azimuth,~cc.y.linlin(0,1,90.neg.degrad,90.degrad)]).register},
		{~synth.free}
)});
(
a = StaticText(w, Rect(530,20,200, 20));
a.string = "gain";
b = StaticText(w, Rect(530,60,200, 20));
b.string = "spherical harmonic amp lfo";
c = StaticText(w, Rect(530,100,200, 20));
c.string = "spherical harmonic";
d = StaticText(w, Rect(530,140,200, 20));
d.string = "spherical harmonic width";
e = StaticText(w, Rect(530,180,200, 20));
e.string = "ripple speed";
f = StaticText(w, Rect(530,220,200, 20));
f.string = "ripple waves";
g = StaticText(w, Rect(670,400,100, 70));
g.string = "3d tone coordinate (x_azimuth,
y_elevation)";
);

(
	~aa.value_(0).action_({
	arg obj;
					var gain;
	obj.value.postln;
	//gain=obj.value;
	if(~synth.isPlaying,{~synth.set(\gain,gain)});
});
);
(
~bb.action_({
	arg obj;
			var lfo_amp;
	lfo_amp=obj.value.linlin(0,1,0.01,20).round(1/64);
				//lfo_amp.value.postln;
		if(~synth.isPlaying,{~synth.set(\lfo_amp,lfo_amp)});
});
);
(
~cc.action_({
	arg obj;
			var az,el;
	az=obj.x.linlin(0,1,180.neg.degrad,180.degrad);
	el=obj.y.linlin(0,1,90.neg.degrad,90.degrad);
			if(~synth.isPlaying,{~synth.set(\azimuth,az,\elevation,el)});
});
);
(
~dd.action_({
	arg obj;
			var harm;
				harm=obj.value.linlin(0,1,1,4).round(1/8);
				//harm.value.postln;
if(~synth.isPlaying,{~synth.set(\harm,harm)});
});
);
(
~ee.action_({
	arg obj;
			var spread;
			spread=obj.value.linlin(0,1,1,20);
				//spread.value.postln;
if(~synth.isPlaying,{~synth.set(\spread,spread)});
});
);
	(
~ff.action_({
	arg obj;
			var ripple;
			ripple=obj.value.linlin(0,1,0.0001,1);
				//ripple.value.postln;
if(~synth.isPlaying,{~synth.set(\ripple,ripple)});
});
);
			(
~gg.action_({
	arg obj;
			var amount;
				amount=obj.value.linlin(0,1,1,100).round(1);
				//amount.value.postln;
if(~synth.isPlaying,{~synth.set(\amount,amount)});
});
);
	);
}
)

