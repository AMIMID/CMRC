(
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(0.5);
s.options.memSize = 8192*32;
s.options.blockSize = 64/1;
s.options.maxNodes = 1024 * 16;
s.options.sampleRate= 48000;
s.waitForBoot
)


Buffer.freeAll
////////////////////buffers
(
~l1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/PROJECT  FILES/uni/ksyme/askhsh1/voice sapmles/ANNA MARIA HEFEE VOICE SAMPLE 1.wav",channels:0 );
~r1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/PROJECT  FILES/uni/ksyme/askhsh1/voice sapmles/ANNA MARIA HEFEE VOICE SAMPLE 1.wav",channels:1 );
~l2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/PROJECT  FILES/uni/ksyme/askhsh1/voice sapmles/ANNA MARIA HEFEE VOICE SAMPLE 2.wav",channels:0 );
~r2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/PROJECT  FILES/uni/ksyme/askhsh1/voice sapmles/ANNA MARIA HEFEE VOICE SAMPLE 2.wav",channels:1 );
~l3 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/PROJECT  FILES/uni/ksyme/askhsh1/voice sapmles/ANNA MARIA HEFEE VOICE SAMPLE 3.wav",channels:0 );
~r3 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/PROJECT  FILES/uni/ksyme/askhsh1/voice sapmles/ANNA MARIA HEFEE VOICE SAMPLE 3.wav",channels:1 );
)


(
~time=1;
////////fractal
{
var c,angle=0,c_real,c_imag,z;



~c = 5.collect{
 	c_real=exp(Complex(0,1)*angle.degrad).real;
	c_imag=exp(Complex(0,1)*angle.degrad).imag;
 	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
 	c=Complex(c_real,c_imag);
 };
z=Complex(0,0);

~j = (720*~time).collect{
	c=~c.[4];
	z=z.pow(2)+c;
	z.theta.round(0.000001);
}

}.value;
////////////////////////////////////////space arrays
{
var phase1,phase2,angle1=0,angle2=0,m=2,pl1=0,pl2=0;

~posL=(720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl1])).theta;
	pl1=pl1=1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	phase1=(Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho).round(0.0001);

};

	~posR=(720*~time).collect{

	phase2=exp(Complex(0,1)*(angle2.degrad*~j.[pl2])).theta;
	pl2=pl2=1;
	angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);
	phase2=(Complex(sin(phase2.round(0.0001)*m),sin(phase2.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase2.round(0.0001)*m),cos(phase2.round(0.0001)*m)).rho).round(0.0001).neg;
};

}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=2,pl1=0,pl2=0;

~magL = (720*~time).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1=1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001);
	};

~magR = (720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2=1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho.round(0.0001);
	};
}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=1,pl1=0,pl2=0;

~magL1 = (720*~time).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1=1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001);
	};

~magR1 = (720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2=1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho.round(0.0001);
	};
}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=2,pl1=0,pl2=0;

~magL2 = (720*~time).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1=1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001);
	};

~magR2 = (720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2=1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho.round(0.0001);
	};
}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=3,pl1=0,pl2=0;

~magL3 = (720*~time).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1=1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001);
	};

~magR3 = (720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2=1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho.round(0.0001);
	};
}.value;

{
var phase1,phase2,angle1=0,angle2=0,m=1,pl1=0,pl2=0;

~posL1=(720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl1])).theta;
	pl1=pl1=1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	phase1=(Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho).round(0.0001);

};

	~posR1=(720*~time).collect{

	phase2=exp(Complex(0,1)*(angle2.degrad*~j.[pl2])).theta;
	pl2=pl2=1;
	angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);
	phase2=(Complex(sin(phase2.round(0.0001)*m),sin(phase2.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase2.round(0.0001)*m),cos(phase2.round(0.0001)*m)).rho).round(0.0001).neg;
};

}.value;

{
var phase1,phase2,angle1=0,angle2=0,m=2,pl1=0,pl2=0;

~posL2=(720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl1])).theta;
	pl1=pl1=1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	phase1=(Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho).round(0.0001);

};

	~posR2=(720*~time).collect{

	phase2=exp(Complex(0,1)*(angle2.degrad*~j.[pl2])).theta;
	pl2=pl2=1;
	angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);
	phase2=(Complex(sin(phase2.round(0.0001)*m),sin(phase2.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase2.round(0.0001)*m),cos(phase2.round(0.0001)*m)).rho).round(0.0001).neg;
};

}.value;

{
var phase1,phase2,angle1=0,angle2=0,m=3,pl1=0,pl2=0;

~posL3=(720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl1])).theta;
	pl1=pl1=1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	phase1=(Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho).round(0.0001);

};

	~posR3=(720*~time).collect{

	phase2=exp(Complex(0,1)*(angle2.degrad*~j.[pl2])).theta;
	pl2=pl2=1;
	angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);
	phase2=(Complex(sin(phase2.round(0.0001)*m),sin(phase2.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase2.round(0.0001)*m),cos(phase2.round(0.0001)*m)).rho).round(0.0001).neg;
};

}.value;

(
~magR=~magR.normalize(0,1).round(0.0000000000001);
~magL=~magL.normalize(0,1).round(0.0000000000001);
~magR1=~magR1.normalize(0,1).round(0.0000000000001);
~magL1=~magL1.normalize(0,1).round(0.0000000000001);
~magR2=~magR2.normalize(0,1).round(0.0000000000001);
~magL2=~magL2.normalize(0,1).round(0.0000000000001);
~magR3=~magR3.normalize(0,1).round(0.0000000000001);
~magL3=~magL3.normalize(0,1).round(0.0000000000001);
~posL1=~posL1.round(0.0000000000001);
~posR1=~posR1.round(0.0000000000001);
~posL2=~posL2.round(0.0000000000001);
~posR2=~posR2.round(0.0000000000001);
~posL3=~posL3.round(0.0000000000001);
~posR3=~posR3.round(0.0000000000001);
);

)


//////////////synth
(
SynthDef.new(\buf3d,
{
var signal1,signal2,signal3,signal4,signal5,signal6;
var pl=0,b=0,frames=(1024*1);
var mg1,mg2,mg3;
var pos1,pos2,pos3,pos4,pos5,pos6;
var ph1,ph2,ph3,ph4,ph5,ph6;
var in1,in2,in3,in4,in5,in6;
var chainx1,chainy1,chainx2,chainy2,chainx3,chainy3;
var chainxx1,chainyy1,chainxx2,chainyy2,chainxx3,chainyy3;

	in1 = PlayBuf.ar(1, ~l1.bufnum, BufRateScale.kr(~l1.bufnum), loop: 0, doneAction:2);
	in2 = PlayBuf.ar(1, ~r1.bufnum, BufRateScale.kr(~r1.bufnum), loop: 0, doneAction:2);
	in3 = PlayBuf.ar(1, ~l2.bufnum, BufRateScale.kr(~l2.bufnum), loop: 0, doneAction:0);
	in4 = PlayBuf.ar(1, ~r2.bufnum, BufRateScale.kr(~r2.bufnum), loop: 0, doneAction:0);
	in5 = PlayBuf.ar(1, ~l3.bufnum, BufRateScale.kr(~l3.bufnum), loop: 0, doneAction:0);
	in6 = PlayBuf.ar(1, ~r3.bufnum, BufRateScale.kr(~r3.bufnum), loop: 0, doneAction:0);

	chainx1 = FFT(LocalBuf(frames), in1);
	chainy1 = FFT(LocalBuf(frames), in2);
	chainx2 = FFT(LocalBuf(frames), in3);
	chainy2 = FFT(LocalBuf(frames), in4);
	chainx3 = FFT(LocalBuf(frames), in5);
	chainy3 = FFT(LocalBuf(frames), in6);

180.do{

		pos1=~posL1.[pl]/(2.sqrt);
		pos2=~posR1.[pl]/(2.sqrt);
		pos3=~posL2.[pl]/(2.sqrt);
		pos4=~posR2.[pl]/(2.sqrt);
		pos5=~posL3.[pl]/(2.sqrt);
		pos6=~posR3.[pl]/(2.sqrt);

		mg1=Complex(~magL1.[pl],~magR1.[pl]);
		mg2=Complex(~magL2.[pl],~magR2.[pl]);
		mg3=Complex(~magL3.[pl],~magR3.[pl]);

        ph1=exp(Complex(0,1)*(2pi*mg1.real).mod(2pi)).theta;
		ph2=exp(Complex(0,1)*(2pi*mg1.imag).mod(2pi)).theta;
		ph3=exp(Complex(0,1)*(2pi*mg2.real).mod(2pi)).theta;
		ph4=exp(Complex(0,1)*(2pi*mg2.imag).mod(2pi)).theta;
		ph5=exp(Complex(0,1)*(2pi*mg3.real).mod(2pi)).theta;
		ph6=exp(Complex(0,1)*(2pi*mg3.imag).mod(2pi)).theta;

chainxx1 = chainx1.pvcollect(frames, {|mag, phase, index| [mag*(mg1.rho/(2.sqrt)), exp(Complex(0,1)*(phase+ph1).mod(2pi)).theta]; }, frombin: b, tobin: b, zeroothers: 1);
chainyy1 = chainy1.pvcollect(frames, {|mag, phase, index| [mag*(mg1.rho/(2.sqrt)), exp(Complex(0,1)*(phase+ph2).mod(2pi)).theta]; }, frombin: b, tobin: b, zeroothers: 1);

chainxx2= chainx2.pvcollect(frames, {|mag, phase, index| [mag*(mg2.rho/(2.sqrt)), exp(Complex(0,1)*(phase+ph3).mod(2pi)).theta]; }, frombin: b, tobin: b, zeroothers: 1);
chainyy2 = chainy2.pvcollect(frames, {|mag, phase, index| [mag*(mg2.rho/(2.sqrt)), exp(Complex(0,1)*(phase+ph4).mod(2pi)).theta]; }, frombin: b, tobin: b, zeroothers: 1);

chainxx3 = chainx3.pvcollect(frames, {|mag, phase, index| [mag*(mg3.rho/(2.sqrt)), exp(Complex(0,1)*(phase+ph5).mod(2pi)).theta]; }, frombin: b, tobin: b, zeroothers: 1);
chainyy3 = chainy3.pvcollect(frames, {|mag, phase, index| [mag*(mg3.rho/(2.sqrt)), exp(Complex(0,1)*(phase+ph6).mod(2pi)).theta]; }, frombin: b, tobin: b, zeroothers: 1);


		signal1=Pan2.ar(IFFT(chainxx1),pos1);
		signal2=Pan2.ar(IFFT(chainyy1),pos2);
		signal3=Pan2.ar(IFFT(chainxx2),pos3);
		signal4=Pan2.ar(IFFT(chainyy2),pos4);
		signal5=Pan2.ar(IFFT(chainxx3),pos5);
		signal6=Pan2.ar(IFFT(chainyy3),pos6);
b=b+1;
pl=pl+1;
		Out.ar(0,signal1);
		Out.ar(0,signal2);
		Out.ar(0,signal3);
		Out.ar(0,signal4);
		Out.ar(0,signal5);
		Out.ar(0,signal6);

}
}).add;
)

Synth.new(\buf3d);
s.record
