$fn = 100;
h_main = 12;
h_wall = 3;
screw_depth = 10;
screw_box = 39;
screw_d = 3.0;
screw_offset = 3; 

shaft_d = 4.0;

gearbox_h1=5.5;
gearbox_h2=15;
gearbox_d1=27.2;
gearbox_d2=38.2;

brackets_z_offset=1.5;
brackets_w=screw_box + 2 * 11;

use <MCAD/shapes.scad>

//screw offset
ofst = screw_box/2;
ofsz = h_main-screw_depth;

module screw() {
    translate([0,0,-h_main/2]) cylinder(h = h_main*3, r = screw_d/2);
}

module big_bearing_holder(add_height=2, add_d=0) {
    //bearing holder outer
    translate([0,0,-h_wall-1.5]) 
    cylinder(h=h_wall+add_height, r=(22+h_wall+add_d)/2);
}

module gearbox() {
difference() {
    h_gb = gearbox_h2 + gearbox_h1 + h_wall;
    union() {
        cylinder(h = h_gb, r = 44/2);
        cylinder(h = h_gb+1, r = 41/2);
        translate([0,0,h_gb/2]) roundedBox(width = screw_box, 
            height = screw_box, depth = h_gb, radius = h_wall);
        
        big_bearing_holder();
    }
    
    // gearbox inner wide
    translate([0,0,h_wall+gearbox_h1]) cylinder(h = 50, r = gearbox_d2/2);
    
    // screws & spacers
    screw_holder_space=2.5;
    screw_d_space=screw_d+5.5;
    screw_space = (gearbox_h2 + gearbox_h1) - screw_holder_space*2 - 1;
    translate([ofst-screw_offset,ofst-screw_offset,ofsz]) {
        screw();
        translate([1,1,screw_holder_space]) cylinder(h=screw_space, r=screw_d_space/2);
    }
    translate([ofst-screw_offset,screw_offset-ofst,ofsz]) {
        screw();
        translate([1,-1,screw_holder_space]) cylinder(h=screw_space, r=screw_d_space/2);
    }
    translate([screw_offset-ofst,ofst-screw_offset,ofsz]) {
        screw();
        translate([-1,1,screw_holder_space]) cylinder(h=screw_space, r=screw_d_space/2);
    }
    translate([screw_offset-ofst,screw_offset-ofst,ofsz]) {
        screw();
        translate([-1,-1,screw_holder_space]) cylinder(h=screw_space, r=screw_d_space/2);
    }
    
    
    //bearing
    translate([0,0,-h_wall-0.5]) cylinder(h = 50, r = 22.2/2);
    translate([0,0,-h_wall-3]) cylinder(h = 50, r = 10.2/2);
    
    // gearbox inner container
    translate([0,0,h_wall]) cylinder(h = 50, r = gearbox_d1/2);
    // gearbox connector
    translate([ofst-5/2,-5/2,h_gb]) cube(size = 5);
    translate([0,0,h_gb]) cylinder(h = 5, r = 39.1/2);
    
    //bootom wall difference
    translate([0,0,-0.1]) difference(){
        cylinder(h=brackets_z_offset+0.1,r=32);
        translate([0,0,brackets_z_offset/2]) 
            roundedBox(width = screw_box, height = screw_box, 
            depth = brackets_z_offset+0.1, radius = h_wall);
    }
}
}

//Top box
module topbox(z_offset=-22){
translate([0,0,z_offset]) {
    difference () {
    w = screw_box + 3;
    h = h_wall + h_main + 7;
    union () {
        //top wall
        translate([0,0,h_wall/2]) roundedBox(width = w, 
            height = w, depth = h_wall, radius = h_wall);
        //bottom wall
        translate([0,0,h-h_wall/2-0.75]) 
            roundedBox(width=w, height=w, depth=h_wall+1.5, radius=h_wall);
        //stand1
        //translate([ofst-screw_offset,ofst-screw_offset,h/2]) 
        //roundedBox(width = h_wall*3, 
        //    height = h_wall*3, depth = h, radius = h_wall);
        //wall1
        translate([ofst-screw_offset,0,h/2]) 
        roundedBox(width = h_wall*3, 
            height = w, depth = h, radius = h_wall);
        //wall2
        translate([screw_offset-ofst,0,h/2]) 
        roundedBox(width = h_wall*3, 
            height = w, depth = h, radius = h_wall);
        
        //bearing_h
        translate([0,0,-3.5]) cylinder(h = 5, r = 12);
        
        mirror([0,0,-1]) translate([0,0,z_offset]) brackets();
    }
    
    //srews
    translate([ofst-screw_offset,ofst-screw_offset,ofsz]) screw();
    translate([ofst-screw_offset,screw_offset-ofst,ofsz]) screw();
    translate([screw_offset-ofst,ofst-screw_offset,ofsz]) screw();
    translate([screw_offset-ofst,screw_offset-ofst,ofsz]) screw();
    
    // screw space
    outer_d=24; inner_d=15;
    screw_space=h - h_wall*2 - 1.5;
    translate([outer_d,0,h_wall]) difference() {
        cylinder(h=screw_space,r=outer_d);
        cylinder(h=screw_space,r=inner_d);
    }
    
    // inner circle
    translate ([0,0,h_wall+0.01]) difference() {
        cylinder(h = h-h_wall*2-1.5, r = 18);
        translate([outer_d,0,0]) cube([outer_d+5,50,h*2], center = true);
    }
    translate([0,0,-z_offset-h_main-2.5]) big_bearing_holder(17.5, 1);
    
    //top bearing
    translate([0,0,-2.5]) cylinder(h = 10, r = 13.2/2);
    translate([0,0,-5]) cylinder(h = 10, r = 8/2);
    
    //bootom wall difference
    translate([0,0,-z_offset-brackets_z_offset]) difference(){
        cylinder(h=brackets_z_offset+0.1,r=32);
        translate([0,0,brackets_z_offset/2]) 
            roundedBox(width = screw_box, height = screw_box, 
            depth = brackets_z_offset+0.1, radius = h_wall);
    }
    
    //asd
    translate([0,0,-z_offset]) cube([10,100,10], center=true);
    
    }
}
}

module shaft(distance = -18){
translate([0,0,distance]) difference() {
    hole_d = 12;
    h = 21;
    h2 = 6.5;
    union (){
        cylinder(h = h, r = 10/2-0.2);
        
        rh=9;
        ds=1.2;
        cylinder(h = 13, r = rh);
        
        fnn=25; sh=0.4; offs=0.5;
        cylinder(h=offs,r=rh+ds*3,$fn=fnn);
        translate ([0,0,offs]) cylinder(h=0.5,r=rh+ds*3,$fn=fnn);
        translate ([0,0,offs+0.5]) cylinder(h=0.5,r=rh+ds*2,$fn=fnn);
        translate ([0,0,offs+1]) cylinder(h=0.5,r=rh+ds,$fn=fnn);
        
        offs2=offs+1.5+2;
        translate ([0,0,offs2]) cylinder(h=sh,r=rh+ds,$fn=fnn);
        translate ([0,0,offs2+sh]) cylinder(h=sh,r=rh+ds*2,$fn=fnn);
        translate ([0,0,offs2+sh*2]) cylinder(h=sh,r=rh+ds*2,$fn=fnn);
        translate ([0,0,offs2+sh*3]) cylinder(h=sh,r=rh+ds,$fn=fnn);
        
        offs3=offs2+4;
        translate ([0,0,offs3]) cylinder(h=sh,r=rh+ds,$fn=fnn);
        translate ([0,0,offs3+sh]) cylinder(h=sh,r=rh+ds*2,$fn=fnn);
        translate ([0,0,offs3+sh*2]) cylinder(h=sh,r=rh+ds*2,$fn=fnn);
        translate ([0,0,offs3+sh*3]) cylinder(h=sh,r=rh+ds,$fn=fnn);

        offs4=offs3+4;
        translate ([0,0,offs4]) cylinder(h=0.5,r=rh+ds,$fn=fnn);
        translate ([0,0,offs4+0.5]) cylinder(h=0.5,r=rh+ds*2,$fn=fnn);
        translate ([0,0,offs4+1]) cylinder(h=0.5,r=rh+ds*3,$fn=fnn);
        
        //belt dbg
        //%translate ([0,0,0.5]) cylinder(h=12,r=13);
        
        translate([0,0,h]) intersection() {
            cylinder(h = h2, r = 7.9/2);
            cube([5.9,8,h2*2], center = true);
        }
    }
    
    translate([0,0,-5]) cylinder(h = 40, r = shaft_d/2);
}
}

module brackets() translate([0,0,brackets_z_offset]) {
color("olive") difference() {
    union() {
        translate([0,ofst-screw_offset,h_wall/2])
         roundedBox(width = brackets_w, 
         height = h_wall*3, depth = h_wall, radius = h_wall);
        translate([0,screw_offset-ofst,h_wall/2])
         roundedBox(width = brackets_w, 
         height = h_wall*3, depth = h_wall, radius = h_wall);
    }
    
    //inner srews
    translate([ofst-screw_offset,ofst-screw_offset,ofsz]) screw();
    translate([ofst-screw_offset,screw_offset-ofst,ofsz]) screw();
    translate([screw_offset-ofst,ofst-screw_offset,ofsz]) screw();
    translate([screw_offset-ofst,screw_offset-ofst,ofsz]) screw();
    
    //outer srews
    ofstb=brackets_w/2-screw_offset/2;
    translate([ofstb-screw_offset,ofst-screw_offset,ofsz]) screw();
    translate([ofstb-screw_offset,screw_offset-ofst,ofsz]) screw();
    translate([screw_offset-ofstb,ofst-screw_offset,ofsz]) screw();
    translate([screw_offset-ofstb,screw_offset-ofst,ofsz]) screw();
    
    //inner circle
    translate([0,0,-0.5]) cylinder(h=h_wall+1,r=screw_box/2);
}
}

module hwall(h_gb, w, h, offset) {
    translate([screw_box-0.15,0,10.72])
    rotate(a=60, v=[0,-1,0])
    cube([h_gb,w,h], center = true);
    
    translate([h_gb*2-h_wall-2,0,h_gb-h_wall*1.5])
    roundedBox(width=h_wall*4,height=w,//screw_box+offset*1.5,
    depth=h,radius=h_wall);
}       
module holder() {
    offset=6;
    h=brackets_z_offset*2;
    w=screw_box+offset*1.5+h_wall+1;
    difference() {
        union() {
            cube([brackets_w+offset,w,h], center = true);
            
            h_gb = gearbox_h2 + gearbox_h1 + h_wall*2;
            hwall(h_gb, w, h, offset);
            mirror([1,0,0]) hwall(h_gb, w, h, offset);
            
            dx=24.5;
            dy=h_gb/2 - h_wall + 0.75;
            translate([0,dx,dy]) 
            cube([brackets_w*1.5+1,h_wall,h_gb-1.5], center=true);
            translate([0,-dx,dy]) 
            cube([brackets_w*1.5+1,h_wall,h_gb-1.5], center=true);
        }

    
        //outer srews
        ofstb=brackets_w/2-screw_offset/2;
        translate([ofstb-screw_offset,ofst-screw_offset,ofsz]) screw();
        translate([ofstb-screw_offset,screw_offset-ofst,ofsz]) screw();
        translate([screw_offset-ofstb,ofst-screw_offset,ofsz]) screw();
        translate([screw_offset-ofstb,screw_offset-ofst,ofsz]) screw();
        
        //wall difference
        translate([45,0.25,3.8]) rotate(a=60, v=[0,-1,0])
        cube([30,w+1,14.5], center = true);
        mirror([1,0,0])
        translate([45,0.25,3.8]) rotate(a=60, v=[0,-1,0])
        cube([30,w+1,14.4], center = true);
        
        //screws
        dx=w-3;
        dy=ofst+1;
        translate([dx,dy,0]) screw();
        translate([dx,-dy,0]) screw();
        translate([-dx,dy,0]) screw();
        translate([-dx,-dy,0]) screw();
        
        //big_bearing_holder(17.5, 1);
        roundedBox(width = screw_box+0.5, height = screw_box+0.5, 
            depth = 5, radius = h_wall);
    }
}
    

module holder2() translate([0,0,25]) {
    difference() {
        union() {
            roundedBox(width = screw_box*2+30, height = screw_box+13+h_wall*2, 
            depth = h_wall, radius = h_wall);
            
            translate([-24,0,50]) rotate(a=90, v=[0,1,0])
            roundedBox(width = screw_box*2+30, height = screw_box+13+h_wall*2,
            depth = h_wall, radius = h_wall);
            translate([-24+h_wall,0,68]) rotate(a=90, v=[0,1,0])
            roundedBox(width = screw_box*2-6, height = screw_box+13+h_wall*2,
            depth = h_wall, radius = h_wall);
            translate([-22.3,0,30.2])
            rotate(a=30,v=[0,1,0]) 
            cube([h_wall,55,h_wall*2], center=true);
            
            translate([-23,26,1]) 
            rotate(a=90,v=[1,0,0])
            linear_extrude(height=h_wall*2, center=true)
            polygon([[0,100],[70,0],[0,0]]);
            
            mirror([0,1,0]) translate([-23,26,1]) 
            rotate(a=90,v=[1,0,0])
            linear_extrude(height=h_wall*2, center=true)
            polygon([[0,100],[70,0],[0,0]]);
        }
        translate([7,0,0]) roundedBox(width = screw_box*1.5, height = 45, 
        depth = h_wall+1, radius = h_wall);
        
        translate([0,0,-501.5]) cube([1000,1000,1000], center=true);
        
        //screws
        offset=6;
        w=screw_box+offset*1.5+h_wall+1;
        dx=w-3;
        dy=ofst+1;
        translate([dx,dy,0]) screw();
        translate([dx,-dy,0]) screw();
        translate([-dx,dy,0]) screw();
        translate([-dx,-dy,0]) screw();
    }
}

tooth_l=31.5;
tooth_w1=21;
tooth_w2=18;
tooth_h=13+h_wall;


module wheel_tooth() {
    dw=(tooth_w1-tooth_w2)/2;
    r=6;
    translate([-tooth_w1/2,0,0])
    linear_extrude(height=tooth_h)
    offset(r=r)
    polygon([[r,r],[dw+r,tooth_l-r],
    [dw+tooth_w2-r,tooth_l-r],[tooth_w1-r,r]]);
    
    //// равнобедренный треугольник \ закругление внутри
    //// a — длина равных боковых сторон
    //// b — длина основания
    //// h — высота к основанию
    //// R — радиус описанной окружности
    // orig angle=75
    cab=(180-90)/2; // (180-75)/2 | α
    hbc=37.5; // 75/2       | β/2
    // a = b / (2 cos α)
    b = 25;
    a = b / (2 * cos(cab));
    h = sqrt(4*(a^2) - (b^2))/2;
    //echo("a=",a," b=",b," h=",h," ==", asd  );
    linear_extrude(height=tooth_h)
    translate([-14.6,20.15,0])
    rotate(a=126,v=[0,0,1])
    offset(r=-5)
    polygon([[-20,0],[0,b/2],[h,b/2],[0,0]
    ,[h,-b/2],[0,-b/2] ]);
}
module wheel_tooths() {
    wheel_tooth();
    rotate(a=72,v=[0,0,1]) wheel_tooth();
    rotate(a=72*2,v=[0,0,1]) wheel_tooth();
    rotate(a=72*3,v=[0,0,1]) wheel_tooth();
    rotate(a=72*4,v=[0,0,1]) wheel_tooth();
}
module wheel_gear() {
    difference() {
        union(){
            cylinder(h = tooth_h, r = 34);
            
            rotate(a=90,v=[0,0,0])
            rotate_extrude()
            translate([33.75,0,0])
            polygon([
            [0,0],[4,0],[4,1],[0,2.5],[0,3.5]
            ,[3,4.5],[3,5],[0,6]
            ,[0,7.5],[3,8.5],[3,9],[0,10]
            ,[0,11.5],[4,13],[4,13.5],[0,15]
            ]);
        }
        translate([0,0,h_wall])
        wheel_tooths();
        
        translate([0,0,-1]) cylinder(h=tooth_h, r=14.2/2);
    }
}

module wheel_holder() {
    h1=30;
    l1=35;
    hw=5;
    difference() {
        union(){
            cylinder(h=h1, r = 8);
            
            translate([0,6,0])
            rotate([0,-90,0])
            linear_extrude(height=hw)
            polygon([[0,0],[h1,0],[0,l1]]);
            
            translate([-6,2.5,0])
            rotate([90,-90,0])
            linear_extrude(height=hw)
            polygon([[0,0],[h1,0],[0,l1]]);
            
            linear_extrude(height=h_wall)
            polygon([[0,0],[-l1,0],[0,l1]]);
        }
        translate([0,0,-0.5])cylinder(h=h1+1, r = 5.2);
    }
}


//gearbox();  brackets();
//holder();
//holder2();
//topbox();
//shaft();

//wheel_gear();
//wheel_holder();
difference() {
    h1=1;
    cylinder(h=h1, r = 8);
    translate([0,0,-0.5])cylinder(h=h1+1, r = 5.2);
    }

//distancer
//difference () { cylinder(h=2,r=37/2); translate([0,0,-1]) cylinder(h=10,r=32/2); }