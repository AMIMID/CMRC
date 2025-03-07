

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
({
var position,angle=0,mx=2,my=2,n=0,thita;
var pos,magx,magy;
var position1,position2,thita1,thita2,n1=0,n2=0,mag1,mag2;
var durx,dury,th1,th2,n3=0,n4=0,posotion3,position4,num=1.neg;
~angle=[];~magx=[];~magy=[];~dur=[];

360.do{

			durx=12.collect{
		th1 = angle.degrad + ((pi/4)*2.pow(n3/12));
		n3=(n3+1).mod(12);
	posotion3=exp(Complex(0,1)*th1).real.abs;

};
			dury=12.collect{
		th2 = angle.degrad + ((pi/4)*2.pow(n4/12));
		n4=(n4+1).mod(12);
	position4=exp(Complex(0,1)*th2).imag.abs;
};

pos= 12.collect{

		th2 = angle.degrad + ((pi/4)*2.pow(n/12));
		n=(n+1).mod(12);
	//	n.postln;
	position=exp(Complex(0,1)*th2).theta;

};

magx = 12.collect{

        thita1 = angle.degrad + ((pi/4)*2.pow(n1/12));
		n1=(n1+1).mod(12);
	position1=exp(Complex(0,1)*thita1).theta;

	mag1=(Complex(exp(Complex(0,1)*(position1.round(0.000001)*mx)).real,exp(Complex(0,1)*(position1.round(0.0001)*mx)).real).rho.round(0.0001)
		*Complex(exp(Complex(0,1)*(position1.round(0.000001)*mx)).real,exp(Complex(0,1)*(position1.round(0.0001)*mx)).real).rho).round(0.0001);

	};

magy = 12.collect{

	    thita2 = angle.degrad + ((pi/4)*2.pow(n2/12));
		n2=(n2+1).mod(12);
	position2=exp(Complex(0,1)*thita2).theta;

		mag2=(Complex(exp(Complex(0,1)*(position2.round(0.000001)*my)).imag,exp(Complex(0,1)*(position2.round(0.0001)*my)).imag).rho.round(0.0001)
		*Complex(exp(Complex(0,1)*(position2.round(0.000001)*my)).real,exp(Complex(0,1)*(position2.round(0.0001)*my)).real).rho).round(0.0001);

	};
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360); ~angle=~angle++pos;~magx=~magx++magx;~magy=~magy++magy;
			12.do{ num=num+1; ~dur=~dur++durx.[num]++dury.[num]};num=1.neg;
	}}.value;
);
~dur=~dur*2;


/////synths////

	(
(
SynthDef.new(\ospace1, {
	arg amp=1,pl1=1;
	var phase,osc1,osc2,sphere,mag_o,amp1,amp2,decay=7,octave=1;
	var ton1,ton2;
	var fundamental;
	var freq,pitch1,pitch2,env;
	var pitch;
	var n1,n2;
	var xyz,rq1,rq2,sig;
						env=EnvGen.ar(Env.perc(0.02,decay,amp),doneAction:2,levelScale:0.01);
				//env=EnvGen.ar(Env.sine(decay,amp),doneAction:2,levelScale:0.01);

fundamental=(12*96);
freq=(fundamental*octave);

		mag_o=Complex(Select.kr(pl1,~magx), Select.kr(pl1,~magy));
		sphere=Polar(1,Select.kr(pl1,~angle));
xyz=Polar(32,Select.kr(pl1,~angle));

	n1=(xyz.x).round(0.00000001); n2=(xyz.y).round(0.00000001);

//ton1=n1.abs;ton2=n2.abs;
ton1=2.pow(n1/12);ton2=2.pow(n2/12);
amp1=(ton1.reciprocal*octave.reciprocal).round(0.00000001);	amp2=(ton2.reciprocal*octave.reciprocal).round(0.00000001);
pitch1=(freq*ton1).round(0.0000001);pitch2=(freq*ton2).round(0.0000001);

				sig= InFeedback.ar(2,1);
				rq1=In.kr(0);
				rq2=In.kr(1);

//osc1=Pan2.ar(BPF.ar(sig, pitch1, rq1, mul: amp1 * mag_o.real.round(0.00000001) * (rq1.reciprocal)),sphere.asComplex.real.round(0.00000001));
osc1=Pan2.ar(SinOsc.ar(pitch1,mul:amp1*mag_o.real.round(0.00000001),phase:0),sphere.x.round(0.00000001));

//osc2=Pan2.ar(BPF.ar(sig, pitch2, rq2, mul: amp2 * mag_o.imag.rho.round(0.00000001) * (rq2.reciprocal)),sphere.asComplex.imag.round(0.00000001));
osc2=Pan2.ar(SinOsc.ar(pitch2,mul:amp2*mag_o.imag.round(0.00000001),phase:90),sphere.y.round(0.00000001));


					Out.ar(0,LeakDC.ar(osc2,mul:env));
				Out.ar(0,LeakDC.ar(osc1,mul:env));

}).add;
);
		(
SynthDef.new(\ospace2, {
	arg amp=1,pl1=1;
	var phase,osc1,osc2,sphere,mag_o,amp1,amp2,decay=7,octave=1;
	var ton1,ton2;
	var fundamental;
	var freq,pitch1,pitch2,env;
	var pitch;
	var n1,n2;
	var xyz,rq1,rq2,sig;
				env=EnvGen.ar(Env.perc(0.02,decay,amp),doneAction:2,levelScale:0.01);
				//env=EnvGen.ar(Env.sine(decay,amp),doneAction:2,levelScale:0.01);

fundamental=(12*96);
freq=(fundamental*octave);

		mag_o=Complex(Select.kr(pl1,~magx), Select.kr(pl1,~magy));
		sphere=Polar(1,Select.kr(pl1,~angle));
xyz=Polar(32,Select.kr(pl1,~angle));

	n1=(xyz.x).round(0.00000001); n2=(xyz.y).round(0.00000001);

//ton1=n1.abs;ton2=n2.abs;
ton1=2.pow(n1/12);ton2=2.pow(n2/12);
amp1=(ton1.reciprocal*octave.reciprocal).round(0.00000001);	amp2=(ton2.reciprocal*octave.reciprocal).round(0.00000001);
pitch1=(freq*ton1).round(0.0000001);pitch2=(freq*ton2).round(0.0000001);

				sig= InFeedback.ar(3,1);
				rq1=In.kr(0);
				rq2=In.kr(1);

//osc1=Pan2.ar(BPF.ar(sig, pitch1, rq1, mul: amp1 * mag_o.real.round(0.00000001) * (rq1.reciprocal)),sphere.asComplex.real.round(0.00000001));
osc1=Pan2.ar(SinOsc.ar(pitch1,mul:amp1*mag_o.real.round(0.00000001),phase:0),sphere.x.round(0.00000001));

//osc2=Pan2.ar(BPF.ar(sig, pitch2, rq2, mul: amp2 * mag_o.imag.rho.round(0.00000001) * (rq2.reciprocal)),sphere.asComplex.imag.round(0.00000001));
osc2=Pan2.ar(SinOsc.ar(pitch2,mul:amp2*mag_o.imag.round(0.00000001),phase:90),sphere.y.round(0.00000001));


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

//////////pattern for mobius strib of sequential or parallel play of directions
	(

~aa=Pdef(\1, Pbind(\instrument, \ospace1,
			\dur,Pseq(~dur,1),
			//\dur,Pxrand(~dur,inf),
			//\pl1,Prand(~list1,inf),
			\pl1,Pbrown(0,4320,6,inf),
			\amp,1,
			//\amp,Pseq(~r,inf);///l system
));

~aaa=Pdef(\2, Pbind(\instrument, \ospace2,
			\dur,Pseq(~dur,1),
			//\dur,Pxrand(~dur,inf),
			//\pl1,Prand(~list1,inf),
			\pl1,Pbrown(0,4320,6,inf),
			\amp,Pseq(~r,inf);///l system
));
	);
	TempoClock.default.tempo_(1/32);
///bufs
~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Dokuments/EXTERNAL/music/band album library/Electric Wizard/Dopethrone/01 Vinum Sabbathi.wav",channels:0);
~c2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Dokuments/EXTERNAL/music/band album library/Electric Wizard/Dopethrone/01 Vinum Sabbathi.wav",channels:1);
	TempoClock.default.tempo_(1);

	~b=Buffer.alloc(s,2048);
			{
var signal,wt,env;

		env=Env([0.0001,0.0001,0.05,0.1,0.1,0.05,0.0001,0.0001],[40,30,20,10,20,30,40],[0,12,-4,0,4,-12,0]);
		signal=env.asSignal(1024);
wt=signal.asWavetable;
		signal.plot;
~b.loadCollection(wt);
		}.value;

(
~synth=(
SynthDef.new(\obuff, {
	arg buffer=0;
	var sig1,sig2,env,gain=1;

			//env= EnvGen.ar(Env.sine(10),doneAction:2);

			sig1=PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1.bufnum),startPos:0, loop: 0, doneAction:2);
			sig2=PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2.bufnum),startPos:0, loop: 0, doneAction:2);


			Out.ar(2,sig1*gain);
				Out.ar(3,sig2*gain);
				Out.kr(0,Osc.kr(~b.bufnum,0.01,phase:0.degrad));
				Out.kr(1,Osc.kr(~b.bufnum,0.01,phase:10.degrad));


}).add;
);
);

}
)


(
~aa.play;
~aaa.play;
);
s.record(numChannels:2);


TempoClock.default.tempo_(4/1);
