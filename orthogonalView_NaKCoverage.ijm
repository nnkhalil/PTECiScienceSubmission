fileLocation = getDirectory("Please select the chip folder");
fileName = "";

//run("Concatenate...", "all_open open"); 
run("Split Channels");

//Get max intensity projection of the orthogonal view for each channel
selectWindow("C1-" + fileName + ".nd2")
run("Reslice [/]...", "output=0.200 start=Left avoid");
run("Z Project...", "projection=[Max Intensity]");
run("Convert to Mask");
saveAs("Tiff", fileLocation + "/Composite_nuclei.tif");

selectWindow("C2-" + fileName + ".nd2");
run("Reslice [/]...", "output=0.200 start=Left avoid");
run("Z Project...", "projection=[Max Intensity]");
run("Convert to Mask");
saveAs("Tiff", fileLocation + "/Composite_cilia.tif");

selectWindow("C3-" + fileName + ".nd2");
run("Reslice [/]...", "output=0.200 start=Left avoid");
run("Z Project...", "projection=[Max Intensity]");
run("Convert to Mask");
run("Invert");
saveAs("Tiff", fileLocation + "/Composite_NaK_ATPase.tif");

//From C2 (ZO-1), rotate and plot profile to get pixel intensity over the Y dimension
selectWindow("Composite_NaK_ATPase.tif");
run("Rotate 90 Degrees Left");
run("Select All");
run("Plot Profile");

//Save data to csv
Plot.getValues(xpoints, ypoints);
for (j=0; j<xpoints.length; j++){
	setResult("Distance", j, xpoints[j]);
	setResult("Gray Value", j, ypoints[j]);
	updateResults();
}

saveAs("Results", fileLocation + "/Results_NaK_ATPase.csv");
run("Clear Results");
