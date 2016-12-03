image = getTitle;
if (endsWith(image, ".tif")){
 image = substring(image, 0, lengthOf(image)-4);
}
print(image);
run("Duplicate...", "title="+image+"d duplicate");
image=image+"d";
slices = nSlices;
run("Stack to Images");
selectWindow(image+"-0001");
run("Duplicate...", "title=reference duplicate");
for(i=1; i < slices; i++) {
	if (i < 9) {
		sl = "0"+i;
		a = i+1;
		sl2 = "0"+a;
	} 
		if (i == 9) {
		sl = "0"+i;
		a = i+1;
		sl2 = a;
	} 
	if (i >=10) {
		sl = i;
		a = i+1;
		sl2 = a;
	}
print(sl);
selectWindow("reference");
roiManager("Select", 0);
//run("Line to Area");
//run("Area to Line");
selectWindow(image+"-00"+sl2);
roiManager("Select", i);
//run("Line to Area");
//run("Area to Line");

run("Align Image by line ROI", "source="+image+"-00"+sl2+" target=reference rotate");
rename("aligned" + image+"-00"+sl2);
run("16-bit");
if ( i == 1 ) {
run("Concatenate...", "  title=Aligned_"+image+" image1="+image+"-00"+sl+" image2=aligned" + image+"-00"+sl2+" image3=[-- None --]");
}

if ( i > 1 ) {
run("Concatenate...", "  title=Aligned_"+image+" image1=Aligned_"+image+" image2=aligned" + image+"-00"+sl2+" image3=[-- None --]");
}
selectWindow(image+"-00"+sl2);
close();
}
