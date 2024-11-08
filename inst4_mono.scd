(
Server.default = s = Server.local;
////server setup
(
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=1;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(0.5);
s.options.memSize = 8192*32;
s.options.blockSize = 64*8;
s.options.maxNodes = 1024 * 16;
s.options.sampleRate= 48000;
);

s.waitForBoot{
/////wavetables
Buffer.freeAll;

(
~w1= Buffer.alloc(s,2048);
~w2= Buffer.alloc(s,2048);
~w3= Buffer.alloc(s,2048);
~t= Buffer.alloc(s,2048);
);

////////////////////////////////////speaker setup///other

///////////////////////////////////////////////////////arrays
///////fractal
		~time=1;
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
var  sph1,sph2,sph3,sph4,sph5,m_x=3,m_y=2,m_z=1;
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

{
var  sph1,sph2,sph3,sph4,sph5,m_x=7,m_y=7,m_z=7;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;

~magx7 = (720*~time).collect{
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
~magy7 = (720*~time).collect{
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

~magz7 = (720*~time).collect{
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
var  sph1,sph2,sph3,sph4,sph5,m_x=8,m_y=8,m_z=8;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;

~magx8 = (720*~time).collect{
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

~magy8 = (720*~time).collect{
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

~magz8 = (720*~time).collect{
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
var  sph1,sph2,sph3,sph4,sph5,m_x=9,m_y=9,m_z=9;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;

~magx9 = (720*~time).collect{
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

~magy9 = (720*~time).collect{
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

~magz9 = (720*~time).collect{
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
var  sph1,sph2,sph3,sph4,sph5,m_x=10,m_y=10,m_z=10;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;

~magx10 = (720*~time).collect{
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

~magy10 = (720*~time).collect{
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

~magz10 = (720*~time).collect{
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
var  sph1,sph2,sph3,sph4,sph5,m_x=11,m_y=11,m_z=11;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;

~magx11 = (720*~time).collect{
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

~magy11 = (720*~time).collect{
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

~magz11 = (720*~time).collect{
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
var  sph1,sph2,sph3,sph4,sph5,m_x=12,m_y=12,m_z=12;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;

~magx12 = (720*~time).collect{
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

~magy12 = (720*~time).collect{
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

~magz12 = (720*~time).collect{
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
~magx7=(~magx1/(2.sqrt)).round(0.0000000000001);
~magy7=(~magy1/(2.sqrt)).round(0.0000000000001);
~magz7=(~magz1/(2.sqrt)).round(0.0000000000001);
~magx8=(~magx2/(2.sqrt)).round(0.0000000000001);
~magy8=(~magy2/(2.sqrt)).round(0.0000000000001);
~magz8=(~magz2/(2.sqrt)).round(0.0000000000001);
~magx9=(~magx3/(2.sqrt)).round(0.0000000000001);
~magy9=(~magy3/(2.sqrt)).round(0.0000000000001);
~magz9=(~magz3/(2.sqrt)).round(0.0000000000001);
~magx10=(~magx4/(2.sqrt)).round(0.0000000000001);
~magy10=(~magy4/(2.sqrt)).round(0.0000000000001);
~magz10=(~magz4/(2.sqrt)).round(0.0000000000001);
~magx11=(~magx5/(2.sqrt)).round(0.0000000000001);
~magy11=(~magy5/(2.sqrt)).round(0.0000000000001);
~magz11=(~magz5/(2.sqrt)).round(0.0000000000001);
~magx12=(~magx6/(2.sqrt)).round(0.0000000000001);
~magy12=(~magy6/(2.sqrt)).round(0.0000000000001);
~magz12=(~magz6/(2.sqrt)).round(0.0000000000001);

~magx_array=[~magx1.round(0.00001),~magx2.round(0.00001),~magx3.round(0.00001),~magx4.round(0.00001),~magx5.round(0.00001),~magx6.round(0.00001),
			~magx7.round(0.00001),~magx8.round(0.00001),~magx9.round(0.00001),~magx10.round(0.00001),~magx11.round(0.00001),~magx12.round(0.00001)];

~magy_array=[~magy1.round(0.00001),~magy2.round(0.00001),~magy3.round(0.00001),~magy4.round(0.00001),~magy5.round(0.00001),~magy6.round(0.00001),
			~magy7.round(0.00001),~magy8.round(0.00001),~magy9.round(0.00001),~magy10.round(0.00001),~magy11.round(0.00001),~magy12.round(0.00001)];

~magz_array=[~magz1.round(0.00001),~magz2.round(0.00001),~magz3.round(0.00001),~magz4.round(0.00001),~magz5.round(0.00001),~magz6.round(0.00001),
			~magz7.round(0.00001),~magz8.round(0.00001),~magz9.round(0.00001),~magz10.round(0.00001),~magz11.round(0.00001),~magz12.round(0.00001)];
);

////////////////////////////////////////////////////////notes and durs
{
var dur=2,ph1,ph2,ph3,ph4,ph5,ph6,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0,pl6=0;
var sph1,sph2,sph3,sph4,sph5,sph6,sph7,sph8,sph9;
var n1,n2,n3,n4,n5,n6,n7,n8,n9,mult=12;
var mag1,mag2,mag3,mag4,mag5,mag6,mag7,mag8,mag9,rythm;
var index1,index2,index3,index4,index5,index6,pl7=0,pl8=0,pl9=0,t1,t2,t3,t4,t5,t6;
var pl10=0,pl11=0,pl12=0,pl13=0,pl14=0,pl15=0;

///////////////////////L-system algae variable a,b rules:a=ab b=a , n3 for n0=a
rythm=[1,1/2,1,1,1/2].mirror;

~dur1 = (45*~time).collect{
	ph1=~magx.[pl1];
	index1=rythm.wrapAt(pl7);
	pl7=pl7+1;
	pl1=pl1+1;
	ph1=(ph1*dur).round(1/256);
	t1=ph1*index1;

	};

~dur2 = (45*~time).collect{
	ph2=~magy.[pl2];
	index2=rythm.wrapAt(pl8);
	pl8=pl8+1;
	pl2=pl2+1;
	ph2=(ph2*dur).round(1/256);
	t2=ph2*index2;
	};

~dur3 = (45*~time).collect{
	ph3=~magz.[pl3];
	index3=rythm.wrapAt(pl9);
	pl9=pl9+1;
	pl3=pl3+1;
	ph3=(ph3*dur).round((1/256));
	t3=ph3*index3;
	};

}.value;
		//////////////////////wavetable
		{
var signal,wt,m=0,amp;

~level=64.round(1).collect{m=m+1;amp=m.reciprocal};
~phase=64.collect{pi};
signal=Signal.sineFill(1024,~level,~phase);

wt = signal.asWavetable;
~t.loadCollection(wt);
//signal.plot;
		}.value;
(
		{
var env,sig,wt,angle=0,level,levels,pl=1.neg;

~levelsss=360.collect{

	level=exp(Complex(0,1)*angle).imag;
		angle=angle+1.degrad;
				pl=pl+1;
				//level=level;
				//levels=level.rrand(exp(Complex(0,1)*angle+((360-(360/1.6180339887499))/1000).degrad.round(0.000001)).imag);
			levels=level+(~magx.[pl]/100);
};
			env = Env(~levelsss,[1]);
sig=env.asSignal(1024);
wt = sig.asWavetable;
~w1.loadCollection(wt);
sig.plot;
}.value;
	{
var env,sig,wt,angle=0,level,levels,pl=1.neg;

~levelssss=360.collect{

	level=exp(Complex(0,1)*angle).imag;
		angle=angle+1.degrad;
				pl=pl+1;
		//level=level;
	//levels=level.rrand(exp(Complex(0,1)*angle+((360-(360/1.6180339887499))/1000).degrad.round(0.000001)).imag);
	//levels=level.rrand(exp(Complex(0,1)*angle+((360-(360/1.6180339887499))/10000).degrad).imag)+(~magy_array.[2].[pl]/10000);
			levels=level+(~magy.[pl]/100);
};
			env = Env(~levelssss,[1]);
sig=env.asSignal(1024);
wt = sig.asWavetable;
~w2.loadCollection(wt);
sig.plot;
}.value;
	{
var env,sig,wt,angle=0,level,levels,pl=1.neg;

~levelsssss=360.collect{

	level=exp(Complex(0,1)*angle).imag;
		angle=angle+1.degrad;
				pl=pl+1;
			//	level=level;
	///levels=level.rrand(exp(Complex(0,1)*angle+((360-(360/1.6180339887499))/1000).degrad.round(0.000001)).imag);
		//levels=level.rrand(exp(Complex(0,1)*angle+((360-(360/1.6180339887499))/10000).degrad).imag)+(~magy_array.[2].[pl]/10000);
			levels=level+(~magz.[pl]/100);
			};
			env = Env(~levelsssss,[1]);
sig=env.asSignal(1024);
wt = sig.asWavetable;
~w3.loadCollection(wt);
sig.plot;
}.value;
);

/////////////////////////////////////////////wt envelope sine levels
	 {
	 	var ang=0,level,levels,env,pl;
	 	~levels=180.collect{ level=exp(Complex(0,1)*ang).imag; ang=ang+1.degrad;
	levels=level.rrand(exp(Complex(0,1)*ang+((360-(360/1.6180339887499))/100).degrad).imag);};
	 }.value;

	// Env(~levels,[0.04444]).plot;

	//////notes
	({
		var angle=0;
		~angle=(45*~time).collect{
		angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
		}
		}.value
	);

/////synths////
(
SynthDef.new(\ospace1, {
	arg angle_rot=0,octave=1,cutt=440,speed1=1,speed2=1,speed3=1,decay=0.04444,pl1=0,mult=12;
	var phase,osc1,osc2,osc3,sphere,mag_o,amp1,amp2,amp3,pl2=0;
	var ton1,ton2,ton3,rq1=1,rq2=1,rq3=1,cutt_freq1=1,cutt_freq2=1,cutt_freq3=1;
	var fundamental=55,fundamental1,fundamental2,fundamental3;
	var freq1,freq2,freq3,m=1,bank1=12,bank2=1,pitch1,pitch2,pitch3,env,gate=1;
	var v,i,j,k,q;
	var pitch;
	var xyz,xyz_array,axis;
	var n1,n2,n3;
	var mag_x,mag_y,mag_z;
	var sphere1,sphere2,sphere3;
	var ph_x,ph_y,ph_z;


//env=EnvGen.ar(Env(~levels,[decay],4.neg),doneAction:2,levelScale:1/bank1);
			env=EnvGen.ar(Env.perc(0.05,6,level:1/bank1),doneAction:2);
fundamental1=fundamental*speed1.reciprocal;
fundamental2=fundamental*speed2.reciprocal;
fundamental3=fundamental*speed3.reciprocal;
freq1=(fundamental1*octave);
freq2=(fundamental2*octave);
freq3=(fundamental3*octave);

bank1.do{

bank2.do{

mag_o=Cartesian(Select.kr(pl1,~magx_array.[pl2]), Select.kr(pl1,~magy_array.[pl2]), Select.kr(pl1,~magz_array.[pl2]));

	sphere1=Spherical(Select.kr(pl1,~magx_array.[pl2]),Select.kr(pl1,~az),Select.kr(pl1,~el));
	sphere2=Spherical(Select.kr(pl1,~magy_array.[pl2]),Select.kr(pl1,~az),Select.kr(pl1,~el));
	sphere3=Spherical(Select.kr(pl1,~magz_array.[pl2]),Select.kr(pl1,~az),Select.kr(pl1,~el));
	sphere=Spherical(mag_o.rho.round(0.00000001)/(2.sqrt),Select.kr(pl1,~az),Select.kr(pl1,~el));

	xyz=Spherical(mult,sphere.theta,sphere.phi);
	xyz_array=[xyz.x.round(0.000001),xyz.y.round(0.000001),xyz.z.round(0.000001)];

v=Quaternion(0, xyz_array.[0], xyz_array.[1], xyz_array.[2]);
i=Quaternion(0, 0.57735026918963, 0, 0);
j=Quaternion(0, 0,  0.57735026918963, 0);
k=Quaternion(0, 0, 0,  0.57735026918963);
axis=(i+j+k);

q=((axis*exp(Complex(0,1)*angle_rot.degrad).imag)+exp(Complex(0,1)*angle_rot.degrad).real);

v=q*v*q.conjugate;

	pitch=Cartesian(v.b,v.c,v.d);

	n1=(pitch.x).round(0.0000000000001); n2=(pitch.y).round(0.0000000000001); n3=(pitch.z).round(0.0000000000001);

ton1=2.pow(n1/(2*6));
ton2=2.pow(n2/(2*6));
ton3=2.pow(n3/(2*6));

	mag_x=sphere.rho;
	mag_y=sphere.rho;
	mag_z=sphere.rho;

	ph_x=Complex(sphere.y,sphere.z).theta;
	ph_y=Complex(sphere.x,sphere.z).theta;
	ph_z=Complex(sphere.x,sphere.y).theta;

	    amp1=(ton1.reciprocal*speed1*octave.reciprocal*m.reciprocal).round(0.0000000000001);
		amp2=(ton2.reciprocal*speed2*octave.reciprocal*m.reciprocal).round(0.0000000000001);
		amp3=(ton3.reciprocal*speed3*octave.reciprocal*m.reciprocal).round(0.0000000000001);

	pitch1=(freq1*ton1*m).round(0.0000000000001);
	pitch2=(freq2*ton2*m).round(0.0000000000001);
	pitch3=(freq3*ton3*m).round(0.0000000000001);

					///%2==0 simulates .even
			phase=if(pl2%2==0,0.degrad,90.degrad);

		/*cutt_freq1=(freq*ton1*m).round(0.0000000000001);
		cutt_freq2=(freq*ton2*m).round(0.0000000000001);
		cutt_freq3=(freq*ton3*m).round(0.0000000000001);*/
				/////fm///+SinOsc.ar(mag_x.rho,mag_x.theta,mul:mag_x.rho.reciprocal)

osc1=Osc.ar(~w1.bufnum,pitch1*mag_x.reciprocal,mul:amp1*mag_x,phase:(phase+ph_x).wrap(2pi.neg,2pi));

					Out.ar(0,(LeakDC.ar(osc1,mul:env)));


			pl1=pl1+1;
	};
			pl2=pl2+1;
		m=m+1;

			};
}).add;
);
	(
SynthDef.new(\ospace2, {
	arg angle_rot=0,octave=1,cutt=440,speed1=1,speed2=1,speed3=1,decay=0.04444,pl1=0,mult=12;
	var phase,osc1,osc2,osc3,sphere,mag_o,amp1,amp2,amp3,pl2=0;
	var ton1,ton2,ton3,rq1=1,rq2=1,rq3=1,cutt_freq1=1,cutt_freq2=1,cutt_freq3=1;
	var fundamental=55,fundamental1,fundamental2,fundamental3;
	var freq1,freq2,freq3,m=1,bank1=12,bank2=1,pitch1,pitch2,pitch3,env,gate=1;
	var v,i,j,k,q;
	var pitch;
	var xyz,xyz_array,axis;
	var n1,n2,n3;
	var mag_x,mag_y,mag_z;
	var sphere1,sphere2,sphere3;
	var ph_x,ph_y,ph_z;


//env=EnvGen.ar(Env(~levels,[decay],4.neg),doneAction:2,levelScale:1/bank1);
			env=EnvGen.ar(Env.perc(0.05,6,level:1/bank1),doneAction:2);
fundamental1=fundamental*speed1.reciprocal;
fundamental2=fundamental*speed2.reciprocal;
fundamental3=fundamental*speed3.reciprocal;
freq1=(fundamental1*octave);
freq2=(fundamental2*octave);
freq3=(fundamental3*octave);

bank1.do{

bank2.do{

mag_o=Cartesian(Select.kr(pl1,~magx_array.[pl2]), Select.kr(pl1,~magy_array.[pl2]), Select.kr(pl1,~magz_array.[pl2]));

	sphere1=Spherical(Select.kr(pl1,~magx_array.[pl2]),Select.kr(pl1,~az),Select.kr(pl1,~el));
	sphere2=Spherical(Select.kr(pl1,~magy_array.[pl2]),Select.kr(pl1,~az),Select.kr(pl1,~el));
	sphere3=Spherical(Select.kr(pl1,~magz_array.[pl2]),Select.kr(pl1,~az),Select.kr(pl1,~el));
	sphere=Spherical(mag_o.rho.round(0.00000001)/(2.sqrt),Select.kr(pl1,~az),Select.kr(pl1,~el));

	xyz=Spherical(mult,sphere.theta,sphere.phi);
	xyz_array=[xyz.x.round(0.000001),xyz.y.round(0.000001),xyz.z.round(0.000001)];

v=Quaternion(0, xyz_array.[0], xyz_array.[1], xyz_array.[2]);
i=Quaternion(0, 0.57735026918963, 0, 0);
j=Quaternion(0, 0,  0.57735026918963, 0);
k=Quaternion(0, 0, 0,  0.57735026918963);
axis=(i+j+k);

q=((axis*exp(Complex(0,1)*angle_rot.degrad).imag)+exp(Complex(0,1)*angle_rot.degrad).real);

v=q*v*q.conjugate;

	pitch=Cartesian(v.b,v.c,v.d);

	n1=(pitch.x).round(0.0000000000001); n2=(pitch.y).round(0.0000000000001); n3=(pitch.z).round(0.0000000000001);

ton1=2.pow(n1/(2*6));
ton2=2.pow(n2/(2*6));
ton3=2.pow(n3/(2*6));

	mag_x=sphere.rho;
	mag_y=sphere.rho;
	mag_z=sphere.rho;

	ph_x=Complex(sphere.y,sphere.z).theta;
	ph_y=Complex(sphere.x,sphere.z).theta;
	ph_z=Complex(sphere.x,sphere.y).theta;

	    amp1=(speed1*octave.reciprocal*m.reciprocal).round(0.0000000000001);
		amp2=(speed2*octave.reciprocal*m.reciprocal).round(0.0000000000001);
		amp3=(speed3*octave.reciprocal*m.reciprocal).round(0.0000000000001);

	pitch1=(freq1*m).round(0.0000000000001);
	pitch2=(freq2*m).round(0.0000000000001);
	pitch3=(freq3*m).round(0.0000000000001);

					///%2==0 simulates .even
			phase=if(pl2%2==0,0.degrad,90.degrad);

		/*cutt_freq1=(freq*ton1*m).round(0.0000000000001);
		cutt_freq2=(freq*ton2*m).round(0.0000000000001);
		cutt_freq3=(freq*ton3*m).round(0.0000000000001);*/
				/////fm///+SinOsc.ar(mag_x.rho,mag_x.theta,mul:mag_x.rho.reciprocal)

osc2=Osc.ar(~w2.bufnum,pitch2*mag_y.reciprocal,mul:amp2*mag_y,phase:(phase+ph_y).wrap(2pi.neg,2pi));

						Out.ar(0,(LeakDC.ar(osc2,mul:env)));

			pl1=pl1+1;
	};
			pl2=pl2+1;
		m=m+1;

			};
}).add;
);
	(
SynthDef.new(\ospace3, {
	arg angle_rot=0,octave=1,cutt=440,speed1=1,speed2=1,speed3=1,decay=0.04444,pl1=0,mult=12;
	var phase,osc1,osc2,osc3,sphere,mag_o,amp1,amp2,amp3,pl2=0;
	var ton1,ton2,ton3,rq1=1,rq2=1,rq3=1,cutt_freq1=1,cutt_freq2=1,cutt_freq3=1;
	var fundamental=55,fundamental1,fundamental2,fundamental3;
	var freq1,freq2,freq3,m=1,bank1=12,bank2=1,pitch1,pitch2,pitch3,env,gate=1;
	var v,i,j,k,q;
	var pitch;
	var xyz,xyz_array,axis;
	var n1,n2,n3;
	var mag_x,mag_y,mag_z;
	var sphere1,sphere2,sphere3;
	var ph_x,ph_y,ph_z;

		//env=EnvGen.ar(Env(~levels,[decay],4.neg),doneAction:2,levelScale:1/bank1);
			env=EnvGen.ar(Env.perc(0.05,6,level:1/bank1),doneAction:2);
fundamental1=fundamental*speed1.reciprocal;
fundamental2=fundamental*speed2.reciprocal;
fundamental3=fundamental*speed3.reciprocal;
freq1=(fundamental1*octave);
freq2=(fundamental2*octave);
freq3=(fundamental3*octave);

bank1.do{

bank2.do{

mag_o=Cartesian(Select.kr(pl1,~magx_array.[pl2]), Select.kr(pl1,~magy_array.[pl2]), Select.kr(pl1,~magz_array.[pl2]));

	sphere1=Spherical(Select.kr(pl1,~magx_array.[pl2]),Select.kr(pl1,~az),Select.kr(pl1,~el));
	sphere2=Spherical(Select.kr(pl1,~magy_array.[pl2]),Select.kr(pl1,~az),Select.kr(pl1,~el));
	sphere3=Spherical(Select.kr(pl1,~magz_array.[pl2]),Select.kr(pl1,~az),Select.kr(pl1,~el));
	sphere=Spherical(mag_o.rho.round(0.00000001)/(2.sqrt),Select.kr(pl1,~az),Select.kr(pl1,~el));

	xyz=Spherical(mult,sphere.theta,sphere.phi);
	xyz_array=[xyz.x.round(0.000001),xyz.y.round(0.000001),xyz.z.round(0.000001)];

v=Quaternion(0, xyz_array.[0], xyz_array.[1], xyz_array.[2]);
i=Quaternion(0, 0.57735026918963, 0, 0);
j=Quaternion(0, 0,  0.57735026918963, 0);
k=Quaternion(0, 0, 0,  0.57735026918963);
axis=(i+j+k);

q=((axis*exp(Complex(0,1)*angle_rot.degrad).imag)+exp(Complex(0,1)*angle_rot.degrad).real);

v=q*v*q.conjugate;

	pitch=Cartesian(v.b,v.c,v.d);

	n1=(pitch.x).round(0.0000000000001); n2=(pitch.y).round(0.0000000000001); n3=(pitch.z).round(0.0000000000001);

ton1=2.pow(n1/(2*6));
ton2=2.pow(n2/(2*6));
ton3=2.pow(n3/(2*6));

	mag_x=sphere.rho;
	mag_y=sphere.rho;
	mag_z=sphere.rho;

	ph_x=Complex(sphere.y,sphere.z).theta;
	ph_y=Complex(sphere.x,sphere.z).theta;
	ph_z=Complex(sphere.x,sphere.y).theta;

	    amp1=(ton1.reciprocal*speed1*octave.reciprocal*m.reciprocal).round(0.0000000000001);
		amp2=(ton2.reciprocal*speed2*octave.reciprocal*m.reciprocal).round(0.0000000000001);
		amp3=(ton3.reciprocal*speed3*octave.reciprocal*m.reciprocal).round(0.0000000000001);

	pitch1=(freq1*ton1*m).round(0.0000000000001);
	pitch2=(freq2*ton2*m).round(0.0000000000001);
	pitch3=(freq3*ton3*m).round(0.0000000000001);

					///%2==0 simulates .even
			phase=if(pl2%2==0,0.degrad,90.degrad);

		/*cutt_freq1=(freq*ton1*m).round(0.0000000000001);
		cutt_freq2=(freq*ton2*m).round(0.0000000000001);
		cutt_freq3=(freq*ton3*m).round(0.0000000000001);*/
				/////fm///+SinOsc.ar(mag_x.rho,mag_x.theta,mul:mag_x.rho.reciprocal)

osc3=Osc.ar(~w3.bufnum,pitch3*mag_z.reciprocal,mul:amp3*mag_z,phase:(phase+ph_z).wrap(2pi.neg,2pi));

						Out.ar(0,(LeakDC.ar(osc3,mul:env)));

			pl1=pl1+1;
	};
			pl2=pl2+1;
		m=m+1;

			};
}).add;
);


////////////list
	({
		var n=1.neg;
		~list=(720*~time).collect{
		n=n+1;
		}
		}.value
	);

//////////pattern for mobius strib of sequential or parallel play of directions
(
~aa=Pdef(\1, Pbind(\instrument, \ospace1,
	\dur,Pseq(~dur1.mirror,1),
		//\octave,Prand([1,2,4],inf),
			\pl1,Pxrand(~list,inf),
	\angle_rot,Pseq(~angle.mirror,inf),
	\speed1,Prand([1,3/4,2/3,1/2],inf),
		\speed2,Prand([1,3/4,2/3,1/2],inf),
		\speed3,Prand([1,3/4,2/3,1/2],inf);
));
~bb=Pdef(\2, Pbind(\instrument, \ospace2,
	\dur,Pseq(~dur2.mirror,1),
			//\octave,Prand([1,2,4],inf),
			\pl1,Pxrand(~list,inf),
\angle_rot,Pseq(~angle.mirror,inf),
	\speed1,Prand([1,3/4,2/3,1/2],inf),
		\speed2,Prand([1,3/4,2/3,1/2],inf),
		\speed3,Prand([1,3/4,2/3,1/2],inf);
));
~cc=Pdef(\3, Pbind(\instrument, \ospace3,
	\dur,Pseq(~dur3.mirror,1),
			//\octave,Prand([1,2,4],inf),
			\pl1,Pxrand(~list,inf),
	\angle_rot,Pseq(~angle.mirror,inf),
	\speed1,Prand([1,3/4,2/3,1/2],inf),
		\speed2,Prand([1,3/4,2/3,1/2],inf),
		\speed3,Prand([1,3/4,2/3,1/2],inf);
));

	);
	TempoClock.default.tempo_(1/1);
/////with tempo 1 and time 1 overall duration of a is 2.08 min

//s.record(numChannels:4);
	/////////////////////scales
//Scale.directory;

		//	s.record(numChannels:4);

	(
Tdef.new(\h,{
//loop({
			(1).wait;
//s.record(numChannels:4);
			(1).wait;
~aa.play;
~bb.play;
~cc.play;
s.record;
			(1).wait;
//s.stopRecording
//	})
})
);



//Tdef(\h).stop;
//Tdef(\h).play;
//Tdef(\h).clear;

}
)
