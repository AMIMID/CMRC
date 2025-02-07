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

Buffer.freeAll;
	~a = VBAPSpeakerArray.new(3, [[0, 45], [180, 45], [90, 45.neg], [90.neg, 45.neg]]);
	 ~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
///////////////////////////////////////////////////////arrays
	(
{
var  sph1,sph2,sph3,sph4,sph5,m_x=2,m_y=3,m_z=4;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;
var angle=0;
var azimuth,elevation,magnitudex,magnitudey,magnitudez;


~az=[];~el=[];~magx=[];~magy=[];~magz=[];

		360.do{
azimuth=(13).collect{

		/*az1 = (az1 + 3);  // Increment azimuth
        if (az1 > 180) { az1 = az1 - 360 };  // Wrap to [-180, 180)
        if (az1 <= -180) { az1 = az1 + 360 };  // Wrap to [-180, 180)

        el1 = (el1 + 3);  // Increment elevation
        if (el1 > 90) { el1 = el1 - 180 };  // Wrap to [-90, 90)
        if (el1 <= -90) { el1 = el1 + 180 };  // Wrap to [-90, 90)*/


			az1 = (angle+(360*2.pow(pl1/12))).wrap(180.neg,180);  // Increment azimuth
			el1 = (angle+(180*2.pow(pl1/12))).wrap(90.neg,90);
		pl1=(pl1+1).mod(13);
		/*	az1 = (0+(90*2.pow(pl1/12))).wrap(180.neg,180);
		el1 = (45*2.pow(pl1/12)).wrap(90.neg,90);
		pl1=(pl1+1).mod(25);*/

		sph1=Spherical(1,(az1.degrad),(el1.degrad)).theta.round(0.00001);

	};

elevation=(13).collect{

		/*	az2 = (az2 + 3);  // Increment azimuth
        if (az2 > 180) { az2 = az2 - 360 };  // Wrap to [-180, 180)
        if (az2 <= -180) { az2 = az2 + 360 };  // Wrap to [-180, 180)

        el2 = (el2 + 3);  // Increment elevation
        if (el2 > 90) { el2 = el2 - 180 };  // Wrap to [-90, 90)
        if (el2 <= -90) { el2 = el2 + 180 };  // Wrap to [-90, 90)*/

				az2 = (angle+(360*2.pow(pl2/12))).wrap(180.neg,180);  // Increment azimuth
			el2 = (angle+(180*2.pow(pl2/12))).wrap(90.neg,90);
		pl2=(pl2+1).mod(13);
		/*	az2 = (0+(90*2.pow(pl2/12))).wrap(180.neg,180);
		el2 = (45*2.pow(pl2/12)).wrap(90.neg,90);
		pl2=(pl2+1).mod(25);*/


		sph2=Spherical(1,(az2.degrad),(el2.degrad)).phi.round(0.00001);

	};

magnitudex=(13).collect{
		/*az3 = (az3 + 3);  // Increment azimuth
        if (az3 > 180) { az3 = az3 - 360 };  // Wrap to [-180, 180)
        if (az3 <= -180) { az3 = az3 + 360 };  // Wrap to [-180, 180)

        el3 = (el3 + 3);  // Increment elevation
        if (el3 > 90) { el3 = el3 - 180 };  // Wrap to [-90, 90)
        if (el3 <= -90) { el3 = el3 + 180 };  // Wrap to [-90, 90)*/

			az3 = (angle+(360*2.pow(pl3/12))).wrap(180.neg,180);  // Increment azimuth
			el3 = (angle+ (180*2.pow(pl3/12))).wrap(90.neg,90);
		pl3=(pl3+1).mod(13);

		/*	az3 = (0+(90*2.pow(pl3/12))).wrap(180.neg,180);
		el3 = (45*2.pow(pl3/12)).wrap(90.neg,90);
		pl3=(pl3+1).mod(25);*/

	sph3=Spherical(1,(az3.degrad),(el3.degrad));
	 mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis

		/* mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
			cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		 	Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/
		 	2).neg,(pi/2)))).rho*
		 Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;*/

};

magnitudey=(13).collect{
		/*az4 = (az4 + 3);  // Increment azimuth
        if (az4 > 180) { az4 = az4 - 360 };  // Wrap to [-180, 180)
        if (az4 <= -180) { az4 = az4 + 360 };  // Wrap to [-180, 180)

        el4 = (el4 + 3);  // Increment elevation
        if (el4 > 90) { el4 = el4 - 180 };  // Wrap to [-90, 90)
        if (el4 <= -90) { el4 = el4 + 180 };  // Wrap to [-90, 90)
*/

			az4 = (angle+(360*2.pow(pl4/12))).wrap(180.neg,180);  // Increment azimuth
			el4 = (angle+(180*2.pow(pl4/12))).wrap(90.neg,90);
		pl4=(pl4+1).mod(13);

		/*	az4 = (0+(90*2.pow(pl4/12))).wrap(180.neg,180);
		el4 = (45*2.pow(pl4/12)).wrap(90.neg,90);
		pl4=(pl4+1).mod(25);*/

	sph4=Spherical(1,(az4.degrad),(el4.degrad));

	mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),
		sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/
		2)))).rho)*sph4.rho;
//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
};

magnitudez=(13).collect{
		/*az5 = (az5 + 3);  // Increment azimuth
        if (az5 > 180) { az5 = az5 - 360 };  // Wrap to [-180, 180)
        if (az5 <= -180) { az5 = az5 + 360 };  // Wrap to [-180, 180)

        el5 = (el5 + 3);  // Increment elevation
        if (el5 > 90) { el5 = el5 - 180 };  // Wrap to [-90, 90)
        if (el5 <= -90) { el5 = el5 + 180 };  // Wrap to [-90, 90)*/

			az5 = (angle+(360*2.pow(pl5/12))).wrap(180.neg,180);  // Increment azimuth
			el5 = (angle+(180*2.pow(pl5/12))).wrap(90.neg,90);
		pl5=(pl5+1).mod(13);
			//
			// az5 = (0+(90*2.pow(pl5/12))).wrap(180.neg,180);
			// el5 = (45*2.pow(pl5/12)).wrap(90.neg,90);
			// pl5=(pl5+1).mod(25);

		sph5=Spherical(1,(az5.degrad),(el5.degrad));

if(
m_z.even,
mag_z=Complex(cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho,
mag_z=Complex(sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho
	);
////z axis   ambi..  sin for odd numbers, cos for even
};angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);~az=~az++azimuth;~el=~el++elevation;~magx=~magx++magnitudex;~magy=~magy++magnitudey;~magz=~magz++magnitudez};
}.value;
(
~magx=(~magx).round(0.000000001)/(2.sqrt);
			~magy=(~magy).round(0.000000001)/(2.sqrt);
			~magz=(~magz).round(0.000000001)/(2.sqrt);
 );
);

//////////////////////////////////////////////////////// durs

	(
{
var angle1=0, angle2=0,value1,value2,n1=0,n2=0,re,im,angle=0;
			~real=[];~imag=[];

			(360).do {
  re=12.collect{
					n1=(n1+1);
					angle1 = (angle + (n1*(pi/12))).wrap(0,2pi);
					//angle1 = (angle + (pi/2)*2.pow(n1/12)).wrap(0,2pi);
		//n1=(n1+1).mod(13);
					value1=exp(Complex(0,1)*angle1).real.abs.round(0.00001);};
  im=12.collect{
					n2=(n2+1);
					angle2 = (angle + (n2*(pi/12))).wrap(0,2pi);
					//angle2 = (angle + (pi/2)*2.pow(n2/12)).wrap(0,2pi);
		//n2=(n2+1).mod(13);
		value2=exp(Complex(0,1)*angle2).imag.abs.round(0.00001);};

				~real=~real++re; ~imag=~imag++im; n1=0;n2=0;
				angle = (angle + (360-(360/1.6180339887499))).wrap(0, 360);
			};
}.value
);

	(
{
var dur=1,ph1,pl1=0,sph;

~dur1 = (360*12).collect{
			sph=~real.[pl1];
	pl1=pl1+1;
	ph1=(sph+dur).round(1/32);

	};

}.value;
	{
var dur=1,ph1,pl1=0,sph;

~dur2 = (360*12).collect{
			sph=~imag.[pl1];
	pl1=pl1+1;
	ph1=(sph+dur).round(1/32);

	};

}.value;
	);
//////////////dur randomization

{	var seed = 1000.rand;
thisThread.randSeed = seed; ~duration_x1 = ~dur1.scramble;
thisThread.randSeed = seed; ~duration_y1 = ~dur2.scramble;	}.value;


/////synths////
	(
(
SynthDef.new(\ospace1, {
	arg mult1=1,mult2=1,mult3=1,amp=1,pl1=1;
	var phase,osc1,osc2,osc3,sphere,mag_o,amp1,amp2,amp3,decay=7,pl2=0,envp,octave=4;
	var ton1,ton2,ton3;
	var fundamental;
	var freq,pitch1,pitch2,pitch3,env;
	var pitch;
	var n1,n2,n3;
	var sphere1,sphere2,sphere3;
	var xyz;
				env=EnvGen.ar(Env.perc(0.01,decay,amp),doneAction:2,levelScale:2);

fundamental=(55);
freq=(fundamental*octave);

		mag_o=Cartesian(Select.kr(pl1,~magx), Select.kr(pl1,~magy),Select.kr(pl1,~magz));

				sphere=Spherical(mag_o.rho.round(0.00000001)/(2.sqrt),Select.kr(pl1,~az),Select.kr(pl1,~el));

	xyz=Spherical(sphere.rho,sphere.theta,sphere.phi);

	n1=(xyz.x).round(0.00000001); n2=(xyz.y).round(0.00000001); n3=(xyz.z).round(0.00000005);

ton1=n1.abs.linlin(0,1,1,2*mult1);
ton2=n2.abs.linlin(0,1,1,2*mult2);
ton3=n3.abs.linlin(0,1,1,2*mult3);


	    amp1=(ton1.reciprocal*octave.reciprocal).round(0.00000001);
		amp2=(ton2.reciprocal*octave.reciprocal).round(0.00000001);
		amp3=(ton3.reciprocal*octave.reciprocal).round(0.00000001);

	pitch1=(freq*ton1).round(0.0000001);
	pitch2=(freq*ton2).round(0.0000001);
	pitch3=(freq*ton3).round(0.0000001);


osc1=VBAP.ar(4,
				SinOsc.ar(pitch1,mul:amp1,phase:0),
~b.bufnum,
sphere.theta.raddeg,sphere.phi.raddeg
		);

osc2=VBAP.ar(4,
						SinOsc.ar(pitch2,mul:amp2,phase:0),
~b.bufnum,
sphere.theta.raddeg,sphere.phi.raddeg
		);

osc3=VBAP.ar(4,
						SinOsc.ar(pitch3,mul:amp3,phase:0),
~b.bufnum,
sphere.theta.raddeg,sphere.phi.raddeg
		);

					Out.ar(0,LeakDC.ar(osc3,mul:env));
					Out.ar(0,LeakDC.ar(osc2,mul:env));
					Out.ar(0,LeakDC.ar(osc1,mul:env));

}).add;
);
);



//////////pattern
	(

~aa=Pdef(\1, Pbind(\instrument, \ospace1,
			\dur,Pseq(~dur1,1),
			\pl1,Pbrown(0,4680,6,inf),
			\mult1,Prand([1,2,4,8],inf),
				\mult2,Prand([1,2,4,8],inf),
				\mult3,Prand([1,2,4,8],inf),
));

~aaa=Pdef(\9, Pbind(\instrument, \ospace1,
			\dur,Pseq(~dur2,1),
			\pl1,Pbrown(0,4680,6,inf),
				\mult1,Prand([1,2,4,8],inf),
				\mult2,Prand([1,2,4,8],inf),
				\mult3,Prand([1,2,4,8],inf),
));
	);
	TempoClock.default.tempo_(2/1);



}
)


(
~aa.play;
~aaa.play;
);
s.record(numChannels:4);
