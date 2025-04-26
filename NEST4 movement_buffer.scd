(
Server.default = s = Server.local;
////server setup
(
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=5;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(1);
s.options.memSize = 8192*128*2;
s.options.blockSize = 64*4;
s.options.maxNodes = 1024 * 16;
s.options.sampleRate= 44100;
);

s.waitForBoot{
Buffer.freeAll;
////////////////////////////////////speaker setup///other
/*(
// 3D///cube
~a = VBAPSpeakerArray.new(3, [[0, 45], [90, 45], [180, 45], [90.neg, 45],[0, 45.neg], [90, 45.neg], [180, 45.neg], [90.neg, 45.neg]]);
//0 up fl, 1 up bl, 2 up br, 3 up fr, 4 down fl, 5 down bl, 6 down br, 7 down fr
~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
///furhter on speaker setup can be geodesic octahedron 2nd order torus with 16 channels, and Rhombic triacontahedron with 32 vertices as 32 speaker channels
	// )*/
	~a = VBAPSpeakerArray.new(3, [[0, 45], [180, 45], [90, 45.neg], [90.neg, 45.neg]]);
	 ~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);


// 16
	// ~a = VBAPSpeakerArray.new(3, [[0, 45], [90, 45], [180, 45], [90.neg, 45],
	// 	[0, 0], [45, 0], [90, 0], [135, 0],[180.neg,0], [135.neg, 0], [90.neg, 0],[45.neg, 0],
	// [0, 45.neg], [90, 45.neg], [180, 45.neg], [90.neg, 45.neg]]);
	// //0 up fl, 1 up bl, 2 up br, 3 up fr, 4 down fl, 5 down bl, 6 down br, 7 down fr
	// ~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
///furhter on speaker setup can be geodesic octahedron 2nd order torus with 16 channels, and Rhombic triacontahedron with 32 vertices as 32 speaker channels
//)

///////////////////////////////////////////////////////arrays
///////l-system
	(
{
var dict = IdentityDictionary[\A -> "AB", \B -> "A"];
//These are the production rules of the L-system
var word = "A";
var string_temp = "";
var iter = 18;

//These are diction for the mapping of the alphabet to "artistic" parameters: degrees in a scale, beat occurrence, etc.

var dictnotes = IdentityDictionary[\A -> 0, \B -> 1];
 ~r=[];

//This iteration generates the system recursively

iter.do({

word.asArray.do({|i|
    string_temp = string_temp ++ dict[i.asSymbol];
});

word = string_temp;
	string_temp = "";
});

word.postln;

//Here we map the final system to the parameters as above

word.do({|i| ~r = ~r ++ dictnotes[i.asSymbol];});

~r.postln;
}.value
);


//////////////////////////////////////////////////basis
/*(
{
var  sph1,sph2,sph3,sph4,sph5,m_x=2,m_y=2,m_z=2;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0;
var angle=0,ang=0;
var azimuth,elevation,magnitudex,magnitudey,magnitudez;
var durx,dury,durz;
var sphx,sphy,sphz,azx=0,elx=0,azy=0,ely=0,azz=0,elz=0;
var num=1.neg;
var ellipsis=[1,1,1];
var spread=1;
	~dur=[];

durx=(360*12).collect{
			azx = (azx+1).wrap(180.neg,180);  // Increment azimuth
				elx = (elx+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sphx=(Spherical(1,(azx.degrad),(elx.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).x.round(0.000000001).abs;

	};

dury=(360*12).collect{
		azy = (azy+1).wrap(180.neg,180);  // Increment azimuth
			ely = (ely+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sphy=(Spherical(1,(azy.degrad),(ely.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).y.round(0.000000001).abs;

	};
durz=(360*12).collect{
			azz = (azz+1).wrap(180.neg,180);  // Increment azimuth
				elz = (elz+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sphz=(Spherical(1,(azz.degrad),(elz.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).z.round(0.000000001).abs;

	};

~az=(360*12).collect{

			az1 = (az1+1).wrap(180.neg,180);  // Increment azimuth
				el1 = (el1+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sph1=(Spherical(1,(az1.degrad),(el1.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).theta.round(0.00001);

	};

~el=(360*12).collect{

				az2 = (az2+1).wrap(180.neg,180);  // Increment azimuth
			el2 = (el2+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sph2=(Spherical(1,(az2.degrad),(el2.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).phi.round(0.00001);

	};

~magx=(360*12).collect{

			az3 = (az3+1).wrap(180.neg,180);  // Increment azimuth
			el3 = (el3+ (360-(360/1.6180339887499))).wrap(90.neg,90);

	sph3=(Spherical(1,(az3.degrad),(el3.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2]));

	 mag_x=((Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho/(2.sqrt)).pow(spread)*
			(Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread));

////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis

/*mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2)))).rho*
		 Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;*/

};

~magy=(360*12).collect{

			az4 = (az4+1).wrap(180.neg,180);  // Increment azimuth
			el4 = (el4+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph4=(Spherical(1,(az4.degrad),(el4.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2]));

mag_y=((Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho/(2.sqrt)).pow(spread)*
		(Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread));
//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
};

~magz=(360*12).collect{

			az5 = (az5+1).wrap(180.neg,180);  // Increment azimuth
			el5 = (el5+(360-(360/1.6180339887499))).wrap(90.neg,90);

sph5=(Spherical(1,(az5.degrad),(el5.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2]));

if(
m_z.even,
mag_z=(Complex(cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread),
mag_z=(Complex(sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread)
	);
////z axis   ambi..  sin for odd numbers, cos for even

};

				360.do{ num=num+1; ~dur=~dur++durx.[num]++dury.[num]++durz.[num];}
}.value;
(
//~magx = ~magx.collect { |z| z / ~magx.maxItem };
//~magy = ~magy.collect { |z| z / ~magy.maxItem };
//~magz = ~magz.collect { |z| z / ~magz.maxItem };
 );
)*/
	////no0
	(
{
var  sph1,sph2,sph3,sph4,sph5,m_x=2,m_y=2,m_z=2;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;
var angle=0,ang=0;
var azimuth,elevation,magnitudex,magnitudey,magnitudez;
var durx,dury,durz;
var sphx,sphy,sphz,azx,elx,azy,ely,azz,elz,plx=0,ply=0,plz=0;
var num=1.neg;
var ellipsis=[1,1,1],spread=1;
			~az=[];~el=[];~magx=[];~magy=[];~magz=[];~dur=[];

		360.do{
durx=(12).collect{
			azx = (angle+(360*2.pow(plx/12))).wrap(180.neg,180);  // Increment azimuth
				elx = (angle+(180*2.pow(plx/12))).wrap(90.neg,90);
		plx=(plx+1).mod(12);

		sphx=(Spherical(1,(azx.degrad),(elx.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).x.round(0.000000001).abs;

	};

dury=(12).collect{
		azy = (angle+(360*2.pow(ply/12))).wrap(180.neg,180);  // Increment azimuth
			ely = (angle+(180*2.pow(ply/12))).wrap(90.neg,90);
		ply=(ply+1).mod(12);

		sphy=(Spherical(1,(azy.degrad),(ely.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).y.round(0.000000001).abs;

	};
durz=(12).collect{
			azz = (angle+(360*2.pow(plz/12))).wrap(180.neg,180);  // Increment azimuth
				elz = (angle+(180*2.pow(plz/12))).wrap(90.neg,90);
		plz=(plz+1).mod(12);

		sphz=(Spherical(1,(azz.degrad),(elz.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).z.round(0.000000001).abs;

	};

azimuth=(12).collect{

			az1 = (angle+(360*2.pow(pl1/12))).wrap(180.neg,180);  // Increment azimuth
				el1 = (angle+(180*2.pow(pl1/12))).wrap(90.neg,90);
		pl1=(pl1+1).mod(12);

		sph1=(Spherical(1,(az1.degrad),(el1.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).theta.round(0.00001);

	};

elevation=(12).collect{

				az2 = (angle+(360*2.pow(pl2/12))).wrap(180.neg,180);  // Increment azimuth
			el2 = (angle+(180*2.pow(pl2/12))).wrap(90.neg,90);
		pl2=(pl2+1).mod(12);

		sph2=(Spherical(1,(az2.degrad),(el2.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).phi.round(0.00001);

	};

magnitudex=(12).collect{

			az3 = (angle+(360*2.pow(pl3/12))).wrap(180.neg,180);  // Increment azimuth
			el3 = (angle+ (180*2.pow(pl3/12))).wrap(90.neg,90);
		pl3=(pl3+1).mod(12);

	sph3=(Spherical(1,(az3.degrad),(el3.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2]));

	 mag_x=((Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho/(2.sqrt)).pow(spread)*
			(Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread));

////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis

/*mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2)))).rho*
		 Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;*/

};

magnitudey=(12).collect{

			az4 = (angle+(360*2.pow(pl4/12))).wrap(180.neg,180);  // Increment azimuth
			el4 = (angle+(180*2.pow(pl4/12))).wrap(90.neg,90);
		pl4=(pl4+1).mod(12);

	sph4=(Spherical(1,(az4.degrad),(el4.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2]));

mag_y=((Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho/(2.sqrt)).pow(spread)*
		(Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread));
//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
};

magnitudez=(12).collect{

			az5 = (angle+(360*2.pow(pl5/12))).wrap(180.neg,180);  // Increment azimuth
				el5 = (angle+(180*2.pow(pl5/12))).wrap(90.neg,90);
		pl5=(pl5+1).mod(12);

		sph5=(Spherical(1,(az5.degrad),(el5.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2]));

if(
m_z.even,
mag_z=(Complex(cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread),
mag_z=(Complex(sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread)
	);
////z axis   ambi..  sin for odd numbers, cos for even

};angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);~az=~az++azimuth;~el=~el++elevation;~magx=~magx++magnitudex;~magy=~magy++magnitudey;~magz=~magz++magnitudez;

				12.do{ num=num+1; ~dur=~dur++durx.[num]++dury.[num]++durz.[num];};num=1.neg;};
}.value;
(
//~magx = ~magx.collect { |z| z / ~magx.maxItem };
//~magy = ~magy.collect { |z| z / ~magy.maxItem };
//~magz = ~magz.collect { |z| z / ~magz.maxItem };
 );
);
/////synths////

		(
SynthDef.new(\ospace, {
	arg amp=1,pl1=1,lfo,m=3,spread=1,ripple=0.01,amount=1,decay1=8,decay2=8,decay3=8,varamp=5;
	var phase,osc1,osc2,osc3,sphere,amp1,amp2,amp3,octave=8;
	var ton1,ton2,ton3,fundamental,sph3,sph4,sph5;
	var freq,pitch1,pitch2,pitch3,env1,env2,env3,sig;
	var n1,n2,n3,rq1,rq2,rq3;
	var magx,magy,magz,mag_x,mag_y,mag_z;
	var ratio1,ratio2,ratio3;
	var scale,nn=29.neg;
	var ampx,ampy,ampz,mod_angle,mod_angle1;
	var ellipsis=[1,1,1],mag,magxx;
	var waveSpeed = 1, waveFreq = 8, theta,phi,wave,t;


	t=SinOsc.kr(ripple).range(1, 100);
waveFreq=amount.round(1);
		sph3=Spherical(1,Select.kr(pl1,~az),Select.kr(pl1,~el));
		sph4=Spherical(1,Select.kr(pl1,~az),Select.kr(pl1,~el));
		sph5=Spherical(1,Select.kr(pl1,~az),Select.kr(pl1,~el));

			//mod_angle=SinOsc.ar(lfo,0.degrad,mul:1).range(90.neg.degrad,90.degrad);
			//mod_angle1=SinOsc.ar(lfo,90.degrad,mul:1).range(90.neg.degrad,90.degrad);
			mod_angle=LFNoise1.ar(lfo).range(90.neg.degrad,90.degrad);
	    	mod_angle1=LFNoise1.ar(lfo).range(90.neg.degrad,90.degrad);

					(
					magx=((Complex(cos(((sph3.theta+mod_angle).round(0.00001)*m).wrap(pi.neg,pi)),cos((((sph3.theta+mod_angle).round(0.00001)*m)).wrap(pi.neg,pi))).rho/(2.sqrt)).pow(spread)*
	(Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread);

////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis
/*
		(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
			cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		 	Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/
		 	2).neg,(pi/2)))).rho*
		 Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;*/
				);

magy=((Complex(sin(((sph4.theta+mod_angle1).round(0.00001)*m).wrap(pi.neg,pi)),sin(((sph4.theta+mod_angle1).round(0.00001)*m).wrap(pi.neg,pi))).rho/(2.sqrt)).pow(spread)*
		(Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread);
//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
				);

magz=((Complex(cos(((sph5.phi+mod_angle).round(0.00001)*m).wrap((pi/2).neg,(pi/2))),cos(((sph5.phi+mod_angle1).round(0.00001)*m).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread));

	theta = Select.kr(pl1,~az).degrad;
     phi = Select.kr(pl1,~el).degrad;
 wave = varamp*sin(waveFreq * theta + waveFreq * phi - waveSpeed * t);
magxx=  magx * wave;

				mag_x=magxx.value; mag_y= magy.value; mag_z=magz.value;
				);
			    env1=EnvGen.ar(Env.perc(0.05,decay1,amp),doneAction:2,levelScale:1);
				env2=EnvGen.ar(Env.perc(0.05,decay2,amp),doneAction:2,levelScale:1);
				env3=EnvGen.ar(Env.perc(0.05,decay3,amp),doneAction:2,levelScale:1);
			// env1=EnvGen.ar(Env.sine(decay1,amp),doneAction:2,levelScale:1);
			//	env2=EnvGen.ar(Env.sine(decay2,amp),doneAction:2,levelScale:1);
			//	env3=EnvGen.ar(Env.sine(decay3,amp),doneAction:2,levelScale:1);

scale=57.collect{nn=nn+1;Scale.major.performDegreeToKey(nn,12)};
fundamental=(12*64);freq=(fundamental*octave);

sphere=Spherical(28,Select.kr(pl1,~az),Select.kr(pl1,~el));
n1=(sphere.x).round(0.00000001); n2=(sphere.y).round(0.00000001); n3=(sphere.z).round(0.00000005);
ratio1=n1.round(1);ratio2=n2.round(1);ratio3=n3.round(1);
ton1 = 2.pow(Select.kr(ratio1.linlin(28.neg, 28, 0, 56), scale) / 12);
ton2 = 2.pow(Select.kr(ratio2.linlin(28.neg, 28, 0, 56), scale) / 12);
ton3 = 2.pow(Select.kr(ratio3.linlin(28.neg, 28, 0, 56), scale) / 12);
//ton1 = 2.pow(n1 / 12);
//ton2 = 2.pow(n2 / 12);
//ton3 = 2.pow(n3 / 12);
	amp1=(ton1.reciprocal*octave.reciprocal).round(0.00000001);
	amp2=(ton2.reciprocal*octave.reciprocal).round(0.00000001);
	amp3=(ton3.reciprocal*octave.reciprocal).round(0.00000001);
	pitch1=(freq*ton1).round(0.0000001);pitch2=(freq*ton2).round(0.0000001);pitch3=(freq*ton3).round(0.0000001);
sig=InFeedback.ar(4,1);
//rq1=In.kr(0).lag(0.1);rq2=In.kr(1).lag(0.1);rq3=In.kr(2).lag(0.1);
rq1=0.0001;rq2=0.0001;rq3=0.0001;
mag=Cartesian(mag_x,mag_y,mag_z).rho;

osc1=VBAP.ar(4,BPF.ar(sig,pitch1,rq1,mul:amp1*mag*(rq1.sqrt.reciprocal)),~b.bufnum,sphere.theta.raddeg,sphere.phi.raddeg);
osc2=VBAP.ar(4,BPF.ar(sig,pitch2,rq2,mul:amp2*mag*(rq2.sqrt.reciprocal)),~b.bufnum,sphere.theta.raddeg,sphere.phi.raddeg);
osc3=VBAP.ar(4,BPF.ar(sig,pitch3,rq3,mul:amp3*mag*(rq3.sqrt.reciprocal)),~b.bufnum,sphere.theta.raddeg,sphere.phi.raddeg);

//Out.ar(0,LeakDC.ar(osc3,mul:env1*In.kr(3)));
//Out.ar(0,LeakDC.ar(osc2,mul:env2*In.kr(3)));
//Out.ar(0,LeakDC.ar(osc1,mul:env3*In.kr(3)));
Out.ar(0,LeakDC.ar(osc3,mul:env1));
Out.ar(0,LeakDC.ar(osc2,mul:env2));
Out.ar(0,LeakDC.ar(osc1,mul:env3));

}).add;
);


////////////list
	({
		var n=1.neg;
		~list1=(360*12).collect{
		n=n+1;
		}
		}.value
	);
~list1=~list1.scramble;
//////////pattern for mobius strib of sequential or parallel play of directions

		~aa=Pdef(\1, Pbind(\instrument, \ospace,
			\dur,Pseq(~dur,inf),
		\m,Prand([1,2,3,4],inf),    /////spherical harmonic
			//\dur,1,
			\pl1,Pseq(~list1,inf),    ///////coordinate selection
		\lfo,Pbrown(0.001,1,0.1,inf), /////spherical harmonic oscillation
		\spread,Pbrown(0.1,5,1,inf),  //////spherical harmonic width
		\ripple,Pbrown(0.0001,0.1,0.01,inf),  /////sphere ripple wave oscillation speed
		\amount,Pbrown(1,32,2,inf),   /////sphere ripple waves amount
		//\varamp,Pbrown(0.1,1,0.5,inf), /////ripple amp
		\decay1,Pbrown(4,6,0.1,inf),
		\decay2,Pbrown(4,6,0.1,inf),
		\decay3,Pbrown(4,6,0.1,inf),
		\varamp,2,
			//\amp,Pseq(~r,inf);///l system
			\amp,1;
));
	TempoClock.default.tempo_(2);

~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Dokuments/EXTERNAL/music/band album library/Blazon Stone/Return To Port Royal - Definitive Edition/01 Black Chest In (Intro).wav",channels:0);
/*	~m=Buffer.alloc(s,2048);
			{
var signal,wt,env;

	//	env=Env([0.0001,0.0001,0.05,0.1,0.1,0.05,0.0001,0.0001],[40,30,20,10,20,30,40],[0,12,-4,0,4,-12,0]);
		env=Env([0.0001,0.001,0.01,0.1,0.1,0.01,0.001,0.0001],[40,30,20,10,20,30,40],[0,12,-4,0,4,-12,0]);
		signal=env.asSignal(1024);
wt=signal.asWavetable;
		//signal.plot;
~m.loadCollection(wt);
		}.value;*/

(
SynthDef.new(\obuff, {
	arg buffer=0;
	var sig1,sig2,env,gain=0.1;

			//env= EnvGen.ar(Env.sine(10),doneAction:2);
			sig1=PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1.bufnum),startPos:0, loop: 1, doneAction:2);
			//sig2=PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1.bufnum),startPos:0, loop: 1, doneAction:2)
			Out.ar(4,sig1*gain);
				//Out.kr(3,sig2*gain);
				//Out.kr(0,Osc.kr(~m.bufnum,0.01,phase:0.degrad));
				//Out.kr(1,Osc.kr(~m.bufnum,0.01,phase:0.degrad));
				//Out.kr(2,Osc.kr(~m.bufnum,0.01,phase:0.degrad));
			Out.kr(3,SinOsc.kr(0.001,mul:1));
}).add;
);
s.meter;s.freqscope;s.scope;
}
)
Scale.directory;

(
Synth(\obuff);
~aa.play;
);

s.record(numChannels:4);

///////

///sp freeze
~c3 = Buffer.readChannel(s,,channels:0 );

(
~fftsize=8192;
~hop=0.25;
~win=0;
~f={Buffer.alloc(s,~c1.duration.calcPVRecSize(~fftsize,~hop))}!2;
)
(
{
	var sig,chain,localbuf;
	sig=PlayBuf.ar(2, ~c3.bufnum, BufRateScale.kr(~c3), loop: 0,doneAction:2);
	localbuf={LocalBuf.new(~fftsize)}!2;
	chain=FFT(localbuf,sig,~hop,~win);
	chain=PV_RecordBuf(chain,~f,run:1,hop:~hop,wintype:~win);
	0;
}.play;
)

(
x={
	var sig,chain,localbuf;
	localbuf={LocalBuf.new(~fftsize)}!2;
		chain=PV_PlayBuf(localbuf,~f,\rate.kr(1),loop:inf);
		sig=IFFT(chain,~win);
	}.play;
)

x.set(\rate,0);
x.set(\rate,1/1);
x.set(\rate,-2/3);
x.release(2);
