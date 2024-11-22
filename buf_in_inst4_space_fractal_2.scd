(
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=6;
s.options.numInputBusChannels=2;
TempoClock.default.tempo_(1);
s.options.memSize = 8192*64;
s.options.blockSize = 64;
s.options.maxNodes = 1024 * 16;
s.options.sampleRate= 48000;
s.waitForBoot
)

Buffer.freeAll


//////////phase shift
~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/PROJECT  FILES/recordings/freesound_org recordings/692905__klankbeeld__summer-field-forest-nl-11.wav",channels:0 );
(
(
SynthDef("help-phaseShift", { arg out=0;
        var in, chain;
        in = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0);
        chain = FFT(LocalBuf(2048), in);
        chain = PV_PhaseShift(chain,90.degrad);
        Out.ar(out, 0.1 * IFFT(chain));
}).play(s);
);
)


////////////////buffers
Buffer.freeAll
(
(
~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/PROJECT  FILES/recordings/freesound_org recordings/692905__klankbeeld__summer-field-forest-nl-11.wav",channels:0 );
~c2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/PROJECT  FILES/recordings/freesound_org recordings/692905__klankbeeld__summer-field-forest-nl-11.wav",channels:1 );
//~c3 = Buffer.readChannel(s,,channels:0 );
//~c4 = Buffer.readChannel(s,,channels:1 );
//~c5 = Buffer.readChannel(s,,channels:0 );
//~c6 = Buffer.readChannel(s,,channels:1 );
);

/////wavetables

~t= Buffer.alloc(s,2048);


{
var signal,wt,m=0,amp;

~level=90.round(1).collect{m=m+1;amp=m.reciprocal};
~phase=90.collect{pi};
signal=Signal.sineFill(1024,~level,~phase);

wt = signal.asWavetable;
~t.loadCollection(wt);
signal.plot;
}.value;
)

////speaker setup
(
// 3D///cube
~a = VBAPSpeakerArray.new(3, [[45, 45], [135, 45], [135.neg, 45], [45.neg, 45],[45, 45.neg], [135, 45.neg], [135.neg, 45.neg], [45.neg, 45.neg]]);
//0 up fl, 1 up bl, 2 up br, 3 up fr, 4 down fl, 5 down bl, 6 down br, 7 down fr
~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
///furhter on speaker setup can be geodesic octahedron 2nd order torus with 16 channels, and Rhombic triacontahedron with 32 vertices as 32 speaker channels
)
/////octahedron
(
	~a = VBAPSpeakerArray.new(3, [[0, 0], [90, 0], [180, 0], [90.neg, 0],[0,90],[0,90.neg]]);
	~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
)

(
// 3D random
~a = VBAPSpeakerArray.new(3, [[180.rand2, 90.rand2], [180.rand2, 90.rand2], [180.rand2, 90.rand2], [180.rand2, 90.rand2]]);
~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
)

//////////arrays
(
/////////tetrahedron
/*(
// 3D
~a = VBAPSpeakerArray.new(3, [[0, 45], [180, 45], [90, 45.neg], [90.neg, 45.neg]]);
~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
);*/
		~time=8;
{
var c,cc,angle=0,c_real,c_imag,z;
var c1,cc1,angle1=0,c_real1,c_imag1,z1;

~c = 5.collect{
 	c_real=exp(Complex(0,1)*angle.degrad).real;
	c_imag=exp(Complex(0,1)*angle.degrad).imag;
 	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
 	c=Complex(c_real,c_imag);
 };
z=Complex(0,0);

~j = (2*720*~time).collect{
	cc=~c.[4];
	z=z.pow(2)+cc;
	z.theta.round(0.0000000000001);

};

~k = 5.collect{
 	c_real1=exp(Complex(0,1)*angle1.degrad).real;
	c_imag1=exp(Complex(0,1)*angle1.degrad).imag;
 	angle1=(angle1+45).wrap(0,360);
 	c1=Complex(c_real,c_imag);
 };
z1=Complex(0,0);

~h = (2*720*~time).collect{
	cc1=~k.[4].round(0.0000000000001);
	z1=z1.pow(2)+cc1;
	z1.theta.round(0.0000000000001);

}

		}.value;
//////////////////////////////////////////////////basis
{
var  sph1,sph2,sph3,sph4,sph5,m_x=3,m_y=2,m_z=3;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;

~az = (720*~time).collect{
	pl1=pl1+1;

		az1=(az1+(1)).wrap(180.neg,180);

	el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sph1=Spherical(1,(az1.degrad*~h.[pl1]).wrap(pi.neg,pi),(el1.degrad*~j.[pl1]).wrap((pi/2).neg,(pi/2))).theta.round(0.00001);

	};

~el = (720*~time).collect{
	pl2=pl2+1;

		az2=(az2+(1)).wrap(180.neg,180);

	el2=(el2+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph2=Spherical(1,(az2.degrad*~h.[pl2]).wrap(pi.neg,pi),(el2.degrad*~j.[pl2]).wrap((pi/2).neg,(pi/2))).phi.round(0.00001);

	};

~magx = (720*~time).collect{
pl3=pl3+1;
	az3=(az3+(1)).wrap(180.neg,180);

	el3=(el3+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph3=Spherical(1,(az3.degrad*~h.[pl3]).wrap(pi.neg,pi),(el3.degrad*~j.[pl3]).wrap((pi/2).neg,(pi/2)));

			//mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis

		 mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
		 	cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		 	Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/
			2).neg,(pi/2)))).rho*
		 Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

};

~magy = (720*~time).collect{
pl4=pl4+1;
	az4=(az4+(1)).wrap(180.neg,180);

	el4=(el4+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph4=Spherical(1,(az3.degrad*~h.[pl3]).wrap(pi.neg,pi),(el4.degrad*~j.[pl4]).wrap((pi/2).neg,(pi/2)));

	mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),
		sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/
		2)))).rho)*sph4.rho;
//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
};

~magz = (720*~time).collect{
pl5=pl5+1;
	az5=(az5+(1)).wrap(180.neg,180);

	el5=(el5+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sph5=Spherical(1,((az5.degrad*~h.[pl5]).wrap(pi.neg,pi)).wrap(pi.neg,pi),((el5.degrad*~j.[pl5]).wrap((pi/2).neg,(pi/2))).wrap((pi/2).neg,(pi/2)));

if(
m_z.even,
mag_z=Complex(cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho,
mag_z=Complex(sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho
	);
////z axis   ambi..  sin for odd numbers, cos for even
	};
}.value;

{
var  sph1,sph2,sph3,sph4,sph5,m_x=2,m_y=2,m_z=2;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;

		~magx1 = (720*~time).collect{
pl3=pl3+1;
	az3=(az3+(1)).wrap(180.neg,180);

	el3=(el3+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph3=Spherical(1,(az3.degrad*~h.[pl3]).wrap(pi.neg,pi),(el3.degrad*~j.[pl3]).wrap((pi/2).neg,(pi/2)));
	 mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis

		// mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
		// 	cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		// 	Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/
		// 	2).neg,(pi/2)))).rho*
		// Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

};
~magy1 = (720*~time).collect{
pl4=pl4+1;
	az4=(az4+(1)).wrap(180.neg,180);

	el4=(el4+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph4=Spherical(1,(az4.degrad*~h.[pl4]).wrap(pi.neg,pi),(el4.degrad*~j.[pl4]).wrap((pi/2).neg,(pi/2)));

	mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),
		sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/
		2)))).rho)*sph4.rho;
//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
};

~magz1 = (720*~time).collect{
pl5=pl5+1;
	az5=(az5+(1)).wrap(180.neg,180);

	el5=(el5+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph5=Spherical(1,(az5.degrad*~h.[pl5]).wrap(pi.neg,pi),(el5.degrad*~j.[pl5]).wrap((pi/2).neg,(pi/2)));

if(
m_z.even,
mag_z=Complex(cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho,
mag_z=Complex(sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho
	);
////z axis   ambi..  sin for odd numbers, cos for even
	};
}.value;

{
var  sph1,sph2,sph3,sph4,sph5,m_x=2,m_y=2,m_z=2;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;

~magx2 = (720*~time).collect{
pl3=pl3+1;
	az3=(az3+(1)).wrap(180.neg,180);

	el3=(el3+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph3=Spherical(1,(az3.degrad*~h.[pl3]).wrap(pi.neg,pi),(el3.degrad*~j.[pl3]).wrap((pi/2).neg,(pi/2)));
	 mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis

		// mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
		// 	cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		// 	Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/
		// 	2).neg,(pi/2)))).rho*
		// Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

};

~magy2 = (720*~time).collect{
pl4=pl4+1;
	az4=(az4+(1)).wrap(180.neg,180);

	el4=(el4+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph4=Spherical(1,(az4.degrad*~h.[pl4]).wrap(pi.neg,pi),(el4.degrad*~j.[pl4]).wrap((pi/2).neg,(pi/2)));

	mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),
		sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/
		2)))).rho)*sph4.rho;
//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
};

~magz2 = (720*~time).collect{
pl5=pl5+1;
	az5=(az5+(1)).wrap(180.neg,180);

	el5=(el5+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph5=Spherical(1,(az5.degrad*~h.[pl5]).wrap(pi.neg,pi),(el5.degrad*~j.[pl5]).wrap((pi/2).neg,(pi/2)));

if(
m_z.even,
mag_z=Complex(cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho,
mag_z=Complex(sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho
	);
////z axis   ambi..  sin for odd numbers, cos for even
	};
}.value;

{
var  sph1,sph2,sph3,sph4,sph5,m_x=3,m_y=3,m_z=3;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;

~magx3 = (720*~time).collect{
pl3=pl3+1;
	az3=(az3+(1)).wrap(180.neg,180);

	el3=(el3+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph3=Spherical(1,(az3.degrad*~h.[pl3]).wrap(pi.neg,pi),(el3.degrad*~j.[pl3]).wrap((pi/2).neg,(pi/2)));
	 mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis

		// mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
		// 	cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		// 	Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/
		// 	2).neg,(pi/2)))).rho*
		// Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

};

~magy3 = (720*~time).collect{
pl4=pl4+1;
	az4=(az4+(1)).wrap(180.neg,180);

	el4=(el4+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph4=Spherical(1,(az4.degrad*~h.[pl4]).wrap(pi.neg,pi),(el4.degrad*~j.[pl4]).wrap((pi/2).neg,(pi/2)));

	mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),
		sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/
		2)))).rho)*sph4.rho;
//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
};

~magz3 = (720*~time).collect{
pl5=pl5+1;
	az5=(az5+(1)).wrap(180.neg,180);

	el5=(el5+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph5=Spherical(1,(az5.degrad*~h.[pl5]).wrap(pi.neg,pi),(el5.degrad*~j.[pl5]).wrap((pi/2).neg,(pi/2)));

if(
m_z.even,
mag_z=Complex(cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho,
mag_z=Complex(sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho
	);
////z axis   ambi..  sin for odd numbers, cos for even
	};
}.value;

{
var  sph1,sph2,sph3,sph4,sph5,m_x=4,m_y=4,m_z=4;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;

~magx4 = (720*~time).collect{
pl3=pl3+1;
	az3=(az3+(1)).wrap(180.neg,180);

	el3=(el3+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph3=Spherical(1,(az3.degrad*~h.[pl3]).wrap(pi.neg,pi),(el3.degrad*~j.[pl3]).wrap((pi/2).neg,(pi/2)));
	 mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis

		// mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
		// 	cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		// 	Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/
		// 	2).neg,(pi/2)))).rho*
		// Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

};

~magy4 = (720*~time).collect{
pl4=pl4+1;
	az4=(az4+(1)).wrap(180.neg,180);

	el4=(el4+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph4=Spherical(1,(az4.degrad*~h.[pl4]).wrap(pi.neg,pi),(el4.degrad*~j.[pl4]).wrap((pi/2).neg,(pi/2)));

	mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),
		sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/
		2)))).rho)*sph4.rho;
//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
};

~magz4 = (720*~time).collect{
pl5=pl5+1;
	az5=(az5+(1)).wrap(180.neg,180);

	el5=(el5+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph5=Spherical(1,(az5.degrad*~h.[pl5]).wrap(pi.neg,pi),(el5.degrad*~j.[pl5]).wrap((pi/2).neg,(pi/2)));

if(
m_z.even,
mag_z=Complex(cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho,
mag_z=Complex(sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho
	);
////z axis   ambi..  sin for odd numbers, cos for even
	};
}.value;

{
var  sph1,sph2,sph3,sph4,sph5,m_x=5,m_y=5,m_z=5;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;

~magx5 = (720*~time).collect{
pl3=pl3+1;
	az3=(az3+(1)).wrap(180.neg,180);

	el3=(el3+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph3=Spherical(1,(az3.degrad*~h.[pl3]).wrap(pi.neg,pi),(el3.degrad*~j.[pl3]).wrap((pi/2).neg,(pi/2)));
	 mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis

		// mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
		// 	cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		// 	Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/
		// 	2).neg,(pi/2)))).rho*
		// Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

};

~magy5 = (720*~time).collect{
pl4=pl4+1;
	az4=(az4+(1)).wrap(180.neg,180);

	el4=(el4+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph4=Spherical(1,(az4.degrad*~h.[pl4]).wrap(pi.neg,pi),(el4.degrad*~j.[pl4]).wrap((pi/2).neg,(pi/2)));

	mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),
		sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/
		2)))).rho)*sph4.rho;
//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
};

~magz5 = (720*~time).collect{
pl5=pl5+1;
	az5=(az5+(1)).wrap(180.neg,180);

	el5=(el5+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph5=Spherical(1,(az5.degrad*~h.[pl5]).wrap(pi.neg,pi),(el5.degrad*~j.[pl5]).wrap((pi/2).neg,(pi/2)));

if(
m_z.even,
mag_z=Complex(cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho,
mag_z=Complex(sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho
	);
////z axis   ambi..  sin for odd numbers, cos for even
	};
}.value;

{
var  sph1,sph2,sph3,sph4,sph5,m_x=6,m_y=6,m_z=6;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;

~magx6 = (720*~time).collect{
pl3=pl3+1;
	az3=(az3+(1)).wrap(180.neg,180);

	el3=(el3+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph3=Spherical(1,(az3.degrad*~h.[pl3]).wrap(pi.neg,pi),(el3.degrad*~j.[pl3]).wrap((pi/2).neg,(pi/2)));
	 mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis

		// mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
		// 	cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		// 	Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/
		// 	2).neg,(pi/2)))).rho*
		// Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

};

~magy6 = (720*~time).collect{
pl4=pl4+1;
	az4=(az4+(1)).wrap(180.neg,180);

	el4=(el4+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph4=Spherical(1,(az4.degrad*~h.[pl4]).wrap(pi.neg,pi),(el4.degrad*~j.[pl4]).wrap((pi/2).neg,(pi/2)));

	mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),
		sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/
		2)))).rho)*sph4.rho;
//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
};

~magz6 = (720*~time).collect{
pl5=pl5+1;
	az5=(az5+(1)).wrap(180.neg,180);

	el5=(el5+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph5=Spherical(1,(az5.degrad*~h.[pl5]).wrap(pi.neg,pi),(el5.degrad*~j.[pl5]).wrap((pi/2).neg,(pi/2)));

if(
m_z.even,
mag_z=Complex(cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho,
mag_z=Complex(sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho
	);
////z axis   ambi..  sin for odd numbers, cos for even
	};
}.value;
///////////////////////////////////////az///randomizer-difuser

{
var pl1=0,az1,el1,sph1,rot1,i1,j1,k1,q1,raz1,rel1;
var pl2=0,az2,el2,sph2,rot2,i2,j2,k2,q2,raz2,rel2;
var pl3=0,az3,el3,sph3,rot3,i3,j3,k3,q3,raz3,rel3;
var r1=[0,0,1],r2=[1,0,0],r3=[0,1,0];
var v1=Quaternion(0,r1.[0],r1.[1],r1.[2]),v2=Quaternion(0,r2.[0],r2.[1],r2.[2]),v3=Quaternion(0,r3.[0],r3.[1],r3.[2]);
var angle=(360-(360/1.6180339887499));
var harm1,harn2,harm3;

~az_x=(720*~time).collect{

	az1=~az.[pl1];el1=~el.[pl1];
	pl1=pl1+1;
sph1=Spherical(1,az1,el1).asCartesian;

	rot1=[sph1.x,sph1.y,sph1.z];

	i1=Quaternion(0, rot1.[0], 0, 0);
	j1=Quaternion(0, 0, rot1.[1], 0);
	k1=Quaternion(0, 0, 0, rot1.[2]);

		q1=(exp(Complex(0,1)*(angle.degrad)).real+(exp(Complex(0,1)*(angle.degrad)).imag*(i1+j1+k1)));
v1=q1*v1*q1.conjugate;

raz1=Cartesian(v1.b.round(0.0001),v1.c.round(0.0001),v1.d.round(0.0001)).theta.round(0.0000000000001);
};

~az_y=(720*~time).collect{

	az2=~az.[pl2];el2=~el.[pl2];
	pl2=pl2+1;
sph2=Spherical(1,az2,el2).asCartesian;

	rot2=[sph2.x,sph2.y,sph2.z];

	i2=Quaternion(0, rot2.[0], 0, 0);
	j2=Quaternion(0, 0, rot2.[1], 0);
	k2=Quaternion(0, 0, 0, rot2.[2]);

q2=(exp(Complex(0,1)*(angle.degrad)).real+(exp(Complex(0,1)*(angle.degrad)).imag*(i1+j1+k1)));
v2=q2*v2*q2.conjugate;

raz2=Cartesian(v2.b.round(0.0001),v2.c.round(0.0001),v2.d.round(0.0001)).theta.round(0.0000000000001);
};

~az_z=(720*~time).collect{

	az3=~az.[pl3];el3=~el.[pl3];
	pl3=pl3+1;
sph3=Spherical(1,az3,el3).asCartesian;

	rot3=[sph3.x,sph3.y,sph3.z];

	i3=Quaternion(0, rot3.[0], 0, 0);
	j3=Quaternion(0, 0, rot3.[1], 0);
	k3=Quaternion(0, 0, 0, rot3.[2]);

q3=(exp(Complex(0,1)*(angle.degrad)).real+(exp(Complex(0,1)*(angle.degrad)).imag*(i1+j1+k1)));
v3=q3*v3*q3.conjugate;

raz3=Cartesian(v3.b.round(0.0001),v3.c.round(0.0001),v3.d.round(0.0001)).theta.round(0.0000000000001);
};

}.value;
///////////////////////el
{
var pl1=0,az1,el1,sph1,rot1,i1,j1,k1,q1,raz1,rel1;
var pl2=0,az2,el2,sph2,rot2,i2,j2,k2,q2,raz2,rel2;
var pl3=0,az3,el3,sph3,rot3,i3,j3,k3,q3,raz3,rel3;
var r1=[0,0,1],r2=[1,0,0],r3=[0,1,0];
var v1=Quaternion(0,r1.[0],r1.[1],r1.[2]),v2=Quaternion(0,r2.[0],r2.[1],r2.[2]),v3=Quaternion(0,r3.[0],r3.[1],r3.[2]);
var angle=(360-(360/1.6180339887499));

~el_x=(720*~time).collect{

	az1=~az.[pl1];el1=~el.[pl1];
	pl1=pl1+1;
sph1=Spherical(1,az1,el1).asCartesian;

	rot1=[sph1.x,sph1.y,sph1.z];

	i1=Quaternion(0, rot1.[0], 0, 0);
	j1=Quaternion(0, 0, rot1.[1], 0);
	k1=Quaternion(0, 0, 0, rot1.[2]);

q1=(exp(Complex(0,1)*(angle.degrad)).real+(exp(Complex(0,1)*(angle.degrad)).imag*(i1+j1+k1)));
v1=q1*v1*q1.conjugate;

rel1=Cartesian(v1.b.round(0.0001),v1.c.round(0.0001),v1.d.round(0.0001)).phi.round(0.0000000000001);
};

~el_y=(720*~time).collect{

	az2=~az.[pl2];el2=~el.[pl2];
	pl2=pl2+1;
sph2=Spherical(1,az2,el2).asCartesian;

	rot2=[sph2.x,sph2.y,sph2.z];

	i2=Quaternion(0, rot2.[0], 0, 0);
	j2=Quaternion(0, 0, rot2.[1], 0);
	k2=Quaternion(0, 0, 0, rot2.[2]);

q2=(exp(Complex(0,1)*(angle.degrad)).real+(exp(Complex(0,1)*(angle.degrad)).imag*(i1+j1+k1)));
v2=q2*v2*q2.conjugate;

rel2=Cartesian(v2.b.round(0.0001),v2.c.round(0.0001),v2.d.round(0.0001)).phi.round(0.0000000000001);
};

~el_z=(720*~time).collect{

	az3=~az.[pl3];el3=~el.[pl3];
	pl3=pl3+1;
sph3=Spherical(1,az3,el3).asCartesian;

	rot3=[sph3.x,sph3.y,sph3.z];

	i3=Quaternion(0, rot3.[0], 0, 0);
	j3=Quaternion(0, 0, rot3.[1], 0);
	k3=Quaternion(0, 0, 0, rot3.[2]);

q3=(exp(Complex(0,1)*(angle.degrad)).real+(exp(Complex(0,1)*(angle.degrad)).imag*(i1+j1+k1)));
v3=q3*v3*q3.conjugate;

rel3=Cartesian(v3.b.round(0.0001),v3.c.round(0.0001),v3.d.round(0.0001)).phi.round(0.0000000000001);
};

	}.value;
//////////////////////////////////////////////////space
(
~magx1=(~magx1/(2.sqrt)).round(0.0000000000001);
~magy1=(~magy1/(2.sqrt)).round(0.0000000000001);
~magz1=(~magz1/(2.sqrt)).round(0.0000000000001);
~magx2=(~magx2/(2.sqrt)).round(0.0000000000001);
~magy2=(~magy2/(2.sqrt)).round(0.0000000000001);
~magz2=(~magz2/(2.sqrt)).round(0.0000000000001);
~magx3=(~magx3/(2.sqrt)).round(0.0000000000001);
~magy3=(~magy3/(2.sqrt)).round(0.0000000000001);
~magz3=(~magz3/(2.sqrt)).round(0.0000000000001);
~magx4=(~magx4/(2.sqrt)).round(0.0000000000001);
~magy4=(~magy4/(2.sqrt)).round(0.0000000000001);
~magz4=(~magz4/(2.sqrt)).round(0.0000000000001);
~magx5=(~magx5/(2.sqrt)).round(0.0000000000001);
~magy5=(~magy5/(2.sqrt)).round(0.0000000000001);
~magz5=(~magz5/(2.sqrt)).round(0.0000000000001);
~magx6=(~magx6/(2.sqrt)).round(0.0000000000001);
~magy6=(~magy6/(2.sqrt)).round(0.0000000000001);
~magz6=(~magz6/(2.sqrt)).round(0.0000000000001);

~magx_array=[~magx1.round(0.00001),~magx2.round(0.00001),~magx3.round(0.00001),~magx4.round(0.00001),~magx5.round(0.00001)];
~magy_array=[~magy1.round(0.00001),~magy2.round(0.00001),~magy3.round(0.00001),~magy4.round(0.00001),~magy5.round(0.00001)];
~magz_array=[~magz1.round(0.00001),~magz2.round(0.00001),~magz3.round(0.00001),~magz4.round(0.00001),~magz5.round(0.00001)];
);
)

/*(
(
SynthDef.new(\o1, {
    var in1,in2, chainx,chainy,b=0,az1=0,az2=0,el1=0,el2=0,rpr=1;
	var chainxx,chainyy,pl1=0,pl2=0,pl=0,amp1,amp2,phase;
	var angle1=0,angle2=90;
	var phase1,phase2,bank1,bank2,frames=1024;

    in1 = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2), loop: 0, doneAction:2);

	chainx = FFT(LocalBuf(frames), in1);
	chainy = FFT(LocalBuf(frames), in2);

	bank1=3;
	bank2=90;

	bank1.do{

   bank2.do{

		az1=~az_x.[pl];
		el1=~el_x.[pl];
		az2=~az_x.reverse.[pl];
		el2=~el_x.reverse.[pl];
amp1=Cartesian(~magx_array.[pl2].[pl1],~magx_array.[pl2].[pl1],~magx_array.[pl2].[pl1]);
amp2=Cartesian(~magx_array.[pl2].reverse.[pl1],~magx_array.[pl2].reverse.[pl1],~magx_array.[pl2].reverse.[pl1]);

			phase1=exp(Complex(0,1)*(amp1.theta))*exp(Complex(0,1)*(amp1.phi));
		phase2=exp(Complex(0,1)*(amp2.theta))*exp(Complex(0,1)*(amp2.phi));

chainxx = chainx.pvcollect(frames, {|mag, phase, index| [mag*amp1.rho/(2.sqrt), exp(Complex(0,1)*(phase+phase1.theta)).theta]; }, frombin: b, tobin: b, zeroothers: 1);
chainyy = chainy.pvcollect(frames, {|mag, phase, index| [mag*amp2.rho/(2.sqrt), exp(Complex(0,1)*(phase+phase2.theta)).theta]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,
		Osc.ar(~t,rpr,phase:az1.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
			Osc.ar(~t,rpr,phase:el1.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));

		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,
		Osc.ar(~t,rpr,phase:az2.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
			Osc.ar(~t,rpr,phase:el2.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));
pl=pl+1;
	pl1=pl1+1;

		};
		pl2=pl2+1;
	};
}).add;
);
(
SynthDef.new(\o2, {
    var in1,in2, chainx,chainy,b=0,az1=0,az2=0,el1=0,el2=0,rpr=2/3;
	var chainxx,chainyy,pl1=0,pl2=0,pl=0,amp1,amp2,phase;
	var angle1=0,angle2=90;
	var phase1,phase2,bank1,bank2,frames=1024;

    in1 = PlayBuf.ar(1, ~c3.bufnum, BufRateScale.kr(~c3), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~c4.bufnum, BufRateScale.kr(~c4), loop: 0, doneAction:2);

	chainx = FFT(LocalBuf(frames), in1);
	chainy = FFT(LocalBuf(frames), in2);

	bank1=3;
	bank2=90;

	bank1.do{

   bank2.do{

		az1=~az_y.[pl];
		el1=~el_y.[pl];
		az2=~az_y.reverse.[pl];
		el2=~el_y.reverse.[pl];
amp1=Cartesian(~magx_array.[pl2].[pl1],~magx_array.[pl2].[pl1],~magx_array.[pl2].[pl1]);
amp2=Cartesian(~magx_array.[pl2].reverse.[pl1],~magx_array.[pl2].reverse.[pl1],~magx_array.[pl2].reverse.[pl1]);

			phase1=exp(Complex(0,1)*(amp1.theta))*exp(Complex(0,1)*(amp1.phi));
		phase2=exp(Complex(0,1)*(amp2.theta))*exp(Complex(0,1)*(amp2.phi));

chainxx = chainx.pvcollect(frames, {|mag, phase, index| [mag*amp1.rho/(2.sqrt), exp(Complex(0,1)*(phase+phase1.theta)).theta]; }, frombin: b, tobin: b, zeroothers: 1);
chainyy = chainy.pvcollect(frames, {|mag, phase, index| [mag*amp2.rho/(2.sqrt), exp(Complex(0,1)*(phase+phase2.theta)).theta]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,
		Osc.ar(~t,rpr,phase:az1.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
			Osc.ar(~t,rpr,phase:el1.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));

		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,
		Osc.ar(~t,rpr,phase:az2.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
			Osc.ar(~t,rpr,phase:el2.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));
pl=pl+1;
	pl1=pl1+1;

		};
		pl2=pl2+1;
	};
}).add;
);
(
SynthDef.new(\o3, {
    var in1,in2, chainx,chainy,b=0,az1=0,az2=0,el1=0,el2=0,rpr=1/2;
	var chainxx,chainyy,pl1=0,pl2=0,pl=0,amp1,amp2,phase;
	var angle1=0,angle2=90;
	var phase1,phase2,bank1,bank2,frames=1024;

    in1 = PlayBuf.ar(1, ~c5.bufnum, BufRateScale.kr(~c5), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~c6.bufnum, BufRateScale.kr(~c6), loop: 0, doneAction:2);

	chainx = FFT(LocalBuf(frames), in1);
	chainy = FFT(LocalBuf(frames), in2);

	bank1=3;
	bank2=90;

	bank1.do{

   bank2.do{

		az1=~az_z.[pl];
		el1=~el_z.[pl];
		az2=~az_z.reverse.[pl];
		el2=~el_z.reverse.[pl];
amp1=Cartesian(~magx_array.[pl2].[pl1],~magx_array.[pl2].[pl1],~magx_array.[pl2].[pl1]);
amp2=Cartesian(~magx_array.[pl2].reverse.[pl1],~magx_array.[pl2].reverse.[pl1],~magx_array.[pl2].reverse.[pl1]);

			phase1=exp(Complex(0,1)*(amp1.theta))*exp(Complex(0,1)*(amp1.phi));
		phase2=exp(Complex(0,1)*(amp2.theta))*exp(Complex(0,1)*(amp2.phi));

chainxx = chainx.pvcollect(frames, {|mag, phase, index| [mag*amp1.rho/(2.sqrt), exp(Complex(0,1)*(phase+phase1.theta)).theta]; }, frombin: b, tobin: b, zeroothers: 1);
chainyy = chainy.pvcollect(frames, {|mag, phase, index| [mag*amp2.rho/(2.sqrt), exp(Complex(0,1)*(phase+phase2.theta)).theta]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,
		Osc.ar(~t,rpr,phase:az1.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
			Osc.ar(~t,rpr,phase:el1.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));

		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,
		Osc.ar(~t,rpr,phase:az2.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
			Osc.ar(~t,rpr,phase:el2.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));
pl=pl+1;
	pl1=pl1+1;

		};
		pl2=pl2+1;
	};
}).add;
);
)*/;
/*(
Synth(\o1);
s.record(numChannels:4)
Synth(\o2);
//s.record(numChannels:4)
Synth(\o3);
//s.record(numChannels:4)
)*/

(
(
SynthDef.new(\o1, {
    var in1,in2, chainx,chainy,b=0,az1=0,az2=0,el1=0,el2=0,rpr=1;
	var chainxx,chainyy,pl=0,amp1,amp2,phase;
	var angle1=0,angle2=90;
	var phase1,phase2,bank1,bank2,frames=1024;

    in1 = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1.bufnum), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2.bufnum), loop: 0, doneAction:2);

	chainx = FFT(LocalBuf(frames), in1);
	chainy = FFT(LocalBuf(frames), in2);

	bank2=180;

   bank2.do{

		az1=~az.[pl];
		el1=~el.[pl];
		az2=~az.reverse.[pl];
		el2=~el.reverse.[pl];
amp1=Cartesian(~magx3.[pl],~magy3.[pl],~magz3.[pl]);
amp2=Cartesian(~magx3.reverse.[pl],~magy3.reverse.[pl],~magz3.reverse.[pl]);


	phase1=Polar(amp1.phi.bilin(0,90.degrad.neg,90.degrad,1,0,0),amp1.theta.linlin(pi.neg,pi,2pi.neg,2pi));
	phase2=Polar(amp2.phi.bilin(0,90.degrad.neg,90.degrad,1,0,0),amp2.theta.linlin(pi.neg,pi,2pi.neg,2pi));


chainxx = chainx.pvcollect(frames, {|mag, phase, index| [mag*amp1.rho/(2.sqrt), exp(Complex(0,1)*(phase+phase1.theta)).theta]; }, frombin: b, tobin: b, zeroothers: 1);
chainyy = chainy.pvcollect(frames, {|mag, phase, index| [mag*amp2.rho/(2.sqrt), exp(Complex(0,1)*(phase+phase2.theta)).theta]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,
		Osc.ar(~t,phase1.rho,phase:az1.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
			Osc.ar(~t,phase1.rho,phase:el1.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));

		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,
		Osc.ar(~t,phase2.rho,phase:az2.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
			Osc.ar(~t,phase2.rho,phase:el2.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));
pl=pl+1;

	};
}).add;
);
(
SynthDef.new(\o2, {
    var in1,in2, chainx,chainy,b=0,az1=0,az2=0,el1=0,el2=0,rpr=1;
	var chainxx,chainyy,pl=0,amp1,amp2,phase;
	var angle1=0,angle2=90;
	var phase1,phase2,bank1,bank2,frames=1024;

    in1 = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1.bufnum), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2.bufnum), loop: 0, doneAction:2);

	chainx = FFT(LocalBuf(frames), in1);
	chainy = FFT(LocalBuf(frames), in2);

	bank2=180;

   bank2.do{

		az1=~az.[pl];
		el1=~el.[pl];
		az2=~az.reverse.[pl];
		el2=~el.reverse.[pl];
amp1=Cartesian(~magx3.[pl],~magy3.[pl],~magz3.[pl]);
amp2=Cartesian(~magx3.reverse.[pl],~magy3.reverse.[pl],~magz3.reverse.[pl]);


phase1=Polar(amp1.phi.bilin(0,90.degrad.neg,90.degrad,1,0,0),amp1.theta.linlin(pi.neg,pi,2pi.neg,2pi));
	phase2=Polar(amp2.phi.bilin(0,90.degrad.neg,90.degrad,1,0,0),amp2.theta.linlin(pi.neg,pi,2pi.neg,2pi));


chainxx = chainx.pvcollect(frames, {|mag, phase, index| [mag*amp1.rho/(2.sqrt), exp(Complex(0,1)*(phase+phase1.theta)).theta]; }, frombin: b, tobin: b, zeroothers: 1);
chainyy = chainy.pvcollect(frames, {|mag, phase, index| [mag*amp2.rho/(2.sqrt), exp(Complex(0,1)*(phase+phase2.theta)).theta]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,
		Osc.ar(~t,phase1.rho,phase:az1.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
			Osc.ar(~t,phase1.rho,phase:el1.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));

		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,
		Osc.ar(~t,phase2.rho,phase:az2.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
			Osc.ar(~t,phase2.rho,phase:el2.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));
pl=pl+1;
	}
	}).add;
);
(
SynthDef.new(\o3, {
    var in1,in2, chainx,chainy,b=0,az1=0,az2=0,el1=0,el2=0,rpr=1;
	var chainxx,chainyy,pl=0,amp1,amp2,phase;
	var angle1=0,angle2=90;
	var phase1,phase2,bank1,bank2,frames=1024;

    in1 = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1.bufnum), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2.bufnum), loop: 0, doneAction:2);

	chainx = FFT(LocalBuf(frames), in1);
	chainy = FFT(LocalBuf(frames), in2);

	bank2=180;

   bank2.do{

		az1=~az.[pl];
		el1=~el.[pl];
		az2=~az.reverse.[pl];
		el2=~el.reverse.[pl];
amp1=Cartesian(~magx3.[pl],~magy3.[pl],~magz3.[pl]);
amp2=Cartesian(~magx3.reverse.[pl],~magy3.reverse.[pl],~magz3.reverse.[pl]);

	phase1=Polar(amp1.phi.bilin(0,90.degrad.neg,90.degrad,1,0,0),amp1.theta.linlin(pi.neg,pi,2pi.neg,2pi));
	phase2=Polar(amp2.phi.bilin(0,90.degrad.neg,90.degrad,1,0,0),amp2.theta.linlin(pi.neg,pi,2pi.neg,2pi));


chainxx = chainx.pvcollect(frames, {|mag, phase, index| [mag*amp1.rho/(2.sqrt), exp(Complex(0,1)*(phase+phase1.theta)).theta]; }, frombin: b, tobin: b, zeroothers: 1);
chainyy = chainy.pvcollect(frames, {|mag, phase, index| [mag*amp2.rho/(2.sqrt), exp(Complex(0,1)*(phase+phase2.theta)).theta]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,
		Osc.ar(~t,phase1.rho,phase:az1.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
			Osc.ar(~t,phase1.rho,phase:el1.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));

		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,
		Osc.ar(~t,phase2.rho,phase:az2.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
			Osc.ar(~t,phase2.rho,phase:el2.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));
pl=pl+1;
	}
	}).add;
);
)
(
Synth(\o1);
//s.record(numChannels:4);
Synth(\o2);
//s.record(numChannels:4);
Synth(\o3);
s.record(numChannels:4)
)
////exp(Complex(0,1)*(phase+SinOsc.ar(mg,phase1))).theta
//////////////////////////////////////IN

// (
// SynthDef.new(\o_in, {
// 	var in1,in2, chainx,chainy,b=0,az1=0,az2=0,el1=0,el2=0,rpr=1;
// 	var chainxx,chainyy,pl1=0,pl2=0,pl=0,amp1,amp2,phase;
// 	var angle1=0,angle2=90;
// 	var phase1,phase2,bank1,bank2,frames=1024;
//
// 	in1 =SoundIn.ar(0);
// 	in2 = SoundIn.ar(0);
//
// 	chainx = FFT(LocalBuf(frames), in1);
// 	chainy = FFT(LocalBuf(frames), in2);
//
// 	bank1=3;
// 	bank2=90;
//
// 	bank1.do{
//
// 		bank2.do{
//
// 			az1=~az.[pl];
// 			el1=~el.[pl];
// 			az2=~az.reverse.[pl];
// 			el2=~el.reverse.[pl];
// 			amp1=Cartesian(~magx_array.[pl2].[pl1],~magx_array.[pl2].[pl1],~magx_array.[pl2].[pl1]);
// 			amp2=Cartesian(~magx_array.[pl2].reverse.[pl1],~magx_array.[pl2].reverse.[pl1],~magx_array.[pl2].reverse.[pl1]);
//
// 			phase1=Polar(amp1.phi.bilin(0,90.degrad.neg,90.degrad,1,0,0),amp1.theta.linlin(pi.neg,pi,2pi.neg,2pi));
// 			phase2=Polar(amp2.phi.bilin(0,90.degrad.neg,90.degrad,1,0,0),amp2.theta.linlin(pi.neg,pi,2pi.neg,2pi));
//
//
// 			chainxx = chainx.pvcollect(frames, {|mag, phase, index| [mag*amp1.rho/(2.sqrt), exp(Complex(0,1)*(phase+phase1.theta)).theta]; }, frombin: b, tobin: b, zeroothers: 1);
// 			chainyy = chainy.pvcollect(frames, {|mag, phase, index| [mag*amp2.rho/(2.sqrt), exp(Complex(0,1)*(phase+phase2.theta)).theta]; }, frombin: b, tobin: b, zeroothers: 1);
//
// 			b=b+1;
//
// 			Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,
// 				Osc.ar(~t,phase1.rho,phase:az1.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
// 			Osc.ar(~t,phase1.rho,phase:el1.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));
//
// 			Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,
// 				Osc.ar(~t,phase2.rho,phase:az2.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
// 			Osc.ar(~t,phase2.rho,phase:el2.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));
// 			pl=pl+1;
// 			pl1=pl1+1;
//
// 		};
// 		pl2=pl2+1;
// 	};
// }).add;
// )
	({
		var angle=0;
		~angle=(720*~time).collect{
		angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
		}
		}.value;
	~angle=~angle/2;
	);

(
SynthDef.new(\o_in, {
    var in1,in2, chainx,chainy,b=0,az1=0,az2=0,el1=0,el2=0,rpr=1;
	var chainxx,chainyy,pl1=0,pl2=0,pl=0,amp1,amp2,phase;
	var angle1=0,angle2=90;
	var phase1,phase2,bank1,bank2,frames=1024;

	 in1 = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1.bufnum), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2.bufnum), loop: 0, doneAction:2);

	chainx = FFT(LocalBuf(frames), in1);
	chainy = FFT(LocalBuf(frames), in2);

	//in1 =SoundIn.ar(0);
	// in2 = SoundIn.ar(0);

	//chainx = FFT(LocalBuf(frames), in1);
	//chainy = FFT(LocalBuf(frames), in2);

	bank1=360;

	bank1.do{

		az1=~az.[pl];
		el1=~el.[pl];
			az2=~az.reverse.[pl];
		el2=~el.reverse.[pl];
amp1=Cartesian(~magx[pl],~magy.[pl],~magz.[pl]);
amp2=Cartesian(~magx.reverse.[pl],~magy.reverse.[pl],~magz.reverse.[pl]);

		phase1=Polar(amp1.phi.bilin(0,90.degrad.neg,90.degrad,1,0,0),amp1.theta.linlin(pi.neg,pi,2pi.neg,2pi));
	phase2=Polar(amp2.phi.bilin(0,90.degrad.neg,90.degrad,1,0,0),amp2.theta.linlin(pi.neg,pi,2pi.neg,2pi));


chainxx = chainx.pvcollect(frames, {|mag, phase, index| [mag*amp1.rho/(2.sqrt), exp(Complex(0,1)*(phase+~angle.[pl].degrad)).theta]; }, frombin: b, tobin: b, zeroothers: 1);
chainyy = chainy.pvcollect(frames, {|mag, phase, index| [mag*amp2.rho/(2.sqrt), exp(Complex(0,1)*(phase+~angle.[pl].degrad)).theta]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(6,IFFT(chainxx),~b.bufnum,az1.raddeg,el1.raddeg));

		Out.ar(0,VBAP.ar(6,IFFT(chainyy),~b.bufnum,az2.raddeg,el2.raddeg));
pl=pl+1;

		};
}).add;
)


Synth(\o_in);
s.record(numChannels:3);
s.record(numChannels:4);