



(
var position,angle=0,mx=3,my=3,n=0,thita;
var pos,magx,magy;
var position1,position2,thita1,thita2,n1=0,n2=0,mag1,mag2;
~angle=[];~magx=[];~magy=[];

360.do{

pos= 13.collect{

		thita = angle.degrad + ((pi/4)*2.pow(n/12));
		n=(n+1).mod(13);
		n.postln;
	position=exp(Complex(0,1)*thita).theta;

};

magx = 13.collect{

        thita1 = angle.degrad + ((pi/4)*2.pow(n1/12));
		n1=(n1+1).mod(13);
	position1=exp(Complex(0,1)*thita1).theta;

	mag1=(Complex(exp(Complex(0,1)*(position1.round(0.000001)*mx)).real,exp(Complex(0,1)*(position1.round(0.0001)*mx)).real).rho.round(0.0001)
		*Complex(exp(Complex(0,1)*(position1.round(0.000001)*mx)).real,exp(Complex(0,1)*(position1.round(0.0001)*mx)).real).rho).round(0.0001);

	};

magy = 13.collect{

	    thita2 = angle.degrad + ((pi/4)*2.pow(n2/12));
		n2=(n2+1).mod(13);
	position2=exp(Complex(0,1)*thita2).theta;

		mag2=(Complex(exp(Complex(0,1)*(position2.round(0.000001)*my)).imag,exp(Complex(0,1)*(position2.round(0.0001)*my)).imag).rho.round(0.0001)
		*Complex(exp(Complex(0,1)*(position2.round(0.000001)*my)).real,exp(Complex(0,1)*(position2.round(0.0001)*my)).real).rho).round(0.0001);

	};
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360); ~angle=~angle++pos;~magx=~magx++magx;~magy=~magy++magy;
	}
)

///////2d

(
var data;
var az=0,el=0;
var m=600,sph,az1,el1,pl=89,daz,del,harm,mag,r;
var r1,harm1,r2,harm2,rad,sph1;

data = (360*12).collect{

	az=~angle.[pl];
	//el=~el.[pl];
	mag=Complex(~magx.[pl]/(2.sqrt),~magy.[pl]/(2.sqrt)).rho/(2.sqrt);
	pl=pl+1;

	sph=Polar(mag*800,az);
	sph1=Cartesian(sph.x,sph.y,0).asArray;


};

w = Window.new("3D Scatterplot", Rect(40,40, 1000, 800)).front;
a = ScatterView3d(w, Rect(0,0, 800,800), data, [-1000, 1000].asSpec,[-1000, 1000].asSpec,[-1000, 1000].asSpec);
a.drawMethod = \fillRect;
a.symbolSize = 1;
a.symbolColor = Color.white;
a.background = Color.black;

// Y Slider
Slider(w, Rect(820, 10, 10, 450)).action_{|me|
    a.rotY = me.value * 2pi;
    w.refresh;
};
// X Slider
Slider(w, Rect(870, 10, 10, 450)).action_{|me|
    a.rotX = me.value * 2pi;
    w.refresh;
};
// Z Slider
Slider(w, Rect(920, 10, 10, 450)).action_{|me|
    a.rotZ = me.value * 2pi;
    w.refresh;
};
)
///3d




(
Server.default = s = Server.local;
////server setup
(
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=5;
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
s.meter;
	s.freqscope;
	s.scope;
~t= Buffer.alloc(s,2048);

///////////////////////////////////////////////////////arrays
///////l-system
	(
{
var dict = IdentityDictionary[\A -> "AB", \B -> "A"];
//These are the production rules of the L-system
var word = "A";
var string_temp = "";
var iter = 18;

//These are diction for the mapping of the alphabet to "artistic" parameters: degrees in a scale, beat occurrence, etc.

var dictnotes = IdentityDictionary[\A -> 0, \B -> 1];
 ~r=[];

//This iteration generates the system recursively

iter.do({

word.asArray.do({|i|
    string_temp = string_temp ++ dict[i.asSymbol];
});

word = string_temp;
	string_temp = "";
});

word.postln;

//Here we map the final system to the parameters as above

word.do({|i| ~r = ~r ++ dictnotes[i.asSymbol];});

~r.postln;
}.value
);


//////////////////////////////////////////////////basis


		//////////////////////wavetable
		{
var signal,wt,m=0,amp;

~level=90.collect{m=m+1;amp=m.reciprocal};
~phase=90.collect{pi};
signal=Signal.sineFill(1024,~level,~phase);

wt = signal.asWavetable;
~t.loadCollection(wt);
//signal.plot;
		}.value;

		//////notes
	({
		var angle=0;
		~angle=(360*12).collect{
		angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
		}
		}.value;
	~angle1=~angle/2;
	);


/////synths////
	(
(
SynthDef.new(\ospace1, {
	arg amp=1,pl1=1;
	var phase,osc1,osc2,osc3,sphere,amp1,amp2,amp3,decay=8,pl2=0,envp,octave=1;
	var ton1,ton2,ton3;
	var fundamental;
	var freq,pitch1,pitch2,pitch3,env;
	var pitch;
	var n1,n2,n3,rq1,rq2,rq3;
	var mag,magx,magy,magz;
				var sig,rq;

//mag=Cartesian(Select.kr(pl1,~magx), Select.kr(pl1,~magy),Select.kr(pl1,~magz));
				magx=Cartesian(Select.kr(pl1,~magx), 0,0);
				magy=Cartesian(0, Select.kr(pl1,~magy),0);
				magz=Cartesian(0, 0,Select.kr(pl1,~magz));

				//env=EnvGen.ar(Env.adsr(0.05,0.5,0.5,decay),gate,doneAction:2,levelScale:0.1);
				env=EnvGen.ar(Env.perc(0.02,decay,amp),doneAction:2,levelScale:1/10);
				//env=EnvGen.ar(Env.sine(decay,amp),doneAction:2,levelScale:1/10);

//fundamental=(12*6);

fundamental=(12*96);
freq=(fundamental*octave);

sphere=Spherical(64,Select.kr(pl1,~az),Select.kr(pl1,~el));

n1=(sphere.x).round(0.00000001); n2=(sphere.y).round(0.00000001); n3=(sphere.z).round(0.00000005);

//ton1=n1.abs;
//ton2=n2.abs;
//ton3=n3.abs;
ton1=2.pow(n1/12);
ton2=2.pow(n2/12);
ton3=2.pow(n3/12);

amp1=(ton1.reciprocal*octave.reciprocal).round(0.00000001);
amp2=(ton2.reciprocal*octave.reciprocal).round(0.00000001);
amp3=(ton3.reciprocal*octave.reciprocal).round(0.00000001);

	pitch1=(freq*ton1).round(0.0000001);
	pitch2=(freq*ton2).round(0.0000001);
	pitch3=(freq*ton3).round(0.0000001);

				sig= InFeedback.ar(4,1);
				//rq=MouseX.kr(0.000001,1);
		/*	rq1=0.1;
				rq2=0.1;
				rq3=0.1;*/
				rq1=In.kr(0);
				rq2=In.kr(1);
				rq3=In.kr(2);
				/*	rq1=MouseX.kr(0.0000001,0.1);
				rq2=MouseX.kr(0.0000001,0.1);
				rq3=MouseX.kr(0.0000001,0.1);
*/

osc1=VBAP.ar(4,
					BPF.ar(sig, pitch1, rq1, mul: amp1 * magx.rho.round(0.00000001) * (rq1.reciprocal)),
~b.bufnum,
sphere.theta.raddeg,sphere.phi.raddeg
//Osc.ar(~t.bufnum,1/2,phase:sphere.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
//Osc.ar(~t.bufnum,1/4,phase:sphere.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);

osc2=VBAP.ar(4,
					BPF.ar(sig,pitch2,rq2,mul:amp2*magy.rho.round(0.00000001)* (rq1.reciprocal)),
~b.bufnum,
sphere.theta.raddeg,sphere.phi.raddeg
//Osc.ar(~t.bufnum,1/2,phase:sphere.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
//Osc.ar(~t.bufnum,1/4,phase:sphere.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);

osc3=VBAP.ar(4,
						BPF.ar(sig,pitch3,rq3,mul:amp3*magz.rho.round(0.00000001)* (rq1.reciprocal)),
~b.bufnum,
sphere.theta.raddeg,sphere.phi.raddeg
//Osc.ar(~t.bufnum,1/2,phase:sphere.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
//Osc.ar(~t.bufnum,1/4,phase:sphere.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);
					Out.ar(0,LeakDC.ar(osc3,mul:env));
					Out.ar(0,LeakDC.ar(osc2,mul:env));
					Out.ar(0,LeakDC.ar(osc1,mul:env));

}).add;
);
);

	(
(
SynthDef.new(\ospace1, {
	arg mult1=1,mult2=1,amp=1,pl1=1;
	var phase,osc1,osc2,sphere,mag_o,amp1,amp2,decay=7,octave=2;
	var ton1,ton2;
	var fundamental;
	var freq,pitch1,pitch2,env;
	var pitch;
	var n1,n2;
	var xyz;

				env=EnvGen.ar(Env.perc(0.01,decay,amp),doneAction:2,levelScale:4);

fundamental=(55);
freq=(fundamental*octave);

		mag_o=Complex(Select.kr(pl1,~magx), Select.kr(pl1,~magy));
				sphere=Polar(mag_o.rho.round(0.00000001)/(2.sqrt),Select.kr(pl1,~angle));

	xyz=Polar(sphere.rho,sphere.theta);

	n1=(xyz.x).round(0.00000001); n2=(xyz.y).round(0.00000001);

ton1=n1.abs.linlin(0,1,1,2*mult1);
ton2=n2.abs.linlin(0,1,1,2*mult2);

	    amp1=(ton1.reciprocal*octave.reciprocal).round(0.00000001);
		amp2=(ton2.reciprocal*octave.reciprocal).round(0.00000001);

	pitch1=(freq*ton1).round(0.0000001);
	pitch2=(freq*ton2).round(0.0000001);



osc1=Pan2.ar(SinOsc.ar(pitch1,mul:amp1,phase:0),exp(Complex(0,1)*sphere.theta).real);

osc2=Pan2.ar(SinOsc.ar(pitch2,mul:amp2,phase:0),exp(Complex(0,1)*sphere.theta).imag);

					Out.ar(0,LeakDC.ar(osc2,mul:env));

					Out.ar(0,LeakDC.ar(osc1,mul:env));

}).add;
);
);

////////////list
	({
		var n=1;
		~list1=(360*12).collect{
		n=n+1;
		}
		}.value
	);

	~dur=[1/2,1,1,1/3,1/2,1/5,1,1/2];

//////////pattern for mobius strib of sequential or parallel play of directions
	(

~aa=Pdef(\1, Pbind(\instrument, \ospace1,
			\dur,Pseq(~dur1,1),
			//\dur,Pxrand(~dur,inf),
			//\pl1,Prand(~list1,inf),
			\pl1,Pbrown(0,4680,6,inf),
			\mult1,Prand([1,2,4,8],inf),
				\mult2,Prand([1,2,4,8],inf),
			//\amp,Pseq(~r,inf);///l system
));

~aaa=Pdef(\9, Pbind(\instrument, \ospace1,
			\dur,Pseq(~dur2,1),
			//\dur,Pxrand(~dur,inf),
			//\pl1,Prand(~list1,inf),
			\pl1,Pbrown(0,4680,6,inf),
				\mult1,Prand([1,2,4,8],inf),
				\mult2,Prand([1,2,4,8],inf),
			//\amp,Pseq(~r,inf);///l system
));
	);
	TempoClock.default.tempo_(1/32);



}
)


(
~aa.play;
~aaa.play;
);
s.record(numChannels:2);


////////////list
	({
		var n=1.neg;
		~list1=(360*13).collect{
		n=n+1;
		}
		}.value
	);

//////////pattern for mobius strib of sequential or parallel play of directions
	(

~aa=Pdef(\1, Pbind(\instrument, \ospace1,
			\dur,Pseq(~dur,1),
			//\dur,1,
		//	\pl1,Pbrown(1,4680,13,inf),
	\pl1,Pseq([
				Prand(
				[Pseq(Array.rand(3,1,12),1),Pseq(Array.rand(3,13,25),1),Pseq(Array.rand(3,26,38),1),Pseq(Array.rand(3,39,51),1),
				Pseq(Array.rand(3,52,64),1),Pseq(Array.rand(3,65,77),1),Pseq(Array.rand(3,78,90),1),Pseq(Array.rand(3,91,103),1)]
				,1),
				Prand(
				[Pseq(Array.rand(3,104,116),1),Pseq(Array.rand(3,117,129),1),Pseq(Array.rand(3,130,142),1),Pseq(Array.rand(3,143,155),1),
				Pseq(Array.rand(3,156,168),1),Pseq(Array.rand(3,169,181),1),Pseq(Array.rand(3,182,194),1),Pseq(Array.rand(3,195,207),1)]
				,1),
				Prand(
				[Pseq(Array.rand(3,208,220),1),Pseq(Array.rand(3,221,233),1),Pseq(Array.rand(3,234,246),1),Pseq(Array.rand(3,247,259),1),
				Pseq(Array.rand(3,260,272),1),Pseq(Array.rand(3,273,285),1),Pseq(Array.rand(3,286,298),1),Pseq(Array.rand(3,299,311),1)]
				,1),
				Prand(
				[Pseq(Array.rand(3,312,324),1),Pseq(Array.rand(3,325,337),1),Pseq(Array.rand(3,338,350),1),Pseq(Array.rand(3,351,363),1),
				Pseq(Array.rand(3,364,376),1),Pseq(Array.rand(3,377,389),1),Pseq(Array.rand(3,390,401),1),Pseq(Array.rand(3,403,415),1)]
				,1),
				Prand(
				[Pseq(Array.rand(3,416,428),1),Pseq(Array.rand(3,429,441),1),Pseq(Array.rand(3,442,454),1),Pseq(Array.rand(3,455,467),1),
				Pseq(Array.rand(3,468,480),1),Pseq(Array.rand(3,481,493),1),Pseq(Array.rand(3,494,506),1),Pseq(Array.rand(3,507,519),1)]
				,1),
				Prand(
				[Pseq(Array.rand(3,520,532),1),Pseq(Array.rand(3,533,545),1),Pseq(Array.rand(3,546,558),1),Pseq(Array.rand(3,559,571),1),
				Pseq(Array.rand(3,572,584),1),Pseq(Array.rand(3,585,597),1),Pseq(Array.rand(3,598,610),1),Pseq(Array.rand(3,611,623),1)]
				,1),
				Prand(
				[Pseq(Array.rand(3,624,636),1),Pseq(Array.rand(3,637,649),1),Pseq(Array.rand(3,650,662),1),Pseq(Array.rand(3,663,675),1),
				Pseq(Array.rand(3,676,688),1),Pseq(Array.rand(3,689,701),1),Pseq(Array.rand(3,702,714),1),Pseq(Array.rand(3,715,727),1)]
				,1),
				Prand(
				[Pseq(Array.rand(3,728,740),1),Pseq(Array.rand(3,741,753),6,1),Pseq(Array.rand(3,754,766),1),Pseq(Array.rand(3,767,779),1),
				Pseq(Array.rand(3,780,792),1),Pseq(Array.rand(3,793,805),1),Pseq(Array.rand(3,806,818),1),Pseq(Array.rand(3,819,831),1)]
				,1)
			],inf),
			//\pl1,Pseq(~list1,inf),
		//\out1,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
		//	\out2,Pn(Pshuf([0, 1, 2, 3, 4, 5], 1), inf).clump(6).collect([_]),
		//	\out3,Pn(Pshuf([0, 1, 2, 3, 4, 5], 1), inf).clump(6).collect([_]),
			//\amp,Pseq(~r,inf);///l system
			\amp,1;
));

~aaa=Pdef(\2, Pbind(\instrument, \ospace1,
		\dur,Pseq(~dur,1),
		//\dur,1.5,
			\pl1,Pseq([
				Prand(
				[Pseq(Array.rand(3,1,12),1),Pseq(Array.rand(3,13,25),1),Pseq(Array.rand(3,26,38),1),Pseq(Array.rand(3,39,51),1),
				Pseq(Array.rand(3,52,64),1),Pseq(Array.rand(3,65,77),1),Pseq(Array.rand(3,78,90),1),Pseq(Array.rand(3,91,103),1)]
				,1),
				Prand(
				[Pseq(Array.rand(3,104,116),1),Pseq(Array.rand(3,117,129),1),Pseq(Array.rand(3,130,142),1),Pseq(Array.rand(3,143,155),1),
				Pseq(Array.rand(3,156,168),1),Pseq(Array.rand(3,169,181),1),Pseq(Array.rand(3,182,194),1),Pseq(Array.rand(3,195,207),1)]
				,1),
				Prand(
				[Pseq(Array.rand(3,208,220),1),Pseq(Array.rand(3,221,233),1),Pseq(Array.rand(3,234,246),1),Pseq(Array.rand(3,247,259),1),
				Pseq(Array.rand(3,260,272),1),Pseq(Array.rand(3,273,285),1),Pseq(Array.rand(3,286,298),1),Pseq(Array.rand(3,299,311),1)]
				,1),
				Prand(
				[Pseq(Array.rand(3,312,324),1),Pseq(Array.rand(3,325,337),1),Pseq(Array.rand(3,338,350),1),Pseq(Array.rand(3,351,363),1),
				Pseq(Array.rand(3,364,376),1),Pseq(Array.rand(3,377,389),1),Pseq(Array.rand(3,390,401),1),Pseq(Array.rand(3,403,415),1)]
				,1),
				Prand(
				[Pseq(Array.rand(3,416,428),1),Pseq(Array.rand(3,429,441),1),Pseq(Array.rand(3,442,454),1),Pseq(Array.rand(3,455,467),1),
				Pseq(Array.rand(3,468,480),1),Pseq(Array.rand(3,481,493),1),Pseq(Array.rand(3,494,506),1),Pseq(Array.rand(3,507,519),1)]
				,1),
				Prand(
				[Pseq(Array.rand(3,520,532),1),Pseq(Array.rand(3,533,545),1),Pseq(Array.rand(3,546,558),1),Pseq(Array.rand(3,559,571),1),
				Pseq(Array.rand(3,572,584),1),Pseq(Array.rand(3,585,597),1),Pseq(Array.rand(3,598,610),1),Pseq(Array.rand(3,611,623),1)]
				,1),
				Prand(
				[Pseq(Array.rand(3,624,636),1),Pseq(Array.rand(3,637,649),1),Pseq(Array.rand(3,650,662),1),Pseq(Array.rand(3,663,675),1),
				Pseq(Array.rand(3,676,688),1),Pseq(Array.rand(3,689,701),1),Pseq(Array.rand(3,702,714),1),Pseq(Array.rand(3,715,727),1)]
				,1),
				Prand(
				[Pseq(Array.rand(3,728,740),1),Pseq(Array.rand(3,741,753),6,1),Pseq(Array.rand(3,754,766),1),Pseq(Array.rand(3,767,779),1),
				Pseq(Array.rand(3,780,792),1),Pseq(Array.rand(3,793,805),1),Pseq(Array.rand(3,806,818),1),Pseq(Array.rand(3,819,831),1)]
				,1)
			],inf),

			//\pl1,Pbrown(1,4680,13,inf),
			//\pl1,Pseq(~list1,inf),
		//\out1,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
		//	\out2,Pn(Pshuf([0, 1, 2, 3, 4, 5], 1), inf).clump(6).collect([_]),
		//	\out3,Pn(Pshuf([0, 1, 2, 3, 4, 5], 1), inf).clump(6).collect([_]),
			\amp,Pseq(~r,inf);///l system
			//\amp,1;
));

~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Dokuments/EXTERNAL/music/band album library/Blazon Stone/Return To Port Royal - Definitive Edition/01 Black Chest In (Intro).wav",channels:0);
	);
	TempoClock.default.tempo_(1);

	~b=Buffer.alloc(s,2048);
			{
var signal,wt,env;

		env=Env([0.0001,0.0001,0.01,0.1,0.1,0.01,0.0001,0.0001],[30,20,10,5,10,20,30],[0,4,-4,0,4,-4,0]);
		signal=env.asSignal(1024);
wt=signal.asWavetable;
		signal.plot;
~b.loadCollection(wt);
		}.value;

(
~synth=(
SynthDef.new(\obuff, {
	arg buffer=0;
	var sig,env,gain=1;

			//env= EnvGen.ar(Env.sine(10),doneAction:2);

			sig=PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1.bufnum),startPos:0, loop: 0, doneAction:2);

			Out.ar(4,sig*gain);
				Out.kr(0,Osc.kr(~b.bufnum,0.05,phase:0.degrad));
				Out.kr(1,Osc.kr(~b.bufnum,0.05,phase:0.degrad));
				Out.kr(2,Osc.kr(~b.bufnum,0.05,phase:0.degrad));


}).add;
);
);

}
)

Buffer.freeAll;


TempoClock.default.tempo_(4/1);




(
~aa.play;
~aaa.play;
		Synth(\obuff);
);

s.record(numChannels:4);
