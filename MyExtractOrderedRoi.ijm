image = getTitle;
print(image);
x = 220;
y = 220;
width = 750;
height = 750;
//spacing = 185;
Hspacing = 930;
Vspacing = 900;
numRow = 8;
numCol = 2;

for(i = 0; i < numRow; i++)
{
	for(j = 0; j < numCol; j++)
	{
		xOffset = j * Hspacing;
		print(xOffset);
		yOffset = i * Vspacing;
		print(yOffset);
		makeRectangle(x + xOffset, y + yOffset, width, height);
		roiManager("Add");
		roiManager("select", roiManager("count")-1);
		roiManager("Rename", image+"."+i+1+"."+j+1);
		if (roiManager("count") > numRow*numCol)
			{
			print("Maximum reached: all entries have been created.");
			exit;
			}
	}		
}
    run("Clear Results");


slices = 1;
for (i=0 ; i<roiManager("count"); i++) {
	selectWindow(image);
	roiManager("select", i);
	slicename = call("ij.plugin.frame.RoiManager.getName", i);
	//run("Specify...", "width=350 height=350");
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


/* run("Set Measurements...", "mean standard modal min integrated median stack redirect=None decimal=9");
slice = 1;
for(i = 0; i <= nSlices; i++) {

	setSlice(slice);
	roiManager("Deselect");
	roiManager("Measure");
	slice=slice+1;
}
*/