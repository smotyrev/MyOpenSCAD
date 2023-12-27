$fn=100;

module shaft(){
shaft_d = 3.2;
translate([0,0,11 + 5])
mirror([0,0,1]) difference() {
    hole_d = 12;
    _h = 5;
    union (){
        difference() {
            cylinder(h=_h+6,r=7);
            translate([0,0,-0.01])
            intersection() {
                cylinder(h = _h, r = 8.1/2);
                cube([5.9,8.1,_h*2], center = true);
            }
        }
    }
    
    translate([0,0,-5]) cylinder(h = 40, r = shaft_d/2);
}
}

h_offset=15;
h1=h_offset+7+40;
inner_d=36;
outer_d=42;
inner_d2=inner_d-7;
module box(){
//
translate([0,0,-h_offset])
difference(){
    cylinder(h=h1,d=outer_d);
    translate([0,0,-0.1])
    cylinder(h=h_offset+0.2,d=inner_d);
    translate([0,0,0.1]) cylinder(h=h1,d=inner_d2);
}
difference(){
    cylinder(h=4,d=inner_d+1);
    _h=4.2;
    _d=3.5;
    translate([0,0,-0.1])   cylinder(h=_h,d=16);
    translate([13,0,-0.1])  cylinder(h=_h,d=_d);
    translate([0,13,-0.1])  cylinder(h=_h,d=_d);
    translate([-13,0,-0.1]) cylinder(h=_h,d=_d);
    translate([0,-13,-0.1]) cylinder(h=_h,d=_d);
}
//
}

module cap() {
//
translate([0,0,h1-20])
difference(){
    _h1=14;
    _h2=4;
    union(){
        cylinder(h=_h1+_h2,d=inner_d2-1);
        translate([0,0,_h1])cylinder(h=_h2,d=outer_d);
    }
    translate([0,0,-0.1])cylinder(h=12,d=19.3);
    cylinder(h=50,d=13);
}
//
}

difference(){
    union(){
        //shaft();
        //box();
        cap();
    }
    //translate([0,0,-50]) cube(200);
}

