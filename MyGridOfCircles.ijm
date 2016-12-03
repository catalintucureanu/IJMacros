x = 2;
y = 11;
width = 11;
height = 11;
spacing = 1;
numRow = 18;
numCol = 21;
run("Duplicate...", "duplicate");
run("Gaussian Blur...", "sigma=2 stack");

for (fSlice = 1; fSlice <= nSlices; fSlice++) {
setSlice(fSlice);
for(i = 0; i < numRow; i++)
{
	for(j = 0; j < numCol; j++)
	{
		xOffset = j * (width + spacing);
		//print(xOffset);
		yOffset = i * (height + spacing);
		//print(yOffset);
		makeRectangle(x + xOffset, y + yOffset, width, height);
			//	roiManager("Add");
		getRawStatistics(nPixels, mean, min, max); 
		smax=max*0.01;
		//print(smax);
		run("Find Maxima...", "noise="+smax+" output=[Point Selection]");
		//getSelectionBounds(x, y, w, h); 
		run("Specify...", "width=10 height=10 oval centered");
		roiManager("Add");
		if (roiManager("count") > 13392)
			{
			print("Maximum reached:  entries have been created.");
			exit;
			}
	}		
}
}
    run("Clear Results");
    close();

run("Set Measurements...", "mean standard modal min integrated median stack redirect=None decimal=9");
	roiManager("Deselect");
	roiManager("Measure");

