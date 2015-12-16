<?php 
	//put XML content in a string
	$xmlstr=ob_get_contents();
	ob_end_clean();
	
	// Load the XML string into a DOMDocument
	$xml = new DOMDocument;
	$xml->loadXML($xmlstr);
	
	// Make a DOMDocument for the XSL stylesheet
	$xsl = new DOMDocument;
	
	// if not a mobile phone, use a html stylesheet
	header("Content-type:text/html;charset=utf-8");
	$xsl->load('xmltojson.xsl');
	
	// Make the transformation and print the result
	$proc = new XSLTProcessor;
	$proc->importStyleSheet($xsl); // attach the xsl rules
	echo ($proc->transformToXML($xml)); // om å,ä,ö inte funkar, testa lägg till/ta bort utf8_decode efter echo
	?>
