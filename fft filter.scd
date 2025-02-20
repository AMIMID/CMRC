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
Buffer.freeAll
(
~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Dokuments/EXTERNAL/music/band album library/Blazon Stone/Return To Port Royal - Definitive Edition/01 Black Chest In (Intro).wav",channels:0);
~c2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Dokuments/EXTERNAL/music/band album library/Blazon Stone/Return To Port Royal - Definitive Edition/01 Black Chest In (Intro).wav",channels:1);
)
///////////////////
(
(
({
		var n=1.0.neg;
	~k=(1024).collect{
		n=n+1;
		}
		}.value
	);

~seed = 12345.rand;
);
(
//~d=Pxrand(~k,256).asStream;
thisThread.randSeed = ~seed;~d=~k.scramble;
1024.do{
	|i|
(
		SynthDef.new(\obin_++(i+0.0), {
    var b;
    var in1,in2,chainx,chainy;
	var chainxx,chainyy;
	var bank,frames=1024*2;
	var samplerate=44100;
	var env;

			in1 = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1.bufnum), loop: 0, doneAction:2);
			in2 = PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2.bufnum), loop: 0, doneAction:2);

	chainx = FFT(LocalBuf(frames), in1);
	chainy = FFT(LocalBuf(frames), in2);
		//	b=~d.[i].postln;
			b=~k.[i].postln;

chainxx = chainx.pvcollect(frames, {|magnitude, phase, bin|
		[magnitude,phase]

}, frombin: b, tobin: b, zeroothers: 1);
chainyy = chainy.pvcollect(frames, {|magnitude, phase, bin|
		[magnitude,phase]

}, frombin: b, tobin: b, zeroothers: 1);

		Out.ar(0,IFFT(chainxx));
			Out.ar(1,IFFT(chainyy));
			chainx.clear;
			chainy.clear;

}).add;
);
}
);
(

~synths = [];
x = {
    var newSynth,num=0;
	newSynth =Synth(\obin_++~k.[num]); // Create a new Synth
    ~synths = ~synths.add(newSynth); // Add it to the array
    newSynth.postln; // Print the Synth to confirm
	num=num+1
};
);
)
~f=Pseq(~k,1).asStream;


//{SinOsc.ar(220)!2}.play

x.value;

~synths.[~f.next].free


(
w.close;
w=Window.new("gui",Rect.new(750,100,300,400)).front.alwaysOnTop_(true);


~filter1 = Slider.new(w.view,Rect.new(20,100,30,250));

(
~filter1.action_({
	arg obj;
	var pass;
	pass=obj.value.linlin(0,1,0,1024).round(1);
	["pass"].postln;
	pass=pass.round(1);
	pass.value.postln;
	Synth(\obin_++pass);
});

)

)



