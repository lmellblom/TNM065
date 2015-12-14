<?php 
	//put XML content in a string
	$xmlstr=ob_get_contents();
	ob_end_clean();
	
	// Load the XML string into a DOMDocument
	$xml = new DOMDocument;
	$xml->loadXML($xmlstr);
	
	// Make a DOMDocument for the XSL stylesheet
	$xsl = new DOMDocument;
	
	// See which user agent is connecting
	$UA = getenv('HTTP_USER_AGENT');
	if (preg_match("/iPhone/", $UA) | preg_match("/Android/", $UA) | preg_match("/Symbian/", $UA) | preg_match("/Opera/", $UA) | preg_match("/Motorola/", $UA) | preg_match("/Nokia/", $UA) | preg_match("/Siemens/", $UA) | preg_match("/Samsung/", $UA) | preg_match("/Ericsson/", $UA) | preg_match("/LG/", $UA) | preg_match("/NEC/", $UA) |preg_match("/SEC/", $UA) |preg_match("/MIDP/", $UA) | preg_match("/Windows CE/", $UA)) 
	{
		header("Content-type:text/html;charset=utf-8");
		$xsl->load('index-mobile.xsl');
	} 
	else 
	{
		// if not a mobile phone, use a html stylesheet
		header("Content-type:text/html;charset=utf-8");
		$xsl->load('index.xsl');
	}
	
	// Make the transformation and print the result
	$proc = new XSLTProcessor;
	$proc->importStyleSheet($xsl); // attach the xsl rules
	echo ($proc->transformToXML($xml)); // om å,ä,ö inte funkar, testa lägg till/ta bort utf8_decode efter echo
	?>
