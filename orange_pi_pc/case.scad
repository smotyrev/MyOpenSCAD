$fn=100;

//box
x=64.1;
y=94;
z=30;
w=1.2; //wall

//holes
xs=6.35;
ys=4.95;
hs=3;
ds=3.2;
dso=6;

//translate([3.88,-1,0.8]) import("opi.stl"); //stl
mirror([0,1,0]) {
difference() {
union() {
difference() {
    translate([-w,-w,-w]) cube([x+w,y+w,z+w]);
    cube([x-w,y-w,z+w]);
}

translate([xs,ys,0]) cylinder(hs,d=dso,false);
translate([xs+50.5,ys,0]) cylinder(hs,d=dso,false);
translate([xs,ys+79.5,0]) cylinder(hs,d=dso,false);
translate([xs+50.5,ys+79.5,0]) cylinder(hs,d=dso,false);
}
translate([xs,ys,-w-1]) cylinder(hs*2,d=ds,false);
translate([xs+50.5,ys,-w-1]) cylinder(hs*2,d=ds,false);
translate([xs,ys+79.5,-w-1]) cylinder(hs*2,d=ds,false);
translate([xs+50.5,ys+79.5,-w-1]) cylinder(hs*2,d=ds,false);

//2usb hole
translate([11-w,y-10,5.5]) cube([14,20,17]);
//rj45 hole
translate([29.5-w,y-10,4.5]) cube([16,20,17]);
//1usb hole
translate([47.5-w,y-10,4.5]) cube([8,20,18]);
//sd card hole
translate([19.25-w,-w-1,-2]) cube([17.5,6+w+1,5]);

//grill
for(i = [0:5]) {
    translate([13,22+i*9,-2]) cube([15,2,10]);
    translate([35,22+i*9,-2]) cube([15,2,10]);
}

}
}