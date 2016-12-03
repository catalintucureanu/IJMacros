x = 5;
y = 2;
width = 10;
height = 10;
spacing = 2;
numRow = 5;
numCol = 7;
run("Duplicate...", "duplicate");
run("Gaussian Blur...", "sigma=2 stack");

for (fSlice = 1; fSlice <= nSlices; fSlice++);
for(i = 0; i < numRow; i++)
{
	for(j = 0; j < numCol; j++)
	{
		xOffset = j * (width + spacing);
		print(xOffset);
		yOffset = i * (height + spacing);
		print(yOffset);
		makeRectangle(x + xOffset, y + yOffset, width, height);
		run("Find Maxima...", "noise=10 output=[Point Selection]");
		run("Specify...", "width=10 height=10 oval centered");
		roiManager("Add");
		if (roiManager("count") > 35)
			{
			print("Maximum reached: 35 entries have been created.");
			exit;
			}
	}		
}
    run("Clear Results");

run("Set Measurements...", "mean standard modal min integrated median stack redirect=None decimal=9");
slice = 1;
for(i = 0; i <= nSlices; i++) {

	setSlice(slice);
	roiManager("Deselect");
	roiManager("Measure");
	slice=slice+1;
}
