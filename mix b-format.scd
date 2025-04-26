(
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(1);
s.options.memSize = 8192*128*2;
s.options.blockSize = 64*4;
s.options.maxNodes = 1024 * 16;
s.options.sampleRate= 44100;
)
(
~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/PROJECT  FILES/uni/ksyme:cmrc/final/bees war and tv-sets/0.wav",channels:0 );//flu
~c2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/PROJECT  FILES/uni/ksyme:cmrc/final/bees war and tv-sets/0.wav",channels:1 );//bru
~c3 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/PROJECT  FILES/uni/ksyme:cmrc/final/bees war and tv-sets/0.wav",channels:2 );//bld
~c4 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/PROJECT  FILES/uni/ksyme:cmrc/final/bees war and tv-sets/0.wav",channels:3 );//frd
)
///w=flu+frd+bld+bru
//x=flu+frd-bld-bru
//y=flu-frd+bld-bru
//z=flu-frd-bld+bru


(
{Out.ar(0,
	PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0,doneAction:2)+
	PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2), loop: 0,doneAction:2)+
	PlayBuf.ar(1, ~c3.bufnum, BufRateScale.kr(~c3), loop: 0,doneAction:2)+
	PlayBuf.ar(1, ~c4.bufnum, BufRateScale.kr(~c4), loop: 0,doneAction:2))}.play;

{Out.ar(1,
	PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0,doneAction:2)-
	PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2), loop: 0,doneAction:2)-
	PlayBuf.ar(1, ~c3.bufnum, BufRateScale.kr(~c3), loop: 0,doneAction:2)+
	PlayBuf.ar(1, ~c4.bufnum, BufRateScale.kr(~c4), loop: 0,doneAction:2))}.play;

{Out.ar(2,
	PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0,doneAction:2)-
	PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2), loop: 0,doneAction:2)+
	PlayBuf.ar(1, ~c3.bufnum, BufRateScale.kr(~c3), loop: 0,doneAction:2)-
	PlayBuf.ar(1, ~c4.bufnum, BufRateScale.kr(~c4), loop: 0,doneAction:2))}.play;

{Out.ar(3,
	 PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0,doneAction:2)+
	PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2), loop: 0,doneAction:2)-
	PlayBuf.ar(1, ~c3.bufnum, BufRateScale.kr(~c3), loop: 0,doneAction:2)-
	PlayBuf.ar(1, ~c4.bufnum, BufRateScale.kr(~c4), loop: 0,doneAction:2))}.play;
);


s.record(numChannels:4);