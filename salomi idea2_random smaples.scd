(
s.options.numBuffers=1024*2;
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=0;
s.options.memSize = 8192*32;
s.options.blockSize = 64;
s.options.maxNodes = 1024 * 16;
s.options.sampleRate= 44100;
s.waitForBoot;
)

Buffer.freeAll;

(
~c1 = Buffer.readChannel(s,,channels:0);~c2 = Buffer.readChannel(s,,channels:0);
~c3 = Buffer.readChannel(s,,channels:0);~c4 = Buffer.readChannel(s,,channels:0);
~c5 = Buffer.readChannel(s,,channels:0);~c6 = Buffer.readChannel(s,,channels:0);
~c7 = Buffer.readChannel(s,,channels:0);~c8 = Buffer.readChannel(s,,channels:0);
~c9 = Buffer.readChannel(s,,channels:0);~c10 = Buffer.readChannel(s,,channels:0);

~c11 = Buffer.readChannel(s,,channels:0);~c12 = Buffer.readChannel(s,,channels:0);
~c13 = Buffer.readChannel(s,,channels:0);~c14 = Buffer.readChannel(s,,channels:0);
~c15 = Buffer.readChannel(s,,channels:0);~c16 = Buffer.readChannel(s,,channels:0);
~c17 = Buffer.readChannel(s,,channels:0);~c18 = Buffer.readChannel(s,,channels:0);
~c19 = Buffer.readChannel(s,,channels:0);~c20 = Buffer.readChannel(s,,channels:0);
)



(
~synth=(
SynthDef.new(\ospace1, {
	arg buffer=0,gain=1;
	var sig,env;

			env= EnvGen.ar(Env.sine(10),doneAction:2);

			sig=PlayBuf.ar(1, buffer.bufnum, BufRateScale.kr(buffer.bufnum),startPos:0, loop: 0, doneAction:2)*env;

			Out.ar(0,sig);
			Out.ar(1,sig*gain);


}).add;
);
)

////////////list
	({
		var n=1.neg;
		~list=(100).collect{
		n=n+1;
		}
		}.value
	);

~l=~list.scramble;
~l=[~c1,~c2,~c3,~c4,~c5,~c6,~c7,~c8,~c9,~c10,~c11,~c12,~c13,~c14,~c15,~c16,~c17,~c18,~c19,~20].scramble
//////////pattern for mobius strib of sequential or parallel play of directions
	(

~a=Pdef(\1, Pbind(\instrument, \rand,
		\dur,Pseq(~l.bumFrames/44100),
		\buffer,Pseq(~l,inf)
));

TempoClock.default.tempo_(1/1);

~aa.play;

	(
MIDIClient.init;
MIDIIn.connectAll;

		(
MIDIdef.cc(\midi2,{ |val, num, chan, src|
		var band;
	//[val, num, chan, src].postln;
		band=val.linlin(0,127,0,1);
		band.postln;
		if(~synth.isPlaying,{~synth.set(\gain,band)});
},25);
	);
	)