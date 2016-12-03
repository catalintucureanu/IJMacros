image = getTitle;
print(image);
run("Duplicate...");
setAutoThreshold("Default");
setOption("BlackBackground", false);
run("Convert to Mask");
run("Analyze Particles...", "size=0.25-Infinity display clear include add");

run("Set Measurements...", "  centroid redirect=None decimal=9");
for (i=0 ; i<roiManager("count"); i++) {
    roiManager("select", i);
    roiManager("Measure");
    x = getResult("X",0);
   // x = x/1000000;
  //  y = getResult("Y",0);
//    sumxy = x+y ;
    roiManager("Rename", x);
    run("Clear Results");
}

roiManager("Sort");

for (i=0 ; i<roiManager("count"); i++) {
    roiManager("select", i);
    roiManager("Rename", i);
    run("Clear Results");
}

for (i=0 ; i<roiManager("count"); i++) {
    letter = "X";
    if (i < 4) {
    	letter = "A"; 
    } else if (i<8) {
    	letter = "B";
    } else if (i<12) {
    	letter = "C";
    } else if (i<16) {
    	letter = "D";
    } else if (i<20) {
    	letter = "E";
    } else if (i<30) {
    	letter = "F";
    } else if (i<35) {
    	letter = "G";
    } else if (i<40) {
    	letter = "H";
    }
    roiManager("select", i);
    roiManager("Measure");
    prevname = call("ij.plugin.frame.RoiManager.getName", i);
    y = getResult("Y",0);
  	//y=y/1000000;
  	roiManager("Rename", letter+"-"+y);
  	//print(prevname+"-"+y);
    run("Clear Results");
}

roiManager("Sort");

for (i=0 ; i<roiManager("count"); i++) {
	    letter = "X";
    if (i < 4) {
    	letter = "A"; 
    } else if (i<8) {
    	letter = "B";
    } else if (i<12) {
    	letter = "C";
    } else if (i<16) {
    	letter = "D";
    } else if (i<20) {
    	letter = "E";
    } else if (i<60) {
    	letter = "F";
    } else if (i<70) {
    	letter = "G";
    } else if (i<80) {
    	letter = "H";
    }
    roiManager("select", i);
    roiManager("Rename", letter+(i/10));
    run("Clear Results");
}

roiManager("Sort");

slices = 1;
for (i=0 ; i<roiManager("count"); i++) {
	selectWindow(image);
	roiManager("select", i);
	slicename = call("ij.plugin.frame.RoiManager.getName", i);
	print(slicename);
	print(roiManager("count"));
	run("Specify...", "width=650 height=450");
	run("Copy");
	run("Internal Clipboard");
	print(slices);
	if (slices < 2) {
	run("Concatenate...", "  title=[RoiStack] image1=Clipboard image2=Clipboard image3=[-- None --]");
	print("First");
	slices = slices+1;
	} else if (slices >= 2) {
	run("Concatenate...", "  title=[RoiStack] image1=RoiStack image2=Clipboard image3=[-- None --]");	
	slices = slices+1;
	}

	setMetadata("Label", slicename); 
		
}

//setSlice(1);
//run("Delete Slice");

