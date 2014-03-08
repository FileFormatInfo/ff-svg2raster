<html>
<head>
<title>svg2raster</title>
</head>
<body>
<form action="convert.jsp"	enctype="multipart/form-data" method="post" name="theForm">
<table class="dataentry">
	<tr>
		<th colspan="2">SVG Image Conversion</th>
	</tr>
	<tr>
		<td valign="top">Source file</td>
		<td><input name="stdin" type="file" /><br/><img height="20" width="20" style="vertical-align:middle;" border="0" src="/images/20x20/caution.png" alt="Warning" title="Warning" /> Maximum upload size is 5 MB</td>
	</tr>
	<tr>
		<td valign="top">Convert to</td>
		<td>
			<input type="radio" id="target_jpeg" name="target" value="jpeg"/><label for="target_jpeg"> JPEG</label><br/>
			<input type="radio" id="target_png" name="target" value="png" checked="checked"/><label for="target_png"> PNG</label><br/>
			<input type="radio" id="target_tiff" name="target" value="tiff" /><label for="target_tiff"> TIFF</label>
		</td>
	</tr>
	<tr>
		<td>Height</td>
		<td><input type="text" name="height" maxlength="5" size="10" /> (can be left blank)</td>
	</tr>
	<tr>
		<td>Width</td>
		<td><input type="text" name="width" maxlength="5" size="10" /> (can be left blank)</td>
	</tr>
	<tr>
		<td>Quality (JPEG only)</td>
		<td><select name="quality"><option value="10">10 (best compression)</option><option value="20">20</option><option value="30">30</option><option value="40">40</option><option value="50">50</option><option value="60">60</option><option value="70">70</option><option value="80" selected="selected">80 (recommended)</option><option value="90">90</option><option value="100">100 (best quality)</option></select></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>
			<input type="submit" name="save" value="Submit"/>
			<input type="submit" name="cancel" value="Cancel" />
		</td>
	</tr>
</table>
</form>
</body>
</html>
