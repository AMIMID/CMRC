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

~c1 = Buffer.readChannel(s,,channels:0 );

~dur=~c1.numFrames/512

///////////////////

({
		var n=1.neg;
	~k=(256).collect{
		n=n+1;
		}
		}.value
	)

~seed = 12345.rand;

(
//~d=Pxrand(~k,512).asStream;
thisThread.randSeed = ~seed;~d=~k.scramble;
512.do{
	|i|
(
		SynthDef.new(\obin_++i, {
arg duration=~dur
    var b=1.neg;
    var in1,chainx,chainy;
	var chainxx,chainyy;
	var bank,frames=1024;
	var samplerate=44100;
	var env;

			in1 = SoundIn.ar(0);

nv=EnvGen.ar(Env([0,1,1,0],[0,duration,0]));
	chainx = FFT(LocalBuf(frames), in1);
	chainy = FFT(LocalBuf(frames), in1);
			b=~b.next.postln;

chainxx = chainx.pvcollect(frames, {|magnitude, phase, bin|
		[magnitude,phase]

}, frombin: b, tobin: b, zeroothers: 1);

chainyy = chainx.pvcollect(frames, {|magnitude, phase, bin|

		[magnitude,phase+90.degrad]

}, frombin: b, tobin: b, zeroothers: 1);

		Out.ar(0,IFFT(chainxx)*env);
		Out.ar(1,IFFT(chainyy)*env);
			chainx.clear;
			chainy.clear;

}).add;
);
}
)


~m=Pseq(~k,512).asStream;
Synth(\obin_++(~m.next),[\duration,~dur])
