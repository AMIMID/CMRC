(
Server.default = s = Server.local;
////server setup
(
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=6;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(1);
s.options.memSize = 8192*128*2;
s.options.blockSize = 64*4;
s.options.maxNodes = 1024 * 16;
s.options.sampleRate= 44100;
);

s.waitForBoot{
/////wavetables
Buffer.freeAll;
s.meter;
	s.freqscope;
	s.scope;
~t= Buffer.alloc(s,2048);


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
	////random values
	/*(
{
var  sph1,sph2,sph3,sph4,sph5,m_x=2,m_y=1,m_z=3;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0,spha,sphb,sphc,sphd,sphe,sph;
var  seed1 = 123,seed2=123,seed3=123,seed4=123,seed5=123,seed=123;
var azimuth,elevation,magnitudex,magnitudey,magnitudez,magg;
	var xyz1,xyz2,xyz3,xyz4,xyz5;
var angle=0,ang=0;
var durx,dury,durz;
var sphx,sphy,sphz,azx,elx,azy,ely,azz,elz,plx=0,ply=0,plz=0;
var num=1.neg;
			~az=[];~el=[];~magx=[];~magy=[];~magz=[];~dur=[];



	~az=[];~el=[];~magx=[];~magy=[];~magz=[];~mag=[];
360.do{
				durx=(12).collect{
			azx = (angle+(360*2.pow(plx/12))).wrap(180.neg,180);  // Increment azimuth
				elx = (angle+(180*2.pow(plx/12))).wrap(90.neg,90);
		plx=(plx+1).mod(12);

					sphx=Spherical(1,(azx.degrad),(elx.degrad)).x.round(0.000000001).abs;

	};

dury=(12).collect{
		azy = (angle+(360*2.pow(ply/12))).wrap(180.neg,180);  // Increment azimuth
			ely = (angle+(180*2.pow(ply/12))).wrap(90.neg,90);
		ply=(ply+1).mod(12);

		sphy=Spherical(1,(azy.degrad),(ely.degrad)).y.round(0.000000001).abs;

	};
durz=(12).collect{
			azz = (angle+(360*2.pow(plz/12))).wrap(180.neg,180);  // Increment azimuth
				elz = (angle+(180*2.pow(plz/12))).wrap(90.neg,90);
		plz=(plz+1).mod(12);

		sphz=Spherical(1,(azz.degrad),(elz.degrad)).z.round(0.000000001).abs;

	};


azimuth=(12).collect{
thisThread.randSeed = seed1;
			seed1=seed1+1;

		xyz1=[2.pow(12.rand2/12),2.pow(12.rand2/12),2.pow(12.rand2/12)].normalizeSum.sqrt;

		spha=Cartesian(xyz1.[0]*([1.neg,1].choose),xyz1.[1]*([1.neg,1].choose),xyz1.[2]*([1.neg,1].choose));
			az1=(angle.degrad+spha.theta).wrap(pi.neg,pi);
			el1=(angle.degrad+spha.phi).wrap((pi/2).neg,(pi/2));
		sph1=Spherical(1,(az1),(el1)).theta.round(0.00001);
	};

elevation=(12).collect{
thisThread.randSeed = seed2;

			seed2=seed2+1;

			xyz2=[2.pow(12.rand2/12),2.pow(12.rand2/12),2.pow(12.rand2/12)].normalizeSum.sqrt;

		sphb=Cartesian(xyz2.[0]*([1.neg,1].choose),xyz2.[1]*([1.neg,1].choose),xyz2.[2]*([1.neg,1].choose));
az2=(angle.degrad+sphb.theta).wrap(pi.neg,pi);
			el2=(angle.degrad+sphb.phi).wrap((pi/2).neg,(pi/2));
		sph2=Spherical(1,(az2),(el2)).phi.round(0.00001);

	};

magnitudex=(12).collect{
thisThread.randSeed = seed3;

			seed3=seed3+1;

			xyz3=[2.pow(12.rand2/12),2.pow(12.rand2/12),2.pow(12.rand2/12)].normalizeSum.sqrt;

		sphc=Cartesian(xyz3.[0]*([1.neg,1].choose),xyz3.[1]*([1.neg,1].choose),xyz3.[2]*([1.neg,1].choose));
			az3=(angle.degrad+sphc.theta).wrap(pi.neg,pi);
			el3=(angle.degrad+sphc.phi).wrap((pi/2).neg,(pi/2));
		sph3=Spherical(1,(az3),(el3));

	 /*mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;
*/
////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis

		mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
			cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		 	Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/
		 	2).neg,(pi/2)))).rho*
		 Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;
};

magnitudey=(12).collect{
					thisThread.randSeed = seed4;

			seed4=seed4+1;

			xyz4=[2.pow(12.rand2/12),2.pow(12.rand2/12),2.pow(12.rand2/12)].normalizeSum.sqrt;

		sphd=Cartesian(xyz4.[0]*([1.neg,1].choose),xyz4.[1]*([1.neg,1].choose),xyz4.[2]*([1.neg,1].choose));
			az4=(angle.degrad+sphd.theta).wrap(pi.neg,pi);
			el4=(angle.degrad+sphd.phi).wrap((pi/2).neg,(pi/2));
	sph4=Spherical(1,(az4),(el4));

	mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),
		sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/
		2)))).rho)*sph4.rho;
//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
};

magnitudez=(12).collect{
					thisThread.randSeed = seed5;

			seed5=seed5+1;

			xyz5=[2.pow(12.rand2/12),2.pow(12.rand2/12),2.pow(12.rand2/12)].normalizeSum.sqrt;

		sphe=Cartesian(xyz5.[0]*([1.neg,1].choose),xyz5.[1]*([1.neg,1].choose),xyz5.[2]*([1.neg,1].choose));
			az5=(angle.degrad+sphe.theta).wrap(pi.neg,pi);
			el5=(angle.degrad+sphe.phi).wrap((pi/2).neg,(pi/2));
	sph5=Spherical(1,(az5),(el5));
if(
m_z.even,
mag_z=Complex(cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho,
mag_z=Complex(sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho
	);
////z axis   ambi..  sin for odd numbers, cos for even
};angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);~az=~az++azimuth;~el=~el++elevation;~magx=~magx++magnitudex;~magy=~magy++magnitudey;~magz=~magz++magnitudez;~mag=~mag++mag;12.do{ num=num+1; ~dur=~dur++durx.[num]++dury.[num]++durz.[num];};num=1.neg;};
}.value;
(
~magx=~magx/(2.sqrt);
~magy=~magy/(2.sqrt);
~magz=~magz/(2.sqrt);
 );
);*/

	////////with 0
	/*(
{
var  sph1,sph2,sph3,sph4,sph5,m_x=2,m_y=2,m_z=2;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;
var angle=0,ang=0;
var azimuth,elevation,magnitudex,magnitudey,magnitudez;
var durx,dury,durz;
var sphx,sphy,sphz,azx,elx,azy,ely,azz,elz,plx=0,ply=0,plz=0;
var num=1.neg;
var az=[],el=[],magx=[],magy=[],magz=[];

			~az=[];~el=[];~magx=[];~magy=[];~magz=[];~dur=[];

		32.do{
durx=(13).collect{
			azx = (angle+(360*2.pow(plx/12))).wrap(180.neg,180);  // Increment azimuth
				elx = (angle+(180*2.pow(plx/12))).wrap(90.neg,90);
		plx=(plx+1).mod(13);

					sphx=Spherical(1,(azx.degrad),(elx.degrad)).x.round(0.000000001).abs;

	};

dury=(13).collect{
		azy = (angle+(360*2.pow(ply/12))).wrap(180.neg,180);  // Increment azimuth
			ely = (angle+(180*2.pow(ply/12))).wrap(90.neg,90);
		ply=(ply+1).mod(13);

		sphy=Spherical(1,(azy.degrad),(ely.degrad)).y.round(0.000000001).abs;

	};
durz=(13).collect{
			azz = (angle+(360*2.pow(plz/12))).wrap(180.neg,180);  // Increment azimuth
				elz = (angle+(180*2.pow(plz/12))).wrap(90.neg,90);
		plz=(plz+1).mod(13);

		sphz=Spherical(1,(azz.degrad),(elz.degrad)).z.round(0.000000001).abs;

	};

		8.do{
azimuth=(13).collect{

			az1 = (angle+ang+(45*2.pow(pl1/12))).wrap(180.neg,180);  // Increment azimuth
				el1 = (angle+(ang/2)+((45/2)*2.pow(pl1/12))).wrap(90.neg,90);
		pl1=(pl1+1).mod(13);

		sph1=Spherical(1,(az1.degrad),(el1.degrad)).theta.round(0.00001);

	};

elevation=(13).collect{

				az2 = (angle+ang+(45*2.pow(pl2/12))).wrap(180.neg,180);  // Increment azimuth
			el2 = (angle+(ang/2)+((45/2)*2.pow(pl2/12))).wrap(90.neg,90);
		pl2=(pl2+1).mod(13);

		sph2=Spherical(1,(az2.degrad),(el2.degrad)).phi.round(0.00001);

	};

magnitudex=(13).collect{

			az3 = (angle+ang+(45*2.pow(pl3/12))).wrap(180.neg,180);  // Increment azimuth
			el3 = (angle+(ang/2)+ ((45/2)*2.pow(pl3/12))).wrap(90.neg,90);
		pl3=(pl3+1).mod(13);

	sph3=Spherical(1,(az3.degrad),(el3.degrad));
	 /*mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;
*/
////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis

		mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
			cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		 	Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/
		 	2).neg,(pi/2)))).rho*
		 Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

};

magnitudey=(13).collect{

			az4 = (angle+ang+(45*2.pow(pl4/12))).wrap(180.neg,180);  // Increment azimuth
			el4 = (angle+(ang/2)+((45/2)*2.pow(pl4/12))).wrap(90.neg,90);
		pl4=(pl4+1).mod(13);

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

			az5 = (angle+ang+(45*2.pow(pl5/12))).wrap(180.neg,180);  // Increment azimuth
				el5 = (angle+(ang/2)+((45/2)*2.pow(pl5/12))).wrap(90.neg,90);
		pl5=(pl5+1).mod(13);

		sph5=Spherical(1,(az5.degrad),(el5.degrad));

if(
m_z.even,
mag_z=Complex(cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho,
mag_z=Complex(sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho
	);
////z axis   ambi..  sin for odd numbers, cos for even

			};ang=(ang+45).wrap(0,360);az=az++azimuth;el=el++elevation;magx=magx++magnitudex;magy=magy++magnitudey;magz=magz++magnitudez;

};angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);~az=~az++az;~el=~el++el;~magx=~magx++magx;~magy=~magy++magy;~magz=~magz++magz;

				13.do{ num=num+1; ~dur=~dur++durx.[num]++dury.[num]++durz.[num];};num=1.neg;
			};
}.value;
(
~magx=~magx/(2.sqrt);
~magy=~magy/(2.sqrt);
~magz=~magz/(2.sqrt);
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
			~az=[];~el=[];~magx=[];~magy=[];~magz=[];~dur=[];

		360.do{
durx=(12).collect{
			azx = (angle+(360*2.pow(plx/12))).wrap(180.neg,180);  // Increment azimuth
				elx = (angle+(180*2.pow(plx/12))).wrap(90.neg,90);
		plx=(plx+1).mod(12);

					sphx=Spherical(1,(azx.degrad),(elx.degrad)).x.round(0.000000001).abs;

	};

dury=(12).collect{
		azy = (angle+(360*2.pow(ply/12))).wrap(180.neg,180);  // Increment azimuth
			ely = (angle+(180*2.pow(ply/12))).wrap(90.neg,90);
		ply=(ply+1).mod(12);

		sphy=Spherical(1,(azy.degrad),(ely.degrad)).y.round(0.000000001).abs;

	};
durz=(12).collect{
			azz = (angle+(360*2.pow(plz/12))).wrap(180.neg,180);  // Increment azimuth
				elz = (angle+(180*2.pow(plz/12))).wrap(90.neg,90);
		plz=(plz+1).mod(12);

		sphz=Spherical(1,(azz.degrad),(elz.degrad)).z.round(0.000000001).abs;

	};

azimuth=(12).collect{

			az1 = (angle+(360*2.pow(pl1/12))).wrap(180.neg,180);  // Increment azimuth
				el1 = (angle+(180*2.pow(pl1/12))).wrap(90.neg,90);
		pl1=(pl1+1).mod(12);

		sph1=Spherical(1,(az1.degrad),(el1.degrad)).theta.round(0.00001);

	};

elevation=(12).collect{

				az2 = (angle+(360*2.pow(pl2/12))).wrap(180.neg,180);  // Increment azimuth
			el2 = (angle+(180*2.pow(pl2/12))).wrap(90.neg,90);
		pl2=(pl2+1).mod(12);

		sph2=Spherical(1,(az2.degrad),(el2.degrad)).phi.round(0.00001);

	};

magnitudex=(12).collect{

			az3 = (angle+(360*2.pow(pl3/12))).wrap(180.neg,180);  // Increment azimuth
			el3 = (angle+ (180*2.pow(pl3/12))).wrap(90.neg,90);
		pl3=(pl3+1).mod(12);

	sph3=Spherical(1,(az3.degrad),(el3.degrad));
	 /*mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;
*/
////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis

		mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
			cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		 	Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/
		 	2).neg,(pi/2)))).rho*
		 Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

};

magnitudey=(12).collect{

			az4 = (angle+(360*2.pow(pl4/12))).wrap(180.neg,180);  // Increment azimuth
			el4 = (angle+(180*2.pow(pl4/12))).wrap(90.neg,90);
		pl4=(pl4+1).mod(12);

	sph4=Spherical(1,(az4.degrad),(el4.degrad));

	mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),
		sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/
		2)))).rho)*sph4.rho;
//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
};

magnitudez=(12).collect{

			az5 = (angle+(360*2.pow(pl5/12))).wrap(180.neg,180);  // Increment azimuth
				el5 = (angle+(180*2.pow(pl5/12))).wrap(90.neg,90);
		pl5=(pl5+1).mod(12);

		sph5=Spherical(1,(az5.degrad),(el5.degrad));

if(
m_z.even,
mag_z=Complex(cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho,
mag_z=Complex(sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho
	);
////z axis   ambi..  sin for odd numbers, cos for even

};angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);~az=~az++azimuth;~el=~el++elevation;~magx=~magx++magnitudex;~magy=~magy++magnitudey;~magz=~magz++magnitudez;

				12.do{ num=num+1; ~dur=~dur++durx.[num]++dury.[num]++durz.[num];};num=1.neg;};
}.value;
(
~magx=~magx/(2.sqrt);
~magy=~magy/(2.sqrt);
~magz=~magz/(2.sqrt);
 );
);
~dur=~dur*2;


		//////////////////////wavetable
		{
var signal,wt,m=0,amp;

~level=90.collect{m=m+1;amp=m.reciprocal};
~phase=90.collect{pi};
signal=Signal.sineFill(1024,~level,~phase);

wt = signal.asWavetable;
~t.loadCollection(wt);
//signal.plot;
		}.value;

		//////notes
	({
		var angle=0;
		~angle=(360*12).collect{
		angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
		}
		}.value;
	~angle1=~angle/2;
	);


/////synths////
	(
(
SynthDef.new(\ospace1, {
	arg amp=1,pl1=1;
	var phase,osc1,osc2,osc3,sphere,amp1,amp2,amp3,decay=4,pl2=0,envp,octave=4;
	var ton1,ton2,ton3;
	var fundamental;
	var freq,pitch1,pitch2,pitch3,env;
	var pitch;
	var n1,n2,n3,rq1,rq2,rq3;
	var mag,magx,magy,magz;
				var sig,rq;
					var ratio1,ratio2,ratio3;
		var scale,nn=49.neg;

			// var wrappedOut1 = { |busArray, signalArray|
			// 	[busArray, signalArray].flop.do { |pair|
			// Out.ar(pair[0], pair[1])}};
			// var wrappedOut2 = { |busArray, signalArray|
			// 	[busArray, signalArray].flop.do { |pair|
			// Out.ar(pair[0], pair[1])}};
			// var wrappedOut3 = { |busArray, signalArray|
			// 	[busArray, signalArray].flop.do { |pair|
			// Out.ar(pair[0], pair[1])}};
			// var out1 = NamedControl.kr(\out1, [0, 1, 2, 3]);  // multiple buses!
//	var out2 = NamedControl.kr(\out2, [0, 1, 2, 3, 4, 5]);  // multiple buses!
//	var out3 = NamedControl.kr(\out3, [0, 1, 2, 3, 4, 5]);  // multiple buses!

//mag=Cartesian(Select.kr(pl1,~magx), Select.kr(pl1,~magy),Select.kr(pl1,~magz));
				magx=Cartesian(Select.kr(pl1,~magx), 0,0);
				magy=Cartesian(0, Select.kr(pl1,~magy),0);
				magz=Cartesian(0, 0,Select.kr(pl1,~magz));

				//env=EnvGen.ar(Env.adsr(0.05,0.5,0.5,decay),gate,doneAction:2,levelScale:0.1);
				env=EnvGen.ar(Env.perc(0.01,decay,amp),doneAction:2,levelScale:0.1 );
				//env=EnvGen.ar(Env.sine(decay,amp),doneAction:2,levelScale:1/10);
//
//fundamental=(12*6);
				scale=97.collect{nn=nn+1;Scale.major.performDegreeToKey(nn,12)};

fundamental=(12*128);
freq=(fundamental*octave);

sphere=Spherical(48,Select.kr(pl1,~az),Select.kr(pl1,~el));

n1=(sphere.x).round(0.00000001); n2=(sphere.y).round(0.00000001); n3=(sphere.z).round(0.00000005);

//ton1=n1.abs;ton2=n2.abs;ton3=n3.abs;
//ton1=2.pow(n1.round(1)/12);ton2=2.pow(n2.round(1)/12);ton3=2.pow(n3.round(1)/12);

ratio1=n1.round(1);ratio2=n2.round(1);ratio3=n3.round(1);

				ton1=2.pow(Select.kr(ratio1,scale)/12);
				ton2=2.pow(Select.kr(ratio2,scale)/12);
					ton3=2.pow(Select.kr(ratio3,scale)/12);

amp1=(ton1.reciprocal*octave.reciprocal).round(0.00000001);
amp2=(ton2.reciprocal*octave.reciprocal).round(0.00000001);
amp3=(ton3.reciprocal*octave.reciprocal).round(0.00000001);

	pitch1=(freq*ton1).round(0.0000001);
	pitch2=(freq*ton2).round(0.0000001);
	pitch3=(freq*ton3).round(0.0000001);

				sig= InFeedback.ar(4,1);
				//rq=MouseX.kr(0.000001,1);
		/*	rq1=0.1;
				rq2=0.1;
				rq3=0.1;*/
				rq1=In.kr(0);
				rq2=In.kr(1);
				rq3=In.kr(2);
				/*	rq1=MouseX.kr(0.0000001,0.1);
				rq2=MouseX.kr(0.0000001,0.1);
				rq3=MouseX.kr(0.0000001,0.1);
*/

osc1=VBAP.ar(4,
					BPF.ar(sig, pitch1, rq1, mul: amp1 * magx.rho.round(0.00000001) * (rq1.sqrt.reciprocal)),
~b.bufnum,
//sphere.theta.raddeg,sphere.phi.raddeg
Osc.ar(~t.bufnum,1/2,phase:sphere.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
Osc.ar(~t.bufnum,1,phase:sphere.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);

osc2=VBAP.ar(4,
					BPF.ar(sig,pitch2,rq2,mul:amp2*magy.rho.round(0.00000001)* (rq2.sqrt.reciprocal)),
~b.bufnum,
//sphere.theta.raddeg,sphere.phi.raddeg
Osc.ar(~t.bufnum,1,phase:sphere.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
Osc.ar(~t.bufnum,1,phase:sphere.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);

osc3=VBAP.ar(4,
						BPF.ar(sig,pitch3,rq3,mul:amp3*magz.rho.round(0.00000001)* (rq3.sqrt.reciprocal)),
~b.bufnum,
//sphere.theta.raddeg,sphere.phi.raddeg
Osc.ar(~t.bufnum,1,phase:sphere.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
Osc.ar(~t.bufnum,1,phase:sphere.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);

	//wrappedOut3.value(out1,LeakDC.ar(osc3,mul:env));
					Out.ar(0,LeakDC.ar(osc3,mul:env));

	//	wrappedOut2.value(out1,LeakDC.ar(osc2,mul:env));
					Out.ar(0,LeakDC.ar(osc2,mul:env));

		//wrappedOut1.value(out1,LeakDC.ar(osc1,mul:env));
					Out.ar(0,LeakDC.ar(osc1,mul:env));

}).add;
);
		(
SynthDef.new(\ospace2, {
	arg amp=1,pl1=1;
	var phase,osc1,osc2,osc3,sphere,amp1,amp2,amp3,decay=4,pl2=0,envp,octave=4;
	var ton1,ton2,ton3;
	var fundamental;
	var freq,pitch1,pitch2,pitch3,env;
	var pitch;
	var n1,n2,n3,rq1,rq2,rq3;
	var mag,magx,magy,magz;
				var sig,rq;
					var ratio1,ratio2,ratio3;
		var scale,nn=49.neg;

			// var wrappedOut1 = { |busArray, signalArray|
			// 	[busArray, signalArray].flop.do { |pair|
			// Out.ar(pair[0], pair[1])}};
			// var wrappedOut2 = { |busArray, signalArray|
			// 	[busArray, signalArray].flop.do { |pair|
			// Out.ar(pair[0], pair[1])}};
			// var wrappedOut3 = { |busArray, signalArray|
			// 	[busArray, signalArray].flop.do { |pair|
			// Out.ar(pair[0], pair[1])}};
			// var out1 = NamedControl.kr(\out1, [0, 1, 2, 3]);  // multiple buses!
//	var out2 = NamedControl.kr(\out2, [0, 1, 2, 3, 4, 5]);  // multiple buses!
//	var out3 = NamedControl.kr(\out3, [0, 1, 2, 3, 4, 5]);  // multiple buses!

//mag=Cartesian(Select.kr(pl1,~magx), Select.kr(pl1,~magy),Select.kr(pl1,~magz));
				magx=Cartesian(Select.kr(pl1,~magx), 0,0);
				magy=Cartesian(0, Select.kr(pl1,~magy),0);
				magz=Cartesian(0, 0,Select.kr(pl1,~magz));

				//env=EnvGen.ar(Env.adsr(0.05,0.5,0.5,decay),gate,doneAction:2,levelScale:0.1);
				env=EnvGen.ar(Env.perc(0.01,decay,amp),doneAction:2,levelScale:0.1 );
				//env=EnvGen.ar(Env.sine(decay,amp),doneAction:2,levelScale:1/10);

//fundamental=(12*6);
				scale=97.collect{nn=nn+1;Scale.major.performDegreeToKey(nn,12)};

fundamental=(12*128);
freq=(fundamental*octave);

sphere=Spherical(48,Select.kr(pl1,~az),Select.kr(pl1,~el));

n1=(sphere.x).round(0.00000001); n2=(sphere.y).round(0.00000001); n3=(sphere.z).round(0.00000005);

//ton1=n1.abs;ton2=n2.abs;ton3=n3.abs;
//ton1=2.pow(n1.round(1)/12);ton2=2.pow(n2.round(1)/12);ton3=2.pow(n3.round(1)/12);

ratio1=n1.round(1);ratio2=n2.round(1);ratio3=n3.round(1);

		ton1 = 2.pow(Select.kr(ratio1.linlin(-48, 48, 0, 97), scale) / 12);
ton2 = 2.pow(Select.kr(ratio2.linlin(-48, 48, 0, 97), scale) / 12);
ton3 = 2.pow(Select.kr(ratio3.linlin(-48, 48, 0, 97), scale) / 12);

amp1=(ton1.reciprocal*octave.reciprocal).round(0.00000001);
amp2=(ton2.reciprocal*octave.reciprocal).round(0.00000001);
amp3=(ton3.reciprocal*octave.reciprocal).round(0.00000001);

	pitch1=(freq*ton1).round(0.0000001);
	pitch2=(freq*ton2).round(0.0000001);
	pitch3=(freq*ton3).round(0.0000001);

				sig= InFeedback.ar(5,1);
				//rq=MouseX.kr(0.000001,1);
		/*	rq1=0.1;
				rq2=0.1;
				rq3=0.1;*/
				rq1=In.kr(0);
				rq2=In.kr(1);
				rq3=In.kr(2);
				/*	rq1=MouseX.kr(0.0000001,0.1);
				rq2=MouseX.kr(0.0000001,0.1);
				rq3=MouseX.kr(0.0000001,0.1);
*/

osc1=VBAP.ar(4,
					BPF.ar(sig, pitch1, rq1, mul: amp1 * magx.rho.round(0.00000001) * (rq1.sqrt.reciprocal)),
~b.bufnum,
//sphere.theta.raddeg,sphere.phi.raddeg
Osc.ar(~t.bufnum,1,phase:sphere.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
Osc.ar(~t.bufnum,1,phase:sphere.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);

osc2=VBAP.ar(4,
					BPF.ar(sig,pitch2,rq2,mul:amp2*magy.rho.round(0.00000001)* (rq2.sqrt.reciprocal)),
~b.bufnum,
sphere.theta.raddeg,sphere.phi.raddeg
//Osc.ar(~t.bufnum,1/2,phase:sphere.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
//Osc.ar(~t.bufnum,1/4,phase:sphere.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);

osc3=VBAP.ar(4,
						BPF.ar(sig,pitch3,rq3,mul:amp3*magz.rho.round(0.00000001)* (rq3.sqrt.reciprocal)),
~b.bufnum,
//sphere.theta.raddeg,sphere.phi.raddeg
Osc.ar(~t.bufnum,1,phase:sphere.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
Osc.ar(~t.bufnum,1,phase:sphere.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);

	//wrappedOut3.value(out1,LeakDC.ar(osc3,mul:env));
					Out.ar(0,LeakDC.ar(osc3,mul:env));

	//	wrappedOut2.value(out1,LeakDC.ar(osc2,mul:env));
					Out.ar(0,LeakDC.ar(osc2,mul:env));

		//wrappedOut1.value(out1,LeakDC.ar(osc1,mul:env));
					Out.ar(0,LeakDC.ar(osc1,mul:env));

}).add;
);
);

////////////list
	({
		var n=1.neg;
		~list1=(360*13).collect{
		n=n+1;
		}
		}.value
	);
///pattern
	(

~aa=Pdef(\1, Pbind(\instrument, \ospace1,
			\dur,Pseq(~dur,1),
			//\dur,1,
			\pl1,Pbrown(1,4320,12,inf),
	/*\pl1,Pseq([
				Prand(
				[Pseq(Array.rand(3,1,12),1),Pseq(Array.rand(3,13,25),1),Pseq(Array.rand(3,26,38),1),Pseq(Array.rand(3,39,51),1),
				Pseq(Array.rand(3,52,64),1),Pseq(Array.rand(3,65,77),1),Pseq(Array.rand(3,78,90),1),Pseq(Array.rand(3,91,103),1)]
				,1),
				Prand(
				[Pseq(Array.rand(3,104,116),1),Pseq(Array.rand(3,117,129),1),Pseq(Array.rand(3,130,142),1),Pseq(Array.rand(3,143,155),1),
				Pseq(Array.rand(3,156,168),1),Pseq(Array.rand(3,169,181),1),Pseq(Array.rand(3,182,194),1),Pseq(Array.rand(3,195,207),1)]
				,1),
				Prand(
				[Pseq(Array.rand(3,208,220),1),Pseq(Array.rand(3,221,233),1),Pseq(Array.rand(3,234,246),1),Pseq(Array.rand(3,247,259),1),
				Pseq(Array.rand(3,260,272),1),Pseq(Array.rand(3,273,285),1),Pseq(Array.rand(3,286,298),1),Pseq(Array.rand(3,299,311),1)]
				,1),
				Prand(
				[Pseq(Array.rand(3,312,324),1),Pseq(Array.rand(3,325,337),1),Pseq(Array.rand(3,338,350),1),Pseq(Array.rand(3,351,363),1),
				Pseq(Array.rand(3,364,376),1),Pseq(Array.rand(3,377,389),1),Pseq(Array.rand(3,390,401),1),Pseq(Array.rand(3,403,415),1)]
				,1),
				Prand(
				[Pseq(Array.rand(3,416,428),1),Pseq(Array.rand(3,429,441),1),Pseq(Array.rand(3,442,454),1),Pseq(Array.rand(3,455,467),1),
				Pseq(Array.rand(3,468,480),1),Pseq(Array.rand(3,481,493),1),Pseq(Array.rand(3,494,506),1),Pseq(Array.rand(3,507,519),1)]
				,1),
				Prand(
				[Pseq(Array.rand(3,520,532),1),Pseq(Array.rand(3,533,545),1),Pseq(Array.rand(3,546,558),1),Pseq(Array.rand(3,559,571),1),
				Pseq(Array.rand(3,572,584),1),Pseq(Array.rand(3,585,597),1),Pseq(Array.rand(3,598,610),1),Pseq(Array.rand(3,611,623),1)]
				,1),
				Prand(
				[Pseq(Array.rand(3,624,636),1),Pseq(Array.rand(3,637,649),1),Pseq(Array.rand(3,650,662),1),Pseq(Array.rand(3,663,675),1),
				Pseq(Array.rand(3,676,688),1),Pseq(Array.rand(3,689,701),1),Pseq(Array.rand(3,702,714),1),Pseq(Array.rand(3,715,727),1)]
				,1),
				Prand(
				[Pseq(Array.rand(3,728,740),1),Pseq(Array.rand(3,741,753),6,1),Pseq(Array.rand(3,754,766),1),Pseq(Array.rand(3,767,779),1),
				Pseq(Array.rand(3,780,792),1),Pseq(Array.rand(3,793,805),1),Pseq(Array.rand(3,806,818),1),Pseq(Array.rand(3,819,831),1)]
				,1)
			],inf),*/
			//\pl1,Pseq(~list1,inf),
		//\out1,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
		//	\out2,Pn(Pshuf([0, 1, 2, 3, 4, 5], 1), inf).clump(6).collect([_]),
		//	\out3,Pn(Pshuf([0, 1, 2, 3, 4, 5], 1), inf).clump(6).collect([_]),
			//\amp,Pseq(~r,inf);///l system
			\amp,1;
));

~aaa=Pdef(\2, Pbind(\instrument, \ospace2,
		\dur,Pseq(~dur,1),
		//\dur,1.5,
			/*\pl1,Pseq([
				Prand(
				[Pseq(Array.rand(3,1,12),1),Pseq(Array.rand(3,13,25),1),Pseq(Array.rand(3,26,38),1),Pseq(Array.rand(3,39,51),1),
				Pseq(Array.rand(3,52,64),1),Pseq(Array.rand(3,65,77),1),Pseq(Array.rand(3,78,90),1),Pseq(Array.rand(3,91,103),1)]
				,1),
				Prand(
				[Pseq(Array.rand(3,104,116),1),Pseq(Array.rand(3,117,129),1),Pseq(Array.rand(3,130,142),1),Pseq(Array.rand(3,143,155),1),
				Pseq(Array.rand(3,156,168),1),Pseq(Array.rand(3,169,181),1),Pseq(Array.rand(3,182,194),1),Pseq(Array.rand(3,195,207),1)]
				,1),
				Prand(
				[Pseq(Array.rand(3,208,220),1),Pseq(Array.rand(3,221,233),1),Pseq(Array.rand(3,234,246),1),Pseq(Array.rand(3,247,259),1),
				Pseq(Array.rand(3,260,272),1),Pseq(Array.rand(3,273,285),1),Pseq(Array.rand(3,286,298),1),Pseq(Array.rand(3,299,311),1)]
				,1),
				Prand(
				[Pseq(Array.rand(3,312,324),1),Pseq(Array.rand(3,325,337),1),Pseq(Array.rand(3,338,350),1),Pseq(Array.rand(3,351,363),1),
				Pseq(Array.rand(3,364,376),1),Pseq(Array.rand(3,377,389),1),Pseq(Array.rand(3,390,401),1),Pseq(Array.rand(3,403,415),1)]
				,1),
				Prand(
				[Pseq(Array.rand(3,416,428),1),Pseq(Array.rand(3,429,441),1),Pseq(Array.rand(3,442,454),1),Pseq(Array.rand(3,455,467),1),
				Pseq(Array.rand(3,468,480),1),Pseq(Array.rand(3,481,493),1),Pseq(Array.rand(3,494,506),1),Pseq(Array.rand(3,507,519),1)]
				,1),
				Prand(
				[Pseq(Array.rand(3,520,532),1),Pseq(Array.rand(3,533,545),1),Pseq(Array.rand(3,546,558),1),Pseq(Array.rand(3,559,571),1),
				Pseq(Array.rand(3,572,584),1),Pseq(Array.rand(3,585,597),1),Pseq(Array.rand(3,598,610),1),Pseq(Array.rand(3,611,623),1)]
				,1),
				Prand(
				[Pseq(Array.rand(3,624,636),1),Pseq(Array.rand(3,637,649),1),Pseq(Array.rand(3,650,662),1),Pseq(Array.rand(3,663,675),1),
				Pseq(Array.rand(3,676,688),1),Pseq(Array.rand(3,689,701),1),Pseq(Array.rand(3,702,714),1),Pseq(Array.rand(3,715,727),1)]
				,1),
				Prand(
				[Pseq(Array.rand(3,728,740),1),Pseq(Array.rand(3,741,753),6,1),Pseq(Array.rand(3,754,766),1),Pseq(Array.rand(3,767,779),1),
				Pseq(Array.rand(3,780,792),1),Pseq(Array.rand(3,793,805),1),Pseq(Array.rand(3,806,818),1),Pseq(Array.rand(3,819,831),1)]
				,1)
			],inf),*/

			\pl1,Pbrown(1,4320,12,inf),
			//\pl1,Pseq(~list1,inf),
		//\out1,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
		//	\out2,Pn(Pshuf([0, 1, 2, 3, 4, 5], 1), inf).clump(6).collect([_]),
		//	\out3,Pn(Pshuf([0, 1, 2, 3, 4, 5], 1), inf).clump(6).collect([_]),
			\amp,Pseq(~r,inf);///l system
			//\amp,1;
));
);

~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/bpf samples/red sparrows.wav",channels:0);
~c2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/bpf samples/red sparrows.wav",channels:0);
	TempoClock.default.tempo_(1);

	~m=Buffer.alloc(s,2048);
			{
var signal,wt,env;

		env=Env([0.0001,0.0001,0.05,0.1,0.1,0.05,0.0001,0.0001],[40,30,20,10,20,30,40],[0,12,-4,0,4,-12,0]);
		signal=env.asSignal(1024);
wt=signal.asWavetable;
		//signal.plot;
~m.loadCollection(wt);
		}.value;

(
~synth=(
SynthDef.new(\obuff, {
	arg buffer=0;
	var sig1,sig2,env,gain=1;

			//env= EnvGen.ar(Env.sine(10),doneAction:2);

			sig1=PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1.bufnum),startPos:0, loop: 1, doneAction:2);
			sig2=PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2.bufnum),startPos:0, loop: 1, doneAction:2);


			Out.ar(4,sig1*gain);
				Out.ar(5,sig2*gain);
				Out.kr(0,Osc.kr(~m.bufnum,0.01,phase:0.degrad));
				Out.kr(1,Osc.kr(~m.bufnum,0.01,phase:10.degrad));
				Out.kr(2,Osc.kr(~m.bufnum,0.01,phase:20.degrad));


}).add;
);
);

}
)

Buffer.freeAll;


TempoClock.default.tempo_(8/1);




(
~aa.play;
~aaa.play;
		Synth(\obuff);
);

s.record(numChannels:4);
