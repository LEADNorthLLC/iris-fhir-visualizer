Class FHIR.Visualizer.REST.Transform Extends %CSP.REST
{

/** Change Log
2024-01-20 - Chi Nguyen-Rettig : Created
**/
/// Require Cross-origin resource sharing handling.
/// /// <BR> Mapped through DataQuality.DQ.Prd.REST.ServiceMap
/// <BR> PREFIX:  /Transform
/// <BR> EXAMPLES:
/// <BR> 	Method:POST
/// <BR> 	URL: http://localhost:57773/csp/visualizer/service/transform
/// <BR> 
Parameter HandleCorsRequest = 1;

/// Use Session for REST Services
Parameter UseSession = 1;

XData UrlMap
{
<Routes>
	<!-- <Route Url="/Transform" Method="POST" Call="TransformCCDA" /> -->
</Routes>
}

/// Handle Cross-origin resource sharing
ClassMethod OnHandleCorsRequest(pURL As %String) As %Status
{
	
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException
    
    #dim %request As %CSP.Request
    #dim %response As %CSP.Response
    
    #dim tOrigin,tHeaders,tMethod As %String
    
    Try {
        
        #; Get the origin
        Set tOrigin=$Get(%request.CgiEnvs("HTTP_ORIGIN"))
        
        set tRestrictCORS=$GET(^DQAT.RESTRICTCORS,0) 
		set tAllowedOrigin=$GET(^DQAT.ALLOWEDORIGIN,"http://localhost:57773") 
		if ((tAllowedOrigin=tOrigin) || (tRestrictCORS=0))
		{       
	        #; Allow requested origin
	        Do ..SetResponseHeaderIfEmpty("Access-Control-Allow-Origin",tOrigin)
	       
	        #; Set allow credentials to be true
	        Do ..SetResponseHeaderIfEmpty("Access-Control-Allow-Credentials","true")
	        
	        #; Allow requested headers
	        Set tHeaders=$Get(%request.CgiEnvs("HTTP_ACCESS_CONTROL_REQUEST_HEADERS"))
	        Do ..SetResponseHeaderIfEmpty("Access-Control-Allow-Headers",tHeaders)
	        
	        #; Allow requested method
	        Set tMethod=$Get(%request.CgiEnvs("HTTP_ACCESS_CONTROL_REQUEST_METHOD"))
	        Do ..SetResponseHeaderIfEmpty("Access-Control-Allow-Methods",tMethod)
		}
        
    } Catch (e) {
        Set tSC=e.AsStatus()
    }
    Quit tSC
}

/// Invoke the Transform service with input stream
/// Complete a batch. 
/// <BR> INPUT
/// <BR> 		
/// <BR> OUTPUT
/// <BR> 		FHIR.VisualizerModel.Record
ClassMethod TransformCCDA() As %Status
{
	Set tSC = $$$OK
	Try {
		
		#;Dispatch request to production
		#Dim tResponse as FHIR.Visualizer.Model.Record

		Set pRequest = ##class(FHIR.Visualizer.Model.Record).%New()
		#;CNR: Need to grab input stream off of the request and copy it to pRequest object
		
		#dim oStream As %Stream.GlobalCharacter = ##class(%Stream.GlobalCharacter).%New()
		
		set Body = %request.ContentGet()
		
		do oStream.CopyFrom(Body)
		set ^zJStatus=Body
		Set pRequest.CCDAContentXML=oStream
		set ^zJStatus="Calling Transform"
		//$$$ThrowOnError(##class(FHIR.Visualizer.REST.Service.TransformService).TransformCCDAToSDA(pRequest, .tResponse))
		Set mapper = ##class(FHIR.Visualizer.Util.Mapper).%New()
		//Run XSL transform against CCDA Body
		//Sample Use case #1: Replace value at patientRole/id/@root inside the CCDA body
		
		
		$$$ThrowOnError(mapper.ConsumeDocument(Body, .SDAResult))
		
		set ^zJStatus=SDAResult.Read()
		do SDAResult.Rewind()
		
		Set tResponse = ##class(FHIR.Visualizer.Model.Record).%New()
		set tResponse.SDAContentXML = SDAResult

		//If $$$ISERR(tResponse.Status) {
		//	Set %response.Status = ..#HTTP500INTERNALSERVERERROR
		//}
		//Set tResponse.Status = ""
		
		#;Write response
		Set %response.ContentType="application/xml"
		$$$ThrowOnError(tResponse.XMLExportToStream(.tStream))
		
		
		//If $Get(%request.CgiEnvs("HTTP_ACCEPT"),"*/*") [ "application/xml" {
		//	Set %response.ContentType="application/xml"
		//	$$$ThrowOnError(tResponse.XMLExportToStream(.tStream))
		//} 
		//Else {
		//	Set %response.ContentType="application/json"
		//	#;Write output 
		//	Set tStream=##class(%Stream.GlobalCharacter).%New()		
		//	$$$ThrowOnError(##class(HS.Local.Visualizer.Model.Record).toJSON(tResponse, .tStream))
		//}
		

		Do tStream.OutputToDevice()
	}
	Catch Ex {
		Set tSC = Ex.AsStatus()
		
		Set %response.Status = ..#HTTP500INTERNALSERVERERROR
		set ^zJStatus=tSC
		Set tSC = $$$OK
	}
	Quit tSC
}

}
