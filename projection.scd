

(
var position,angle=0,mx=3,my=3,n=0,thita;
var pos,magx,magy;
var position1,position2,thita1,thita2,n1=0,n2=0,mag1,mag2;
~angle=[];~magx=[];~magy=[];

360.do{

pos= 13.collect{

		thita = angle.degrad + ((pi/4)*2.pow(n/12));
		n=(n+1).mod(13);
		n.postln;
	position=exp(Complex(0,1)*thita).theta;

};

magx = 13.collect{

        thita1 = angle.degrad + ((pi/4)*2.pow(n1/12));
		n1=(n1+1).mod(13);
	position1=exp(Complex(0,1)*thita1).theta;

	mag1=(Complex(exp(Complex(0,1)*(position1.round(0.000001)*mx)).real,exp(Complex(0,1)*(position1.round(0.0001)*mx)).real).rho.round(0.0001)
		*Complex(exp(Complex(0,1)*(position1.round(0.000001)*mx)).real,exp(Complex(0,1)*(position1.round(0.0001)*mx)).real).rho).round(0.0001);

	};

magy = 13.collect{

	    thita2 = angle.degrad + ((pi/4)*2.pow(n2/12));
		n2=(n2+1).mod(13);
	position2=exp(Complex(0,1)*thita2).theta;

		mag2=(Complex(exp(Complex(0,1)*(position2.round(0.000001)*my)).imag,exp(Complex(0,1)*(position2.round(0.0001)*my)).imag).rho.round(0.0001)
		*Complex(exp(Complex(0,1)*(position2.round(0.000001)*my)).real,exp(Complex(0,1)*(position2.round(0.0001)*my)).real).rho).round(0.0001);

	};
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360); ~angle=~angle++pos;~magx=~magx++magx;~magy=~magy++magy;
	}
)

///////2d

(
var data;
var az=0,el=0;
var m=600,sph,az1,el1,pl=89,daz,del,harm,mag,r;
var r1,harm1,r2,harm2,rad,sph1;

data = (360*12).collect{

	az=~angle.[pl];
	//el=~el.[pl];
	mag=Complex(~magx.[pl]/(2.sqrt),~magy.[pl]/(2.sqrt)).rho/(2.sqrt);
	pl=pl+1;

	sph=Polar(mag*800,az);
	sph1=Cartesian(sph.x,sph.y,0).asArray;


};

w = Window.new("3D Scatterplot", Rect(40,40, 1000, 800)).front;
a = ScatterView3d(w, Rect(0,0, 800,800), data, [-1000, 1000].asSpec,[-1000, 1000].asSpec,[-1000, 1000].asSpec);
a.drawMethod = \fillRect;
a.symbolSize = 1;
a.symbolColor = Color.white;
a.background = Color.black;

// Y Slider
Slider(w, Rect(820, 10, 10, 450)).action_{|me|
    a.rotY = me.value * 2pi;
    w.refresh;
};
// X Slider
Slider(w, Rect(870, 10, 10, 450)).action_{|me|
    a.rotX = me.value * 2pi;
    w.refresh;
};
// Z Slider
Slider(w, Rect(920, 10, 10, 450)).action_{|me|
    a.rotZ = me.value * 2pi;
    w.refresh;
};
)
///3d

