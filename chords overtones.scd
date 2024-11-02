(
~c1 = Buffer.read(s,"/Users/petrostatsiopoulos/Desktop/PROJECT  FILES/uni/ksyme/askhsh1/askhsh_1_h_supercollider edit_audacity edit.wav");
)


(
{PitchShift.ar(PlayBuf.ar(2, ~c1.bufnum, BufRateScale.kr(~c1.bufnum), loop: 0, doneAction:2),pitchRatio:1,mul:1/1)}.play;
	{PitchShift.ar(PlayBuf.ar(2, ~c1.bufnum, BufRateScale.kr(~c1.bufnum), loop: 0, doneAction:2),pitchRatio:1/2,mul:2/1)}.play;
		{PitchShift.ar(PlayBuf.ar(2, ~c1.bufnum, BufRateScale.kr(~c1.bufnum), loop: 0, doneAction:2),pitchRatio:2/3,mul:3/2)}.play;
			{PitchShift.ar(PlayBuf.ar(2, ~c1.bufnum, BufRateScale.kr(~c1.bufnum), loop: 0, doneAction:2),pitchRatio:3/4,mul:4/3)}.play;
			)