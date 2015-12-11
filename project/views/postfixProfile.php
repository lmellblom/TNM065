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
	if (preg_match("/Symbian/", $UA) | preg_match("/Opera/", $UA) | preg_match("/Nokia/", $UA)) 
	{
		// if a mobile phone, use a wml stylesheet and set appropriate MIME type
		header("Content-type:text/vnd.wap.wml");
		$xsl->load('index-wml.xsl');
	} 
	else 
	{
		// if not a mobile phone, use a html stylesheet
		header("Content-type:text/html;charset=utf-8");
		$xsl->load('profile.xsl');
	}
	
	// Make the transformation and print the result
	$proc = new XSLTProcessor;
	$proc->importStyleSheet($xsl); // attach the xsl rules
	echo ($proc->transformToXML($xml));
	?>

