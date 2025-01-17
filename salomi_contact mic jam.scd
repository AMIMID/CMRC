(
s.options.numBuffers=1024*2;
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=2;
s.options.memSize = 8192*128*2;
s.options.blockSize = 64;
s.options.maxNodes = 1024 * 16;
s.options.sampleRate= 44100;
s.options.maxSynthDefs=1024*8;
s.waitForBoot;
)


(
s.options.numBuffers=1024*2;
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=2;
s.options.memSize = 8192*128*2;
s.options.blockSize = 64;
s.options.maxNodes = 1024 * 16;
s.options.sampleRate= 44100;
s.options.maxSynthDefs=1024*8;
s.waitForBoot;
)

////////////////buffers
Buffer.freeAll
(
(
~c1 = Buffer.readChannel(s,,channels:0 );
~c2 = Buffer.readChannel(s,,channels:1 );
~c3 = Buffer.readChannel(s,,channels:2 );
~c4 = Buffer.readChannel(s,,channels:3 );
~c5 = Buffer.readChannel(s,,channels:4 );
~c6 = Buffer.readChannel(s,,channels:5 );
);
)
~c1 = Buffer.read(s,"/Users/petrostatsiopoulos/Dokuments/EXTERNAL/music/piece of my heart Intermission.wav");

~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/PROJECT  FILES/uni/ksyme:cmrc/askhsh3/5_fft alteration,octaves,reverb.wav",channels:0 );

~c1.numFrames/512


(~c1.numFrames/512)*i
(
512.do{
	|i|
(
		SynthDef.new(\obin_++i, {

    var b=1.neg;
    var in1,chainx,chainy;
	var chainxx,chainyy;
	var bank,frames=1024;
	var samplerate=44100;
	var env,k;

	in1 = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1.bufnum),startPos:(~c1.numFrames/512)*i, loop: 0, doneAction:2);


			chainx = SoundIn.ar(0);

			b=511.xrand(b).postln;

chainxx = chainx.pvcollect(frames, {|magnitude, phase, bin|
		[magnitude,phase]

}, frombin: b, tobin: b, zeroothers: 1);


		Out.ar(0,IFFT(chainxx)*1);
			chainx.clear;

}).add;
);
}
)


Synth(\obin_++(511.rand))

Synth(\obin_10)

(var b=1.neg; 512.do{ b=511.xrand(b); Synth(\obin_++b)})

512.do{|i| Synth(\obin_++i);}

~dur=((~c1.numFrames/512)/44100)

(~c1.numFrames/512)*8



r=Routine{var b=1.neg; 512.do{ b=511.xrand(b);  Synth(\obin_++b).postln; (~dur).wait;}}
r.play
////////////////////////////////


~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/PROJECT  FILES/recordings/27 Δεκ, 22.08​.wav",channels:0 );

~dur=((~c1.numFrames/512)/44100)
~duration=(~c1.numFrames/44100)

({
		var n=0;
	~list=(512).collect{
		n=n+~dur;
		}
		}.value
	)

({
		var n=1.neg;
	~k=(512).collect{
		n=n+1;
		}
		}.value
	)

(
Synth(\bin);
s.record
)

(
SynthDef.new(\bin,{

	 var b=1.neg;
    var in1,chainx,chainy;
	var chainxx,chainyy;
	var bank,frames=1024;
	var samplerate=44100;
	var env,dur;
	var m=1,x=1,n=0;

		in1 = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1.bufnum),startPos:0, loop: 0, doneAction:2);
		chainx = FFT(LocalBuf(frames), in1);
	chainy = FFT(LocalBuf(frames), in1);

	k=Pxrand(~k,512).asStream;
	512.do{

m=(x+1)/x;
dur=~list.[n];

x=x+1;
n=n+1;
		//env=EnvGen.ar(Env.new([1,1,0],[dur,0.01],\sine));
		///further modulations for presence of indivual bins can be achieved through further variations of the envelope
		//env=EnvGen.ar(Env.new([0,1,1,0],[dur/1,((~duration-(dur/1))/2),(~duration-((~duration-(dur/1))/2))],\sine));
			env=EnvGen.ar(Env.new([0,0,1,1,0,0],[dur/1,0.01,((~duration-(dur/1))/2),0.01,(~duration-((~duration-(dur/1))/2))],\sine));

b=k.next.postln;
			//b=511.xrand(b).postln;

chainxx = chainx.pvcollect(frames, {|magnitude, phase, bin|
		[magnitude*env,phase]

}, frombin: b, tobin: b, zeroothers: 1);

chainyy = chainx.pvcollect(frames, {|magnitude, phase, bin|

		[magnitude*env,phase+90.degrad]

}, frombin: b, tobin: b, zeroothers: 1);

		Out.ar(0,IFFT(chainxx)*0.5);
		Out.ar(1,IFFT(chainyy)*0.5);

};

}).add;

)
///////////////////

({
		var n=1.neg;
	~k=(512).collect{
		n=n+1;
		}
		}.value
	)


(
~b=Pxrand(~k,512).asStream;
512.do{
	|i|
(
		SynthDef.new(\obin_++i, {

    var b=1.neg;
    var in1,chainx,chainy;
	var chainxx,chainyy;
	var bank,frames=1024;
	var samplerate=44100;
	var env;

			in1 = SoundIn.ar(0);


	chainx = FFT(LocalBuf(frames), in1);
	chainy = FFT(LocalBuf(frames), in1);
			b=~b.next.postln;

chainxx = chainx.pvcollect(frames, {|magnitude, phase, bin|
		[magnitude,phase]

}, frombin: b, tobin: b, zeroothers: 1);

chainyy = chainx.pvcollect(frames, {|magnitude, phase, bin|

		[magnitude,phase+90.degrad]

}, frombin: b, tobin: b, zeroothers: 1);

		Out.ar(0,IFFT(chainxx)*1);
		Out.ar(1,IFFT(chainyy)*1);
			chainx.clear;
			chainy.clear;

}).add;
);
}
)


Synth(\obin_++(511.rand))