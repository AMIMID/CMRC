(
s.options.numBuffers=1024*2;
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=2;
s.options.memSize = 8192*128*2;
s.options.blockSize = 64;
s.options.maxNodes = 1024 * 16;
s.options.sampleRate= 48000;
s.options.maxSynthDefs=1024*8;
s.waitForBoot;
)


///////////////////
(
~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/Alkistis/Sakeliariou.wav",channels:0);
(
({
		var n=1.neg;
	~k=(512).collect{
		n=n+1;
		}
		}.value
	);

~seed = 12345.rand;
);
(
//~d=Pxrand(~k,256).asStream;
//thisThread.randSeed = ~seed;
~d=~k.scramble;
512.do{
	|i|
(
		SynthDef.new(\obin_++i, {
    var b;
    var in1,in2,chainx,chainy;
	var chainxx,chainyy,chainn;
	var bank,frames=1024;
	var samplerate=44100;
	var env;

			in1 = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1.bufnum),startPos:0, loop: 1, doneAction:2);

//env=EnvGen.ar(Env([4,4,0],[32,6]),doneAction:2);
	chainx = FFT(LocalBuf(frames), in1);
			b=~d.[i].postln;
			//b=~k.[i].postln;

chainxx = chainx.pvcollect(frames, {|magnitude, phase, bin|
		[magnitude,phase]

}, frombin: b, tobin: b, zeroothers: 1);

chainyy = chainx.pvcollect(frames, {|magnitude, phase, bin|
		[magnitude,phase]

}, frombin: b, tobin: b, zeroothers: 1);

chainn=PV_PhaseShift(chainyy, 90.degrad);


		Out.ar(0,IFFT(chainxx));
		Out.ar(1,IFFT(chainn));
			chainx.clear;

}).add;
);
}
);


(
~m=Pseq(~k,1).asStream;
~f=Pseq(~k,1).asStream;
//s.record(numChannels:4);

~synths = [];
x = 512.do{
    var newSynth;
    newSynth =Synth(\obin_++(~m.next)); // Create a new Synth
    ~synths = ~synths.add(newSynth); // Add it to the array
    newSynth.postln; // Print the Synth to confirm
};
)
)


//{SinOsc.ar(220)!2}.play

x.value;

~synths.[~f.next].free



